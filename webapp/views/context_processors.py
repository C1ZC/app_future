# ===============================================================
# PROCESADORES DE CONTEXTO PARA TEMPLATES
# ===============================================================
# Este módulo contiene procesadores de contexto que añaden variables
# adicionales a todas las plantillas renderizadas en la aplicación.
# Los procesadores de contexto son una forma potente de hacer datos
# disponibles globalmente en todas las vistas sin repetir código.
# ===============================================================

from webapp.models import Servicio

# ===============================================================
# CONTEXTO PARA LA BARRA LATERAL (SIDEBAR)
# ===============================================================
def sidebar_context(request):
    """
    Agrega los servicios del usuario al contexto para el sidebar.
    
    Este procesador de contexto se ejecuta en cada petición y determina
    qué servicios debe ver el usuario en la barra lateral según su rol:
    
    1. Superusuarios/superadmins: ven TODOS los servicios del sistema
    2. Usuarios con perfil normal: ven solo los servicios de su empresa
    3. Usuarios no autenticados: no ven ningún servicio
    
    Returns:
        dict: Diccionario con servicios disponibles para el usuario actual
    """
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