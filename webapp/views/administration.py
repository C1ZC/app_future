from django.shortcuts import render
from webapp.service.roles import rol_requerido
from django.contrib.auth.decorators import login_required

@login_required
@rol_requerido('superadmin')
def administracion(request):
    return render(request, 'pages/administration.html')