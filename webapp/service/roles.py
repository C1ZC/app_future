from django.shortcuts import redirect
from functools import wraps
from webapp.models import PerfilUsuario, RolUsuario

def rol_requerido(*roles):
    def decorator(view_func):
        @wraps(view_func)
        def _wrapped_view(request, *args, **kwargs):
            if not request.user.is_authenticated:
                return redirect('login')
            # Permitir acceso a superusuarios y staff
            if request.user.is_superuser or request.user.is_staff:
                return view_func(request, *args, **kwargs)
            try:
                perfil = request.user.perfilusuario
            except PerfilUsuario.DoesNotExist:
                return redirect('login')
            if perfil.rol in roles:
                return view_func(request, *args, **kwargs)
            return redirect('dashboard')
        return _wrapped_view
    return decorator