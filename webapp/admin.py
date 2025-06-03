# ===============================================================
# CONFIGURACIÓN DEL PANEL DE ADMINISTRACIÓN DE DJANGO
# ===============================================================
# Este módulo configura la interfaz del panel de administración de Django,
# personalizando la visualización y operaciones disponibles para cada modelo.
# ===============================================================

from django.contrib import admin
from .models import Empresa, Servicio, PerfilUsuario, Documento, PeriodoLicencia, HistorialConsumo

# ===============================================================
# REGISTROS BÁSICOS DE MODELOS
# ===============================================================
# Registros simples para modelos que no requieren personalización extensa
admin.site.register(Empresa)
admin.site.register(Servicio)
admin.site.register(PerfilUsuario)
admin.site.register(Documento) 

# ===============================================================
# ADMINISTRACIÓN DE PERIODOS DE LICENCIA
# ===============================================================
@admin.register(PeriodoLicencia)
class PeriodoLicenciaAdmin(admin.ModelAdmin):
    """
    Configuración del panel de administración para períodos de licencia.
    
    Esta clase proporciona:
    - Columnas personalizadas en la vista de lista
    - Filtros laterales para facilitar la búsqueda
    - Acciones masivas para activar/desactivar licencias
    - Organización de campos en secciones lógicas
    """
    # Campos visibles en la vista de lista
    list_display = ('empresa', 'tipo_periodo', 'fecha_inicio', 'fecha_fin', 
                    'hojas_licencia_periodo', 'storage_licencia_mb_periodo', 
                    'activo', 'hojas_consumidas_display', 'storage_consumido_display')
    
    # Filtros disponibles en la barra lateral
    list_filter = ('empresa', 'tipo_periodo', 'activo', 'fecha_inicio', 'fecha_fin')
    
    # Campo para búsqueda por texto
    search_fields = ('empresa__nombre',)
    
    # Acciones masivas disponibles
    actions = ['activar_licencias', 'desactivar_licencias']
    
    # Campos que no se pueden modificar (solo visualización)
    readonly_fields = ('hojas_consumidas_display', 'storage_consumido_display')

    # Organización de campos en secciones en el formulario de edición
    fieldsets = (
        (None, {
            'fields': ('empresa', 'tipo_periodo', 'activo')
        }),
        ('Duración y Límites', {
            'fields': ('fecha_inicio', 'fecha_fin', 'hojas_licencia_periodo', 'storage_licencia_mb_periodo')
        }),
        ('Consumo Actual (Informativo)', {
            'fields': ('hojas_consumidas_display', 'storage_consumido_display'),
            'classes': ('collapse',), # Opcional: colapsar esta sección
        }),
    )

    # Métodos para calcular y mostrar valores dinámicos
    def hojas_consumidas_display(self, obj):
        """Muestra el consumo actual de hojas para este período"""
        return obj.hojas_consumidas_periodo()
    hojas_consumidas_display.short_description = "Hojas Consumidas"

    def storage_consumido_display(self, obj):
        """Muestra el consumo actual de almacenamiento en KB"""
        return f"{obj.storage_consumido_kb_periodo():.2f} KB"
    storage_consumido_display.short_description = "Storage Consumido"

    # Acciones personalizadas
    def activar_licencias(self, request, queryset):
        """Activa todos los períodos de licencia seleccionados"""
        queryset.update(activo=True)
    activar_licencias.short_description = "Activar periodos de licencia seleccionados"

    def desactivar_licencias(self, request, queryset):
        """Desactiva todos los períodos de licencia seleccionados"""
        queryset.update(activo=False)
    desactivar_licencias.short_description = "Desactivar periodos de licencia seleccionados"

# ===============================================================
# ADMINISTRACIÓN DE HISTORIAL DE CONSUMO
# ===============================================================
@admin.register(HistorialConsumo)
class HistorialConsumoAdmin(admin.ModelAdmin):
    """
    Configuración del panel de administración para el historial de consumo.
    
    Esta clase proporciona:
    - Vista solo lectura (sin edición ni creación manual)
    - Filtros avanzados para analizar el consumo
    - Visualización clara de relaciones entre modelos
    """
    # Campos visibles en la vista de lista
    list_display = ('periodo_licencia_info', 'usuario', 'documento_nombre', 
                   'fecha_consumo', 'hojas_consumidas', 'storage_consumido_kb_display')
    
    # Filtros disponibles (incluyen relaciones a otros modelos)
    list_filter = ('periodo_licencia__empresa', 'usuario', 'fecha_consumo', 
                  'periodo_licencia__tipo_periodo')
    
    # Campos para búsqueda por texto (incluyen relaciones)
    search_fields = ('usuario__username', 'documento__nombre_documento', 
                    'periodo_licencia__empresa__nombre')
    
    # Todo es solo lectura para prevenir modificaciones manuales
    readonly_fields = ('fecha_consumo', 'periodo_licencia', 'documento', 
                      'usuario', 'hojas_consumidas', 'storage_consumido_kb')

    # Métodos para mostrar información de relaciones
    def periodo_licencia_info(self, obj):
        """Muestra información del período de licencia asociado"""
        return str(obj.periodo_licencia)
    periodo_licencia_info.short_description = "Periodo de Licencia"

    def documento_nombre(self, obj):
        """Muestra el nombre del documento asociado al consumo"""
        return obj.documento.nombre_documento if obj.documento else "N/A"
    documento_nombre.short_description = "Documento"
    
    def storage_consumido_kb_display(self, obj):
        """Formatea el consumo de almacenamiento con 2 decimales"""
        return f"{obj.storage_consumido_kb:.2f} KB"
    storage_consumido_kb_display.short_description = "Storage Consumido"

    # Desactivar permisos de creación
    def has_add_permission(self, request):
        """No permite añadir registros de historial manualmente"""
        return False

    # Desactivar permisos de edición
    def has_change_permission(self, request, obj=None):
        """No permite modificar registros de historial manualmente"""
        return False