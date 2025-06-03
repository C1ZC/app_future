# ===============================================================
# GESTIÓN DE USUARIOS (CRUD)
# ===============================================================
# Este módulo implementa las operaciones básicas para administrar
# usuarios dentro del sistema, permitiendo listar, crear, actualizar
# y eliminar usuarios con sus respectivos perfiles y permisos.
# ===============================================================

# Importaciones de Django
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth.models import User

# Importaciones locales
from webapp.models import PerfilUsuario
from webapp.forms.administration_forms import PerfilUsuarioForm, UserForm, UserEditForm
from webapp.service.roles import rol_requerido, RolUsuario

# ===============================================================
# LISTADO DE USUARIOS
# ===============================================================
@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA, RolUsuario.ADMIN_SERVICIO)
def usuario_list(request):
    """
    Muestra un listado de todos los usuarios del sistema.
    
    Prepara los formularios necesarios para:
    - Crear nuevos usuarios (user_form + perfil_form)
    - Editar usuarios existentes (edit_forms con ambos formularios)
    """
    # Obtener todos los perfiles de usuario existentes
    usuarios = PerfilUsuario.objects.all()
    
    # Preparar formularios para crear nuevo usuario
    user_form = UserForm()
    perfil_form = PerfilUsuarioForm(request_user=request.user)
    
    # Preparar formularios de edición para cada usuario existente
    edit_forms = {}
    for usuario in usuarios:
        # Generar formularios pre-poblados con los datos actuales
        perfil_form_edit = PerfilUsuarioForm(instance=usuario, request_user=request.user)
        user_form_edit = UserEditForm(instance=usuario.user)
        
        # Almacenar ambos formularios juntos por ID de usuario
        edit_forms[usuario.pk] = {
            'perfil_form': perfil_form_edit,
            'user_form': user_form_edit,
        }
    
    # Renderizar la plantilla con todos los datos necesarios
    return render(request, 'administration/users/list_users.html', {
        'usuarios': usuarios,
        'user_form': user_form,
        'perfil_form': perfil_form,
        'edit_forms': edit_forms,
    })


# ===============================================================
# CREACIÓN DE USUARIOS
# ===============================================================
@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA, RolUsuario.ADMIN_SERVICIO)
def usuario_create(request):
    """
    Maneja la creación de un nuevo usuario con su perfil asociado.
    
    Si ambos formularios (usuario y perfil) son válidos, crea el usuario
    y lo asocia al perfil. En caso de error, muestra el formulario
    con los errores marcados.
    """
    if request.method == 'POST':
        # Procesar formularios enviados
        user_form = UserForm(request.POST)
        perfil_form = PerfilUsuarioForm(request.POST, request_user=request.user)
        
        # Validar ambos formularios
        if user_form.is_valid() and perfil_form.is_valid():
            # Guardar el usuario primero (para obtener su ID)
            user = user_form.save()
            
            # Crear el perfil asociado sin guardar aún (commit=False)
            perfil = perfil_form.save(commit=False)
            
            # Asociar el usuario al perfil y guardar
            perfil.user = user
            perfil.save()
            
            # Notificar éxito y redirigir
            messages.success(request, "Usuario creado correctamente.")
            return redirect('lista_usuarios')
        else:
            # Si hay errores, volver al listado mostrando el modal
            usuarios = PerfilUsuario.objects.all()
            edit_forms = {usuario.pk: PerfilUsuarioForm(instance=usuario, request_user=request.user) for usuario in usuarios}
            return render(request, 'administration/users/list_users.html', {
                'usuarios': usuarios,
                'user_form': user_form,  # Formulario con errores
                'perfil_form': perfil_form,  # Formulario con errores
                'edit_forms': edit_forms,
                'abrir_modal': True,  # Para que el modal se mantenga abierto
            })
    else:
        # Si no es POST, redirigir al listado
        return redirect('lista_usuarios')
    
# ===============================================================
# ACTUALIZACIÓN DE USUARIOS
# ===============================================================
@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA, RolUsuario.ADMIN_SERVICIO)
def usuario_update(request, pk):
    """
    Actualiza los datos de un usuario y su perfil existentes.
    
    Recibe el ID del perfil (pk) a modificar, obtiene el usuario asociado
    y actualiza ambos registros si los datos son válidos.
    """
    # Obtener el perfil existente y su usuario asociado
    perfil = get_object_or_404(PerfilUsuario, pk=pk)
    user = perfil.user
    
    if request.method == 'POST':
        # Procesar formularios enviados con las instancias existentes
        user_form = UserEditForm(request.POST, instance=user)
        perfil_form = PerfilUsuarioForm(request.POST, instance=perfil, request_user=request.user)
        
        # Validar ambos formularios
        if user_form.is_valid() and perfil_form.is_valid():
            # Guardar ambos modelos
            user_form.save()
            perfil_form.save()
            
            # Notificar éxito y redirigir
            messages.success(request, "Usuario actualizado correctamente.")
            return redirect('lista_usuarios')
    else:
        # Si es GET, preparar formularios con datos actuales
        user_form = UserEditForm(instance=user)
        perfil_form = PerfilUsuarioForm(instance=perfil, request_user=request.user)
        
    # Renderizar la plantilla con los formularios
    return render(request, 'administration/users/list_users.html', {
        'user_form': user_form,
        'perfil_form': perfil_form
    })

# ===============================================================
# ELIMINACIÓN DE USUARIOS
# ===============================================================
@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA, RolUsuario.ADMIN_SERVICIO)
def usuario_delete(request, pk):
    """
    Elimina un usuario y su perfil asociado del sistema.
    
    Importante: La eliminación del usuario (User) elimina automáticamente
    el perfil (PerfilUsuario) debido a la relación CASCADE en el modelo.
    """
    # Obtener el perfil a eliminar
    perfil = get_object_or_404(PerfilUsuario, pk=pk)
    
    if request.method == 'POST':
        # Eliminar el usuario (el perfil se elimina por CASCADE)
        perfil.user.delete()
        
        # Notificar éxito y redirigir
        messages.success(request, "Usuario eliminado correctamente.")
        return redirect('lista_usuarios')
        
    # Si es GET, mostrar confirmación
    return render(request, 'administration/users/list_users.html', {'perfil': perfil})