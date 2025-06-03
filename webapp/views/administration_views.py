# ===============================================================
# VISTAS DE ADMINISTRACIÓN
# ===============================================================
# Este módulo proporciona vistas para la gestión administrativa
# del sistema, incluyendo el panel principal de administración y
# la gestión de grupos y módulos para los documentos.
# ===============================================================

# Importaciones de Django
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import JsonResponse

# Importaciones de modelos y servicios propios
from webapp.models import Grupo, Modulo, RolUsuario
from webapp.service.roles import rol_requerido

# Otras importaciones
import json

# ===============================================================
# PANEL PRINCIPAL DE ADMINISTRACIÓN
# ===============================================================
@login_required
@rol_requerido('superadmin')
def administracion(request):
    """
    Página principal del panel de administración.
    
    Esta vista muestra el dashboard administrativo con enlaces a
    todas las funciones de gestión del sistema.
    """
    return render(request, 'pages/administration.html')

# ===============================================================
# GESTIÓN DE GRUPOS Y MÓDULOS
# ===============================================================
@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def admin_grupos_modulos(request):
    """
    Administración de grupos y módulos de documentos.
    
    Esta vista muestra un listado de todos los grupos existentes
    con sus módulos asociados, permitiendo crear, editar y eliminar
    tanto grupos como módulos.
    """
    grupos = Grupo.objects.all().order_by('nombre')
    return render(request, 'administration/documents/grupos_modulos.html', {
        'grupos': grupos
    })

# ===============================================================
# OPERACIONES DE GRUPOS
# ===============================================================
@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def crear_grupo(request):
    """
    Crea un nuevo grupo de documentos.
    
    Recibe nombre y descripción del formulario POST y
    crea un nuevo registro en la base de datos.
    """
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
def toggle_grupo_activo(request, grupo_id):
    """
    Activa o desactiva un grupo.
    
    Actualiza el estado 'activo' del grupo mediante 
    una petición AJAX, recibiendo el nuevo estado en JSON.
    """
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
    """
    Elimina un grupo y todos sus módulos asociados.
    
    La eliminación cascada también elimina los módulos
    relacionados gracias a la configuración del modelo.
    """
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

# ===============================================================
# OPERACIONES DE MÓDULOS
# ===============================================================


@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def crear_modulo(request):
    """
    Crea un nuevo módulo dentro de un grupo.
    
    Recibe nombre, descripción y grupo_id del formulario POST,
    valida los datos y crea un nuevo registro de módulo.
    """
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
def eliminar_modulo(request, modulo_id):
    """
    Elimina un módulo específico.
    
    A diferencia de eliminar_grupo, esta función elimina un solo
    módulo sin afectar al grupo al que pertenece.
    """
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

# ===============================================================
# GESTIÓN DE ESQUEMAS JSON
# ===============================================================
@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def editar_esquema_modulo(request, modulo_id):
    """
    Edita el esquema JSON de un módulo.
    
    Esta función:
    1. En GET, muestra el formulario con el esquema actual o un esquema por defecto
    2. En POST, valida y guarda el nuevo esquema JSON
    
    El esquema JSON define cómo la IA procesará los documentos
    de este módulo, incluyendo campos a extraer.
    """
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