from django.utils import timezone
import json
import uuid
from django.contrib.auth.models import User
from django.db import models
from django.db.models import Sum


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


class PeriodoLicencia(models.Model):
    TIPO_PERIODO_CHOICES = [
        ('mensual', 'Mensual'),
        ('anual', 'Anual'),
        ('personalizado', 'Personalizado'),
    ]
    empresa = models.ForeignKey(
        Empresa, on_delete=models.CASCADE, 
        related_name='periodos_licencia'
    )
    tipo_periodo = models.CharField(
        max_length=20, 
        choices=TIPO_PERIODO_CHOICES, 
        default='mensual'
    )
    fecha_inicio = models.DateField(default=timezone.now)
    fecha_fin = models.DateField()
    hojas_licencia_periodo = models.IntegerField(default=1000)
    storage_licencia_mb_periodo = models.IntegerField(default=1024) # Límite en Megabytes
    activo = models.BooleanField(default=True)

    def __str__(self):
        return f"Licencia para {self.empresa.nombre} ({self.get_tipo_periodo_display()}: {self.fecha_inicio.strftime('%d/%m/%Y')} - {self.fecha_fin.strftime('%d/%m/%Y')})"

    def hojas_consumidas_periodo(self):
        consumo = HistorialConsumo.objects.filter(
            periodo_licencia=self,
            fecha_consumo__date__gte=self.fecha_inicio,  # ← Solo compara la fecha
            fecha_consumo__date__lte=self.fecha_fin      # ← Solo compara la fecha
        ).aggregate(total_hojas=Sum('hojas_consumidas'))
        return consumo['total_hojas'] or 0

    def storage_consumido_kb_periodo(self):
        consumo = HistorialConsumo.objects.filter(
            periodo_licencia=self,
            fecha_consumo__date__gte=self.fecha_inicio,  # ← Solo compara la fecha
            fecha_consumo__date__lte=self.fecha_fin      # ← Solo compara la fecha
        ).aggregate(total_storage=Sum('storage_consumido_kb'))
        return consumo['total_storage'] or 0

    def licencia_hojas_disponible(self, hojas_adicionales=0):
        if not self.activo or self.fecha_fin < timezone.now().date():
            return False, "Periodo de licencia inactivo o caducado."
        
        disponible = (self.hojas_consumidas_periodo() + hojas_adicionales) <= self.hojas_licencia_periodo
        if not disponible:
            return False, f"Límite de hojas ({self.hojas_licencia_periodo}) excedido."
        return True, "OK"

    def licencia_storage_disponible_kb(self, storage_adicional_kb=0):
        if not self.activo or self.fecha_fin < timezone.now().date():
            # Este chequeo ya se hace en licencia_hojas_disponible, pero es bueno tenerlo por si se llama directamente
            return False, "Periodo de licencia inactivo o caducado."

        storage_licencia_kb = self.storage_licencia_mb_periodo * 1024.0
        disponible = (self.storage_consumido_kb_periodo() + storage_adicional_kb) <= storage_licencia_kb
        if not disponible:
            return False, f"Límite de almacenamiento ({self.storage_licencia_mb_periodo}MB) excedido."
        return True, "OK"

    class Meta:
        ordering = ['empresa', '-fecha_fin', '-fecha_inicio'] # Más reciente primero
        verbose_name = "Periodo de Licencia"
        verbose_name_plural = "Periodos de Licencia"
        constraints = [
            models.CheckConstraint(check=models.Q(fecha_fin__gte=models.F('fecha_inicio')), name='fecha_fin_gte_fecha_inicio')
        ]

class HistorialConsumo(models.Model):
    periodo_licencia = models.ForeignKey(PeriodoLicencia, on_delete=models.CASCADE, related_name='historial_consumo')
    documento = models.ForeignKey(Documento, on_delete=models.SET_NULL, null=True, blank=True)
    usuario = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    fecha_consumo = models.DateTimeField(default=timezone.now)
    hojas_consumidas = models.IntegerField(default=0)
    storage_consumido_kb = models.FloatField(default=0) # Consumo en Kilobytes

    def __str__(self):
        user_str = self.usuario.username if self.usuario else "Sistema"
        doc_str = f" - Doc: {self.documento.nombre_documento[:20]}..." if self.documento else ""
        return f"Consumo por {user_str} el {self.fecha_consumo.strftime('%Y-%m-%d %H:%M')}{doc_str}"

    class Meta:
        ordering = ['-fecha_consumo']
        verbose_name = "Historial de Consumo"
        verbose_name_plural = "Historiales de Consumo"
