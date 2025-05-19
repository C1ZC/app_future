from django.contrib import admin
from .models import Empresa, Servicio, PerfilUsuario

admin.site.register(Empresa)
admin.site.register(Servicio)
admin.site.register(PerfilUsuario)
