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

@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def eliminar_grupo(request, grupo_id):
    """Elimina un grupo y todos sus módulos asociados"""
    if request.method != 'POST':
        return JsonResponse({'error': 'Método no permitido'}, status=405)
    
    try:
        grupo = get_object_or_404(Grupo, id=grupo_id)
        nombre_grupo = grupo.nombre
        
        # Eliminará automáticamente los módulos por la relación CASCADE
        grupo.delete()
        
        messages.success(request, f"Grupo '{nombre_grupo}' y todos sus módulos eliminados correctamente")
        return JsonResponse({'success': True})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=400)

@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def eliminar_modulo(request, modulo_id):
    """Elimina un módulo específico"""
    if request.method != 'POST':
        return JsonResponse({'error': 'Método no permitido'}, status=405)
    
    try:
        modulo = get_object_or_404(Modulo, id=modulo_id)
        nombre_modulo = modulo.nombre
        grupo_nombre = modulo.grupo.nombre
        
        modulo.delete()
        
        messages.success(request, f"Módulo '{nombre_modulo}' del grupo '{grupo_nombre}' eliminado correctamente")
        return JsonResponse({'success': True})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=400)
    
@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def editar_esquema_modulo(request, modulo_id):
    """Editar esquema JSON de un módulo"""
    modulo = get_object_or_404(Modulo, id=modulo_id)
    
    if request.method == 'POST':
        try:
            esquema = json.loads(request.POST.get('esquema_json', '{}'))
            modulo.esquema_json = esquema
            modulo.save()
            messages.success(request, f"Esquema del módulo '{modulo.nombre}' actualizado correctamente")
            return redirect('admin_grupos_modulos')
        except json.JSONDecodeError:
            messages.error(request, "El esquema JSON no es válido")
    
    # Valor por defecto si no hay esquema
    esquema_default = {
        "campos_requeridos": [
            {"nombre": "tipo", "tipo": "string", "descripcion": "Tipo de documento"},
            {"nombre": "fecha", "tipo": "date", "descripcion": "Fecha del documento"}
        ],
        "campos_opcionales": [
            {"nombre": "monto", "tipo": "number", "descripcion": "Monto total"},
            {"nombre": "emisor", "tipo": "string", "descripcion": "Entidad emisora"}
        ],
        "ejemplos": [
            {"tipo": "factura", "fecha": "2023-01-15", "monto": 1500, "emisor": "Empresa XYZ"}
        ],
        "instrucciones_especiales": "Asegúrate de extraer correctamente la fecha en formato YYYY-MM-DD"
    }
    
    context = {
        'modulo': modulo,
        'esquema_json': json.dumps(modulo.esquema_json or esquema_default, indent=2),
        'grupo': modulo.grupo
    }
    
    return render(request, 'administration/documents/editar_esquema_modulo.html', context)