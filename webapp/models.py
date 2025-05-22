from django.utils import timezone
import json
import uuid
from django.contrib.auth.models import User
from django.db import models


class Empresa(models.Model):
    nombre = models.CharField(max_length=255)
    direccion = models.CharField(max_length=255)
    telefono = models.CharField(max_length=20)
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


class DocumentoStatus(models.TextChoices):
    EN_ESPERA = 'en_espera', 'En espera'
    PROCESANDO = 'procesando', 'Procesando'
    COMPLETADO = 'completado', 'Completado'
    ERROR = 'error', 'Error'


class Documento(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    nombre_documento = models.CharField(max_length=255)
    nombre_unico = models.CharField(max_length=300, unique=True)
    ruta_documento = models.URLField()
    miniatura_documento = models.URLField(null=True, blank=True)
    tipo_archivo = models.CharField(max_length=100)
    origen_archivo = models.CharField(max_length=50, default='manual')
    created_at = models.DateTimeField(default=timezone.now)
    file_size = models.FloatField()  # tamaño en KB
    cantidad_hojas = models.IntegerField(default=1)
    status = models.CharField(
        max_length=20,
        choices=DocumentoStatus.choices,
        default=DocumentoStatus.EN_ESPERA
    )
    json_data = models.JSONField(null=True, blank=True)
    ocr_data = models.TextField(null=True, blank=True)
    grupo = models.CharField(max_length=100, null=True, blank=True)
    modulo = models.CharField(max_length=100, null=True, blank=True)
    servicio = models.ForeignKey(
        Servicio, on_delete=models.SET_NULL,
        null=True, blank=True, related_name='documentos'
    )
    empresa = models.ForeignKey(
        Empresa, on_delete=models.SET_NULL,
        null=True, blank=True, related_name='documentos'
    )
    usuario = models.ForeignKey(
        User, on_delete=models.SET_NULL,
        null=True, blank=True, related_name='documentos'
    )

    def __str__(self):
        return f"{self.nombre_documento} ({self.status})"

    class Meta:
        ordering = ['-created_at']


class ConfigTenant(models.Model):
    empresa = models.OneToOneField(
        Empresa, on_delete=models.CASCADE,
        related_name='config_tenant'
    )
    hojas_leidas = models.IntegerField(default=0)
    hojas_licencia = models.IntegerField(default=1000)
    activo = models.BooleanField(default=True)

    def __str__(self):
        return f"Config: {self.empresa.nombre}"

    def licencia_disponible(self, hojas_adicionales=1):
        return self.hojas_leidas + hojas_adicionales <= self.hojas_licencia
