# ===============================================================
# VISTAS DE AUTENTICACIÓN DE USUARIOS
# ===============================================================
# Este módulo proporciona las vistas necesarias para la autenticación
# de usuarios en el sistema, incluyendo registro, inicio de sesión
# y cierre de sesión.
# ===============================================================

# Importaciones de Django
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.forms import AuthenticationForm
from django.contrib import messages

# Importaciones locales
from webapp.service.auth import AuthService

# ===============================================================
# REGISTRO DE USUARIOS
# ===============================================================
def register(request):
    """
    Maneja el registro de nuevos usuarios en el sistema.
    
    Utiliza el servicio AuthService para procesar el formulario
    de registro y crear nuevos usuarios. Si el registro es exitoso,
    inicia sesión automáticamente y redirecciona al usuario a la
    página principal.
    """
    # Delega la lógica de registro al servicio AuthService
    success, result, message = AuthService.register_user(request)

    if success:
        # Si el registro fue exitoso, mostrar mensaje y redirigir
        messages.success(request, message)
        return redirect('home')

    # Si hubo error, volver a mostrar el formulario con errores
    return render(request, 'registration/register.html', {'form': result})

# ===============================================================
# INICIO DE SESIÓN
# ===============================================================
def login_view(request):
    """
    Maneja el inicio de sesión de usuarios existentes.
    
    Valida las credenciales proporcionadas usando el formulario
    de autenticación estándar de Django y autentica al usuario
    si son correctas.
    """
    if request.method == 'POST':
        # Procesar formulario enviado
        form = AuthenticationForm(request, data=request.POST)

        if form.is_valid():
            # Extraer credenciales del formulario validado
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')

            # Intentar autenticar con las credenciales proporcionadas
            user = authenticate(request, username=username, password=password)

            if user is not None:
                # Si la autenticación es exitosa, iniciar sesión
                login(request, user)
                return redirect('home')
        else:
            # Si el formulario no es válido, mostrar mensaje de error
            messages.error(request, "Invalid username or password.")
    else:
        # Si es GET, mostrar formulario vacío
        form = AuthenticationForm()

    # Renderizar la plantilla con el formulario
    return render(request, 'registration/login.html', {'form': form})

# ===============================================================
# CIERRE DE SESIÓN
# ===============================================================
def logout_view(request):
    """
    Maneja el cierre de sesión de usuarios.
    
    Cierra la sesión actual del usuario y lo redirecciona
    a la página de inicio de sesión.
    """
    # Cerrar la sesión del usuario actual
    logout(request)

    # Redireccionar a la página de login
    return redirect('login')