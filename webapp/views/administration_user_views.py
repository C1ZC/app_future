# ===============================================================
# VISTAS DE ADMINISTRACIÓN DE USUARIOS
# ===============================================================
# Este módulo proporciona las vistas relacionadas con la gestión 
# administrativa de usuarios dentro del sistema, accesible para
# usuarios con roles administrativos.
# ===============================================================

from django.shortcuts import render
from webapp.models import Empresa, Servicio, PerfilUsuario
from webapp.service.roles import rol_requerido
from django.contrib.auth.decorators import login_required

# ===============================================================
# PANEL DE ADMINISTRACIÓN DE USUARIOS
# ===============================================================
@login_required
@rol_requerido('superadmin', 'admin_empresa', 'admin_servicio')
def administracion_user(request):
    """
    Muestra el panel de administración de usuarios.
    
    Esta vista recopila todos los datos necesarios para la 
    interfaz de administración de usuarios:
    - Lista de empresas para asignación
    - Lista de servicios disponibles
    - Lista de todos los perfiles de usuario
    
    El acceso está restringido a usuarios con roles administrativos
    mediante el decorador rol_requerido.
    """
    # Obtener datos para el panel
    empresas = Empresa.objects.all()  # Todas las empresas para asignación
    servicios = Servicio.objects.all()  # Todos los servicios disponibles
    usuarios = PerfilUsuario.objects.all()  # Todos los perfiles de usuario

    # Preparar contexto para la plantilla
    context = {
        'empresas': empresas,  # Para selector de empresas
        'servicios': servicios,  # Para selector de servicios
        'usuarios': usuarios,  # Lista de usuarios para mostrar
    }
    
    # Renderizar la plantilla con el contexto
    return render(request, 'pages/administration_user.html', context)