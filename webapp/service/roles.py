# ===============================================================
# SISTEMA DE CONTROL DE ACCESO BASADO EN ROLES
# ===============================================================
# Este módulo implementa un sistema de decoradores para proteger
# vistas en base a los roles de usuario definidos en el sistema.
# Permite restringir el acceso a funcionalidades específicas según
# el nivel de permisos asignado al usuario.
# ===============================================================

from django.shortcuts import redirect
from functools import wraps
from webapp.models import PerfilUsuario, RolUsuario


def rol_requerido(*roles):
    """
    Decorador que restringe el acceso a vistas según los roles del usuario.
    
    Funcionamiento:
    1. Verifica que el usuario esté autenticado
    2. Permite acceso automático a superusuarios y staff
    3. Comprueba si el usuario tiene un perfil asociado
    4. Verifica si el rol del usuario está entre los permitidos
    5. Redirecciona a la página principal si no tiene permisos
    
    Args:
        *roles: Lista variable de roles permitidos (ej: RolUsuario.SUPERADMIN)
        
    Returns:
        La vista decorada que verifica los permisos antes de ejecutarse
    """
    def decorator(view_func):
        @wraps(view_func)
        def _wrapped_view(request, *args, **kwargs):
            # Verificar autenticación básica
            if not request.user.is_authenticated:
                return redirect('login')
                
            # Bypass para superusuarios y staff de Django
            if request.user.is_superuser or request.user.is_staff:
                return view_func(request, *args, **kwargs)
                
            # Verificar si el usuario tiene perfil
            try:
                perfil = request.user.perfil
            except PerfilUsuario.DoesNotExist:
                # Si no tiene perfil, no puede tener rol asignado
                return redirect('login')
                
            # Verificar si el rol del usuario está entre los permitidos
            if perfil.rol in roles:
                # Permitir acceso a la vista
                return view_func(request, *args, **kwargs)
                
            # Denegar acceso y redirigir a la página principal
            return redirect('home')
            
        return _wrapped_view
    return decorator