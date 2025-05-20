from django.contrib.auth.models import User
from django.db import models


class Empresa(models.Model):
    nombre = models.CharField(max_length=255)
    direccion = models.CharField(max_length=255)
    telefono = models.CharField(max_length=20)
    email = models.EmailField()
    RUT = models.CharField(max_length=12, unique=True)  # RUT de la empresa
    # Otros campos relevantes

    def __str__(self):
        return self.nombre


class Servicio(models.Model):
    nombre = models.CharField(max_length=255)
    empresa = models.ForeignKey(
        Empresa, on_delete=models.CASCADE, related_name='servicios')
    # Otros campos relevantes

    class Meta:
        unique_together = ('nombre', 'empresa')
        verbose_name_plural = "Servicios"

    def __str__(self):
        return f"{self.nombre} ({self.empresa.nombre})"


class RolUsuario(models.TextChoices):
    SUPERADMIN = 'superadmin', 'Superadministrador'
    ADMIN_EMPRESA = 'admin_empresa', 'Administrador de Empresa'
    ADMIN_SERVICIO = 'admin_servicio', 'Administrador de Servicio'
    USUARIO_SERVICIO = 'usuario_servicio', 'Usuario de Servicio'


class PerfilUsuario(models.Model):
    user = models.OneToOneField(
        User, on_delete=models.CASCADE, related_name='perfil')
    rol = models.CharField(max_length=20, choices=RolUsuario.choices)
    empresa = models.ForeignKey(
        Empresa, on_delete=models.SET_NULL, null=True, blank=True, related_name='usuarios')
    servicio = models.ForeignKey(
        Servicio, on_delete=models.SET_NULL, null=True, blank=True, related_name='usuarios')

    def __str__(self):
        return f"{self.user.username} - {self.get_rol_display()}"

    def es_superadmin(self):
        return self.rol == RolUsuario.SUPERADMIN or self.user.is_superuser

    def es_admin_empresa(self):
        return self.rol == RolUsuario.ADMIN_EMPRESA

    def es_admin_servicio(self):
        return self.rol == RolUsuario.ADMIN_SERVICIO

    def es_usuario_servicio(self):
        return self.rol == RolUsuario.USUARIO_SERVICIO
