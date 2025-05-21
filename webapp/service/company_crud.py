from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from webapp.models import Empresa
from webapp.forms.administration_forms import EmpresaForm
from webapp.service.roles import rol_requerido, RolUsuario
from django.contrib.auth.decorators import login_required

@rol_requerido(RolUsuario.SUPERADMIN)
def empresa_list(request):
    empresas = Empresa.objects.all()
    form = EmpresaForm()
    edit_forms = {empresa.pk: EmpresaForm(instance=empresa) for empresa in empresas}  # <-- esto es clave
    return render(request, 'administration/company/list_company.html', {
        'empresas': empresas,
        'form': form,
        'edit_forms': edit_forms,  # <-- esto es clave
    })

@rol_requerido(RolUsuario.SUPERADMIN)
def empresa_create(request):
    if request.method == 'POST':
        form = EmpresaForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Empresa creada correctamente.")
            return redirect('lista_empresas')
        else:
            # Si hay errores, vuelve a la lista y muestra el modal abierto
            empresas = Empresa.objects.all()
            edit_forms = {empresa.pk: EmpresaForm(instance=empresa) for empresa in empresas}
            return render(request, 'administration/company/list_company.html', {
                'empresas': empresas,
                'form': form,  # este form tiene los errores
                'edit_forms': edit_forms,
                'abrir_modal': True,  # bandera para abrir el modal
            })
    else:
        return redirect('lista_empresas')
    
@rol_requerido(RolUsuario.SUPERADMIN)
def empresa_update(request, pk):
    empresa = get_object_or_404(Empresa, pk=pk)
    if request.method == 'POST':
        form = EmpresaForm(request.POST, instance=empresa)
        if form.is_valid():
            form.save()
            messages.success(request, "Empresa actualizada correctamente.")
            return redirect('lista_empresas')
    else:
        form = EmpresaForm(instance=empresa)
    return render(request, 'administration/company/list_company.html', {'form': form})

@rol_requerido(RolUsuario.SUPERADMIN)
def empresa_delete(request, pk):
    empresa = get_object_or_404(Empresa, pk=pk)
    if request.method == 'POST':
        empresa.delete()
        messages.success(request, "Empresa eliminada correctamente.")
        return redirect('lista_empresas')
    return render(request, 'administration/company/list_company.html', {'empresa': empresa})