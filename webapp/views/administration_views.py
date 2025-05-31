from django.shortcuts import render, get_object_or_404
from webapp.models import Grupo, Modulo, RolUsuario
from webapp.service.roles import rol_requerido
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.shortcuts import redirect
from django.http import JsonResponse
import json


@login_required
@rol_requerido('superadmin')
def administracion(request):
    return render(request, 'pages/administration.html')


@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def admin_grupos_modulos(request):
    """Administración de grupos y módulos de documentos"""
    grupos = Grupo.objects.all().order_by('nombre')
    return render(request, 'administration/documents/grupos_modulos.html', {
        'grupos': grupos
    })


@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def crear_grupo(request):
    if request.method == 'POST':
        nombre = request.POST.get('nombre')
        descripcion = request.POST.get('descripcion')

        if not nombre:
            messages.error(request, "El nombre es obligatorio")
            return redirect('admin_grupos_modulos')

        Grupo.objects.create(nombre=nombre, descripcion=descripcion)
        messages.success(request, f"Grupo '{nombre}' creado correctamente")
        return redirect('admin_grupos_modulos')

    return redirect('admin_grupos_modulos')


@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def crear_modulo(request):
    if request.method == 'POST':
        nombre = request.POST.get('nombre')
        descripcion = request.POST.get('descripcion')
        grupo_id = request.POST.get('grupo_id')

        if not nombre or not grupo_id:
            messages.error(request, "El nombre y el grupo son obligatorios")
            return redirect('admin_grupos_modulos')

        try:
            grupo = Grupo.objects.get(id=grupo_id)
            Modulo.objects.create(
                nombre=nombre, descripcion=descripcion, grupo=grupo)
            messages.success(
                request, f"Módulo '{nombre}' creado correctamente en grupo '{grupo.nombre}'")
        except Grupo.DoesNotExist:
            messages.error(request, "El grupo seleccionado no existe")

        return redirect('admin_grupos_modulos')

    return redirect('admin_grupos_modulos')


@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def toggle_grupo_activo(request, grupo_id):
    if request.method != 'POST':
        return JsonResponse({'error': 'Método no permitido'}, status=405)
    
    try:
        data = json.loads(request.body)
        activo = data.get('activo', False)
        
        grupo = get_object_or_404(Grupo, id=grupo_id)
        grupo.activo = activo
        grupo.save()
        
        return JsonResponse({'success': True})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=400)
