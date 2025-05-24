from webapp.models import Servicio

def sidebar_context(request):
    """Agrega los servicios del usuario al contexto para el sidebar."""
    context = {
        'servicios_usuario': []
    }
    
    if request.user.is_authenticated:
        # Para superusuario o superadmin, mostrar TODOS los servicios
        if request.user.is_superuser or (hasattr(request.user, 'perfil') and request.user.perfil.rol == 'superadmin'):
            context['servicios_usuario'] = Servicio.objects.all()
        # Para usuarios normales con perfil y empresa, mostrar servicios de su empresa
        elif hasattr(request.user, 'perfil') and request.user.perfil.empresa:
            context['servicios_usuario'] = Servicio.objects.filter(
                empresa=request.user.perfil.empresa
            )
    
    return context