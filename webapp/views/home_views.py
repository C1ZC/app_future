# ===============================================================
# VISTAS PARA LA PÁGINA PRINCIPAL
# ===============================================================
# Este módulo proporciona las vistas relacionadas con la página
# principal del sistema, que sirve como punto de entrada para
# los usuarios autenticados.
# ===============================================================

from django.shortcuts import render
from django.contrib.auth.decorators import login_required

# ===============================================================
# PÁGINA PRINCIPAL
# ===============================================================
@login_required
def home(request):
    """
    Renderiza la página principal del sistema.
    
    Esta vista es el punto de entrada después del login y muestra
    el dashboard principal con acceso a todas las funciones.
    
    Características:
    - Protegida con login_required para usuarios autenticados
    - Se beneficia del procesador de contexto sidebar_context que agrega
      los servicios disponibles para el usuario en la barra lateral
    - Sirve como hub central de navegación para el sistema
    
    Args:
        request: Objeto HttpRequest con la petición del usuario
        
    Returns:
        HttpResponse con la página principal renderizada
    """
    return render(request, 'pages/home.html')