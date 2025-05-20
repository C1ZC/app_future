from django.shortcuts import render
from webapp.models import Empresa, Servicio, PerfilUsuario
from webapp.service.roles import rol_requerido
from django.contrib.auth.decorators import login_required

@login_required
@rol_requerido('superadmin', 'admin_empresa', 'admin_servicio')
def administracion(request):
    empresas = Empresa.objects.all()
    servicios = Servicio.objects.all()
    usuarios = PerfilUsuario.objects.all()

    context = {
        'empresas': empresas,
        'servicios': servicios,
        'usuarios': usuarios,
    }
    return render(request, 'pages/administration.html', context)