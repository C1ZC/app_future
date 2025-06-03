# ===============================================================
# VISTAS DE GESTIÓN DE PERFIL DE USUARIO
# ===============================================================
# Este módulo proporciona vistas para que los usuarios puedan
# gestionar sus propios perfiles, incluyendo la actualización de
# información personal y cambio de contraseña.
# ===============================================================

# Importaciones de Django
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from django.contrib import messages

# Importaciones de formularios propios
from webapp.forms.administration_forms import PerfilUsuarioEditForm, PasswordChangeCustomForm

# ===============================================================
# VISTA PRINCIPAL DE PERFIL
# ===============================================================
@login_required
def perfil_view(request):
    """
    Vista principal para gestión del perfil de usuario.
    
    Esta vista maneja dos formularios independientes:
    1. Formulario de edición de datos básicos del perfil
    2. Formulario para cambio de contraseña
    
    Ambos formularios comparten la misma plantilla pero se procesan
    por separado usando diferentes botones de envío en el HTML.
    """
    # Inicializar usuario y formularios
    user = request.user
    perfil_form = PerfilUsuarioEditForm(instance=user)
    password_form = PasswordChangeCustomForm(user)
    # Controla si se muestra el modal de cambio de contraseña
    abrir_modal_password = False

    # Procesar formularios si es una petición POST
    if request.method == 'POST':
        # ---------------------------------------------------------------
        # PROCESAMIENTO DEL FORMULARIO DE PERFIL
        # ---------------------------------------------------------------
        if 'save_profile' in request.POST:
            # Se envió el formulario de actualización de perfil
            perfil_form = PerfilUsuarioEditForm(request.POST, instance=user)

            if perfil_form.is_valid():
                # Guardar cambios en el perfil
                perfil_form.save()
                # Notificar éxito al usuario
                messages.success(request, "Perfil actualizado correctamente.")
                # Redirigir para evitar reenvío del formulario
                return redirect('perfil')

        # ---------------------------------------------------------------
        # PROCESAMIENTO DEL FORMULARIO DE CONTRASEÑA
        # ---------------------------------------------------------------
        elif 'save_password' in request.POST:
            # Se envió el formulario de cambio de contraseña
            password_form = PasswordChangeCustomForm(user, request.POST)
            # Mostrar el modal de contraseña (en caso de errores)
            abrir_modal_password = True

            if password_form.is_valid():
                # Guardar la nueva contraseña
                password_form.save()
                # Notificar éxito al usuario
                messages.success(request, "Contraseña cambiada correctamente.")
                # Redirigir para evitar reenvío del formulario
                return redirect('perfil')
            else:
                # Notificar que hay errores que corregir
                messages.success(
                    request, "Corrige los errores en el formulario de contraseña.")

    # Renderizar la plantilla con ambos formularios
    return render(request, 'pages/perfiles.html', {
        'form': perfil_form,                     # Formulario de datos de perfil
        'password_form': password_form,          # Formulario de cambio de contraseña
        # Controla la visibilidad del modal
        'abrir_modal_password': abrir_modal_password,
    })