# ===============================================================
# MODELOS DE LA APLICACIÓN
# ===============================================================
# Este archivo define la estructura de datos del sistema, implementando
# todos los modelos necesarios para el funcionamiento de la plataforma.
# ===============================================================

from django.utils import timezone
import json
import uuid
from django.contrib.auth.models import User
from django.db import models
from django.db.models import Sum

# ===============================================================
# MODELOS ORGANIZACIONALES
# ===============================================================
# Definen la estructura jerárquica organizacional: Empresas y Servicios
# Estos modelos son clave para el filtrado de documentos por organización
# ===============================================================
class Empresa(models.Model):
    """
    Representa una empresa/organización dentro del sistema.
    
    Las empresas son el nivel más alto de agrupación y se utilizan como
    criterio principal de filtrado en el sistema de documentos.
    """
    nombre = models.CharField(max_length=255)
    direccion = models.CharField(max_length=255)
    telefono = models.CharField(max_length=20)
    RUT = models.CharField(max_length=12, unique=True)  # RUT de la empresa

    def __str__(self):
        return self.nombre


class Servicio(models.Model):
    """
    Representa un servicio ofrecido por una empresa.
    
    Los servicios permiten categorizar los documentos dentro de cada empresa,
    facilitando el filtrado por área de negocio o departamento.
    """
    nombre = models.CharField(max_length=255)
    empresa = models.ForeignKey(
        Empresa, on_delete=models.CASCADE, related_name='servicios')

    class Meta:
        unique_together = ('nombre', 'empresa')
        verbose_name_plural = "Servicios"

    def __str__(self):
        return f"{self.nombre} ({self.empresa.nombre})"


# ===============================================================
# MODELOS DE USUARIOS Y PERMISOS
# ===============================================================
# Definen los usuarios y sus roles dentro del sistema
# Los roles determinan qué documentos puede ver cada usuario
# ===============================================================
class RolUsuario(models.TextChoices):
    """
    Define los roles disponibles para los usuarios en el sistema.
    
    Estos roles determinan qué documentos puede ver cada usuario:
    - SUPERADMIN: Acceso a todos los documentos
    - ADMIN_EMPRESA: Acceso a documentos de su empresa
    - ADMIN_SERVICIO: Acceso a documentos de su servicio
    - USUARIO_SERVICIO: Acceso solo a sus propios documentos
    """
    SUPERADMIN = 'superadmin', 'Superadministrador'
    ADMIN_EMPRESA = 'admin_empresa', 'Administrador de Empresa'
    ADMIN_SERVICIO = 'admin_servicio', 'Administrador de Servicio'
    USUARIO_SERVICIO = 'usuario_servicio', 'Usuario de Servicio'


class PerfilUsuario(models.Model):
    """
    Extiende el modelo de usuario de Django con información adicional.
    
    El perfil define el rol del usuario y sus asociaciones con empresa y
    servicio, lo que se utiliza para filtrar automáticamente los documentos
    que puede ver según su nivel de acceso.
    """
    user = models.OneToOneField(
        User, on_delete=models.CASCADE, related_name='perfil')
    rol = models.CharField(max_length=20, choices=RolUsuario.choices)
    empresa = models.ForeignKey(
        Empresa, on_delete=models.SET_NULL, null=True, blank=True, related_name='usuarios')
    servicio = models.ForeignKey(
        Servicio, on_delete=models.SET_NULL, null=True, blank=True, related_name='usuarios')

    def __str__(self):
        return f"{self.user.username} - {self.get_rol_display()}"

    # Métodos helper para verificar roles (usados en filtros de permisos)
    def es_superadmin(self):
        return self.rol == RolUsuario.SUPERADMIN or self.user.is_superuser

    def es_admin_empresa(self):
        return self.rol == RolUsuario.ADMIN_EMPRESA

    def es_admin_servicio(self):
        return self.rol == RolUsuario.ADMIN_SERVICIO

    def es_usuario_servicio(self):
        return self.rol == RolUsuario.USUARIO_SERVICIO


# ===============================================================
# MODELOS DE CATEGORIZACIÓN DE DOCUMENTOS
# ===============================================================
# Definen la estructura de clasificación de documentos por Grupos y Módulos
# Estas categorías son fundamentales para el filtrado jerárquico
# ===============================================================
class DocumentoStatus(models.TextChoices):
    """
    Define los posibles estados de un documento en el sistema.
    
    El estado es un criterio de filtrado importante que permite:
    - Encontrar documentos pendientes de procesamiento
    - Filtrar por documentos ya completados
    - Identificar documentos con errores
    """
    EN_ESPERA = 'en_espera', 'En espera'
    PROCESANDO = 'procesando', 'Procesando'
    COMPLETADO = 'completado', 'Completado'
    ERROR = 'error', 'Error'


class Grupo(models.Model):
    """
    Representa un grupo o categoría principal de documentos.
    
    Los grupos son el primer nivel de categorización en el filtrado
    jerárquico de documentos. Cada grupo puede contener múltiples módulos.
    """
    nombre = models.CharField(max_length=100, unique=True)
    descripcion = models.TextField(blank=True, null=True)
    activo = models.BooleanField(default=True)

    def __str__(self):
        return self.nombre

    class Meta:
        # Ordenar alfabéticamente para los selectores de filtro
        ordering = ['nombre']


class Modulo(models.Model):
    """
    Representa un módulo o subcategoría dentro de un grupo.
    
    Los módulos son el segundo nivel de categorización y permiten
    un filtrado más específico dentro de cada grupo. Se utilizan en
    los formularios de filtrado como opciones dependientes del grupo.
    """
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField(blank=True, null=True)
    grupo = models.ForeignKey(
        Grupo, on_delete=models.CASCADE, related_name='modulos')
    activo = models.BooleanField(default=True)
    esquema_json = models.JSONField(blank=True, null=True,
                                    help_text="Esquema JSON para extracciones de la IA")

    def __str__(self):
        return f"{self.nombre} ({self.grupo.nombre})"

    class Meta:
        # Ordenar por grupo y luego por nombre
        ordering = ['grupo__nombre', 'nombre']
        # Evitar duplicados dentro del mismo grupo
        unique_together = ['nombre', 'grupo']


# ===============================================================
# MODELO PRINCIPAL DE DOCUMENTOS
# ===============================================================
# Define la estructura de los documentos que serán filtrados
# Incluye todos los campos por los que se puede realizar el filtrado
# ===============================================================
class Documento(models.Model):
    """
    Representa un documento en el sistema.
    
    Este es el modelo central del sistema de filtrado, con múltiples
    campos que permiten filtrar por diferentes criterios:
    - Por nombre/texto (nombre_documento)
    - Por categoría (grupo/módulo)
    - Por organización (empresa/servicio)
    - Por estado de procesamiento (status)
    - Por fecha (created_at)
    - Por usuario (usuario)
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    nombre_documento = models.CharField(
        max_length=255)  # Para búsqueda por texto
    nombre_unico = models.CharField(max_length=300, unique=True)
    ruta_documento = models.URLField()
    miniatura_documento = models.URLField(null=True, blank=True)
    tipo_archivo = models.CharField(max_length=100)  # Para filtrado por tipo
    origen_archivo = models.CharField(max_length=50, default='manual')
    created_at = models.DateTimeField(
        default=timezone.now)  # Para filtrado por fecha
    file_size = models.FloatField()  # tamaño en KB
    cantidad_hojas = models.IntegerField(default=1)
    status = models.CharField(
        max_length=20,
        choices=DocumentoStatus.choices,
        default=DocumentoStatus.EN_ESPERA
    )  # Para filtrado por estado
    json_data = models.JSONField(null=True, blank=True)
    ocr_data = models.TextField(null=True, blank=True)

    # Campos de texto para categorías (compatibilidad histórica)
    grupo = models.CharField(max_length=100, null=True, blank=True)
    modulo = models.CharField(max_length=100, null=True, blank=True)

    # Relaciones para filtrado organizacional
    servicio = models.ForeignKey(
        Servicio, on_delete=models.SET_NULL,
        null=True, blank=True, related_name='documentos'
    )  # Para filtrado por servicio
    empresa = models.ForeignKey(
        Empresa, on_delete=models.SET_NULL,
        null=True, blank=True, related_name='documentos'
    )  # Para filtrado por empresa
    usuario = models.ForeignKey(
        User, on_delete=models.SET_NULL,
        null=True, blank=True, related_name='documentos'
    )  # Para filtrado por usuario

    # Relaciones para filtrado por categorías
    grupo_obj = models.ForeignKey(
        Grupo, on_delete=models.SET_NULL,
        null=True, blank=True, related_name='documentos'
    )  # Para filtrado por grupo
    modulo_obj = models.ForeignKey(
        Modulo, on_delete=models.SET_NULL,
        null=True, blank=True, related_name='documentos'
    )  # Para filtrado por módulo

    def __str__(self):
        return f"{self.nombre_documento} ({self.status})"

    class Meta:
        ordering = ['-created_at']  # Ordenar por fecha descendente en listas


# ===============================================================
# MODELOS DE LICENCIAS Y CONSUMO
# ===============================================================
# Definen el sistema de licencias y seguimiento de consumo
# Permiten limitar y monitorear el uso del sistema
# ===============================================================
class PeriodoLicencia(models.Model):
    """
    Representa un período de licencia para una empresa.
    
    Define los límites de uso (hojas y almacenamiento) que puede consumir
    una empresa en un período determinado. Esto afecta indirectamente
    al filtrado al determinar qué empresas pueden subir nuevos documentos.
    """
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
    storage_licencia_mb_periodo = models.IntegerField(
        default=1024)  # Límite en Megabytes
    activo = models.BooleanField(default=True)

    def __str__(self):
        return f"Licencia para {self.empresa.nombre} ({self.get_tipo_periodo_display()}: {self.fecha_inicio.strftime('%d/%m/%Y')} - {self.fecha_fin.strftime('%d/%m/%Y')})"

    # Métodos para calcular el consumo actual
    def hojas_consumidas_periodo(self):
        consumo = HistorialConsumo.objects.filter(
            periodo_licencia=self,
            fecha_consumo__date__gte=self.fecha_inicio,
            fecha_consumo__date__lte=self.fecha_fin
        ).aggregate(total_hojas=Sum('hojas_consumidas'))
        return consumo['total_hojas'] or 0

    def storage_consumido_kb_periodo(self):
        consumo = HistorialConsumo.objects.filter(
            periodo_licencia=self,
            fecha_consumo__date__gte=self.fecha_inicio,
            fecha_consumo__date__lte=self.fecha_fin
        ).aggregate(total_storage=Sum('storage_consumido_kb'))
        return consumo['total_storage'] or 0

    # Métodos para verificar disponibilidad de licencia
    def licencia_hojas_disponible(self, hojas_adicionales=0):
        if not self.activo or self.fecha_fin < timezone.now().date():
            return False, "Periodo de licencia inactivo o caducado."
        
        disponible = (self.hojas_consumidas_periodo() + hojas_adicionales) <= self.hojas_licencia_periodo
        if not disponible:
            return False, f"Límite de hojas ({self.hojas_licencia_periodo}) excedido."
        return True, "OK"

    def licencia_storage_disponible_kb(self, storage_adicional_kb=0):
        if not self.activo or self.fecha_fin < timezone.now().date():
            return False, "Periodo de licencia inactivo o caducado."

        storage_licencia_kb = self.storage_licencia_mb_periodo * 1024.0
        disponible = (self.storage_consumido_kb_periodo() + storage_adicional_kb) <= storage_licencia_kb
        if not disponible:
            return False, f"Límite de almacenamiento ({self.storage_licencia_mb_periodo}MB) excedido."
        return True, "OK"

    class Meta:
        ordering = ['empresa', '-fecha_fin',
                    '-fecha_inicio']  # Más reciente primero
        verbose_name = "Periodo de Licencia"
        verbose_name_plural = "Periodos de Licencia"
        constraints = [
            models.CheckConstraint(check=models.Q(fecha_fin__gte=models.F('fecha_inicio')), name='fecha_fin_gte_fecha_inicio')
        ]


class HistorialConsumo(models.Model):
    """
    Registra el consumo de recursos por cada documento.
    
    Este modelo permite hacer seguimiento del consumo de recursos
    (hojas y almacenamiento) para verificar el cumplimiento de las
    licencias. Se puede utilizar para filtrado avanzado de estadísticas.
    """
    periodo_licencia = models.ForeignKey(PeriodoLicencia, on_delete=models.CASCADE, related_name='historial_consumo')
    documento = models.ForeignKey(Documento, on_delete=models.SET_NULL, null=True, blank=True)
    usuario = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    fecha_consumo = models.DateTimeField(default=timezone.now)
    hojas_consumidas = models.IntegerField(default=0)
    storage_consumido_kb = models.FloatField(default=0)  # Consumo en Kilobytes

    def __str__(self):
        user_str = self.usuario.username if self.usuario else "Sistema"
        doc_str = f" - Doc: {self.documento.nombre_documento[:20]}..." if self.documento else ""
        return f"Consumo por {user_str} el {self.fecha_consumo.strftime('%Y-%m-%d %H:%M')}{doc_str}"

    class Meta:
        ordering = ['-fecha_consumo']
        verbose_name = "Historial de Consumo"
        verbose_name_plural = "Historiales de Consumo"


