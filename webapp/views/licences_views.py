from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib import messages
from django.utils import timezone
from django.db.models import Sum, Q
from webapp.models import PeriodoLicencia, HistorialConsumo, Empresa
from django.core.paginator import Paginator
from django import forms
from datetime import timedelta, date
from django.http import JsonResponse

class PeriodoLicenciaForm(forms.ModelForm):
    class Meta:
        model = PeriodoLicencia
        fields = ['empresa', 'tipo_periodo', 'fecha_inicio', 'fecha_fin', 
                  'hojas_licencia_periodo', 'storage_licencia_mb_periodo', 'activo']
        widgets = {
            'fecha_inicio': forms.DateInput(attrs={'type': 'date'}),
            'fecha_fin': forms.DateInput(attrs={'type': 'date'}),
            'empresa': forms.Select(attrs={'class': 'form-select'}),
            'tipo_periodo': forms.Select(attrs={'class': 'form-select'}),
            'hojas_licencia_periodo': forms.NumberInput(attrs={'class': 'form-control'}),
            'storage_licencia_mb_periodo': forms.NumberInput(attrs={'class': 'form-control'}),
            'activo': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            if not isinstance(field.widget, forms.CheckboxInput):
                field.widget.attrs.update({'class': 'form-control'})

    def clean(self):
        cleaned_data = super().clean()
        fecha_inicio = cleaned_data.get('fecha_inicio')
        fecha_fin = cleaned_data.get('fecha_fin')
        tipo_periodo = cleaned_data.get('tipo_periodo')
        
        if fecha_inicio and fecha_fin:
            if fecha_fin < fecha_inicio:
                self.add_error('fecha_fin', 'La fecha de fin debe ser posterior a la fecha de inicio.')
            
            # Validar coherencia del tipo de periodo con la duración
            if tipo_periodo == 'mensual':
                delta = fecha_fin - fecha_inicio
                if delta.days < 25 or delta.days > 32:  # Flexibilidad para meses con diferentes días
                    self.add_error('tipo_periodo', 'Para un periodo mensual, la duración debe ser de aproximadamente 30 días.')
            elif tipo_periodo == 'anual':
                delta = fecha_fin - fecha_inicio
                if delta.days < 350 or delta.days > 370:  # Flexibilidad para años bisiestos
                    self.add_error('tipo_periodo', 'Para un periodo anual, la duración debe ser de aproximadamente 365 días.')
        
        return cleaned_data

def es_admin(user):
    return user.is_superuser or (hasattr(user, 'perfil') and user.perfil and user.perfil.rol in ['superadmin', 'admin_empresa'])

@login_required
@user_passes_test(es_admin)
def lista_licencias(request):
    # Filtros
    empresa_id = request.GET.get('empresa')
    tipo_periodo = request.GET.get('tipo_periodo')
    solo_activos = request.GET.get('activos') == 'on'
    
    # Iniciar queryset
    periodos = PeriodoLicencia.objects.all().select_related('empresa')

    # Aplicar filtros
    if empresa_id:
        periodos = periodos.filter(empresa_id=empresa_id)
    if tipo_periodo:
        periodos = periodos.filter(tipo_periodo=tipo_periodo)
    if solo_activos:
        now = timezone.now().date()
        periodos = periodos.filter(
            activo=True, fecha_inicio__lte=now, fecha_fin__gte=now)

    # Permisos para admin_empresa
    if hasattr(request.user, 'perfil') and request.user.perfil and request.user.perfil.rol == 'admin_empresa':
        periodos = periodos.filter(empresa=request.user.perfil.empresa)

    # Ordenar
    periodos = periodos.order_by('-fecha_inicio')
    
    # Paginación
    paginator = Paginator(periodos, 10)
    page_number = request.GET.get('page', 1)
    page_obj = paginator.get_page(page_number)
    
    # Para los modales
    form = PeriodoLicenciaForm()
    edit_forms = {periodo.pk: PeriodoLicenciaForm(
        instance=periodo) for periodo in page_obj}

    # Restricción para admin_empresa
    if hasattr(request.user, 'perfil') and request.user.perfil and request.user.perfil.rol == 'admin_empresa':
        form.fields['empresa'].queryset = Empresa.objects.filter(
            id=request.user.perfil.empresa.id)
        form.fields['empresa'].initial = request.user.perfil.empresa
        for pk, edit_form in edit_forms.items():
            edit_form.fields['empresa'].queryset = Empresa.objects.filter(
                id=request.user.perfil.empresa.id)
            edit_form.fields['empresa'].widget.attrs['disabled'] = 'disabled'
    
    context = {
        'page_obj': page_obj,
        'empresas': Empresa.objects.all().order_by('nombre'),
        'filtros': {
            'empresa_id': empresa_id,
            'tipo_periodo': tipo_periodo,
            'solo_activos': solo_activos,
        },
        'now': timezone.now().date(),
        'form': form,
        'edit_forms': edit_forms,
        'abrir_modal': False,  # Se activará si hay errores de validación
    }

    return render(request, 'administration/licences/licences_list.html', context)

@login_required
@user_passes_test(es_admin)
def crear_licencia(request):
    if request.method == 'POST':
        form = PeriodoLicenciaForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(
                request, 'Periodo de licencia creado exitosamente.')
            return redirect('lista_licencias')
    else:
        # Valores iniciales
        empresa_id = request.GET.get('empresa')
        tipo_periodo = request.GET.get('tipo_periodo', 'mensual')
        
        # Calcular fechas por defecto según tipo
        hoy = timezone.now().date()
        if tipo_periodo == 'mensual':
            fecha_fin = hoy + timedelta(days=30)
        elif tipo_periodo == 'anual':
            fecha_fin = hoy.replace(year=hoy.year + 1)
        else:  # personalizado
            fecha_fin = hoy + timedelta(days=90)  # 3 meses por defecto
        
        initial = {
            'tipo_periodo': tipo_periodo,
            'fecha_inicio': hoy,
            'fecha_fin': fecha_fin,
            'hojas_licencia_periodo': 1000,  # Valor por defecto
            'storage_licencia_mb_periodo': 1024,  # 1GB por defecto
            'activo': True
        }
        
        if empresa_id:
            try:
                initial['empresa'] = Empresa.objects.get(id=empresa_id)
            except Empresa.DoesNotExist:
                pass
                
        form = PeriodoLicenciaForm(initial=initial)
        
        # Limitar la lista de empresas si es admin_empresa
        if hasattr(request.user, 'perfil') and request.user.perfil and request.user.perfil.rol == 'admin_empresa':
            form.fields['empresa'].queryset = Empresa.objects.filter(id=request.user.perfil.empresa.id)
            form.fields['empresa'].initial = request.user.perfil.empresa
            form.fields['empresa'].widget.attrs['disabled'] = 'disabled'
    
    context = {
        'form': form,
        'es_edicion': False,
    }
    return render(request, 'administration/licences/modal_create_licence.html', context)

@login_required
@user_passes_test(es_admin)
def editar_licencia(request, pk):
    periodo = get_object_or_404(PeriodoLicencia, pk=pk)
    
    # Verificar permisos para admin_empresa
    if hasattr(request.user, 'perfil') and request.user.perfil and request.user.perfil.rol == 'admin_empresa':
        if periodo.empresa != request.user.perfil.empresa:
            messages.error(
                request, 'No tienes permiso para editar este periodo de licencia.')
            return redirect('lista_licencias')
    
    is_modal = request.headers.get('X-Requested-With') == 'XMLHttpRequest'

    if request.method == 'POST':
        form = PeriodoLicenciaForm(request.POST, instance=periodo)
        if form.is_valid():
            form.save()
            if is_modal:
                return JsonResponse({
                    'success': True,
                    'message': 'Periodo de licencia actualizado exitosamente.'
                })
            else:
                messages.success(request, 'Periodo de licencia actualizado exitosamente.')
                return redirect('lista_licencias')
        elif is_modal:
            # En caso de error de validación en un modal, retornar JSON con errores
            return JsonResponse({
                'success': False,
                'message': 'Por favor, corrige los errores en el formulario.',
                'errors': form.errors.as_json()
            })
    else:
        form = PeriodoLicenciaForm(instance=periodo)
        
        # Limitar la lista de empresas si es admin_empresa
        if hasattr(request.user, 'perfil') and request.user.perfil and request.user.perfil.rol == 'admin_empresa':
            form.fields['empresa'].queryset = Empresa.objects.filter(id=request.user.perfil.empresa.id)
            form.fields['empresa'].widget.attrs['disabled'] = 'disabled'
    
    context = {
        'form': form,
        'periodo': periodo,
        'es_edicion': True,
    }
    return render(request, 'administration/licences/modal_edit_licence.html', context)

@login_required
@user_passes_test(es_admin)
def eliminar_licencia(request, pk):
    periodo = get_object_or_404(PeriodoLicencia, pk=pk)
    
    # Verificar permisos para admin_empresa
    if hasattr(request.user, 'perfil') and request.user.perfil and request.user.perfil.rol == 'admin_empresa':
        if periodo.empresa != request.user.perfil.empresa:
            messages.error(
                request, 'No tienes permiso para eliminar este periodo de licencia.')
            return redirect('lista_licencias')
    
    if request.method == 'POST':
        # Verificar si tiene historial de consumo
        if HistorialConsumo.objects.filter(periodo_licencia=periodo).exists():
            messages.error(
                request, 'No se puede eliminar este periodo porque tiene historial de consumo asociado. Considere desactivarlo en su lugar.')
            return redirect('lista_licencias')
        
        periodo.delete()
        messages.success(
            request, 'Periodo de licencia eliminado exitosamente.')
        return redirect('lista_licencias')
    
    context = {
        'periodo': periodo,
    }
    return render(request, 'administration/licences/licences_modal_delete.html', context)

@login_required
@user_passes_test(es_admin)
def detalle_licencia(request, pk):
    periodo = get_object_or_404(PeriodoLicencia, pk=pk)
    
    # Verificar permisos para admin_empresa
    if hasattr(request.user, 'perfil') and request.user.perfil and request.user.perfil.rol == 'admin_empresa':
        if periodo.empresa != request.user.perfil.empresa:
            messages.error(request, 'No tienes permiso para ver este periodo de licencia.')
            return redirect('lista_licencias')
    
    # Obtener historial de consumo
    historial = HistorialConsumo.objects.filter(periodo_licencia=periodo).order_by('-fecha_consumo')
    
    # Paginación del historial
    paginator = Paginator(historial, 20)  # 20 registros por página
    page_number = request.GET.get('page')
    historial_paginado = paginator.get_page(page_number)
    
    context = {
        'periodo': periodo,
        'historial': historial_paginado,
        'hojas_consumidas': periodo.hojas_consumidas_periodo(),
        'storage_consumido_kb': periodo.storage_consumido_kb_periodo(),
        'hojas_porcentaje': (periodo.hojas_consumidas_periodo() / periodo.hojas_licencia_periodo * 100) if periodo.hojas_licencia_periodo > 0 else 0,
        'storage_porcentaje': (periodo.storage_consumido_kb_periodo() / (periodo.storage_licencia_mb_periodo * 1024) * 100) if periodo.storage_licencia_mb_periodo > 0 else 0,
    }
    return render(request, 'administration/licences/licences_detail.html', context)
