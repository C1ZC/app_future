from django.contrib import admin
from .models import Empresa, Servicio, PerfilUsuario, Documento, PeriodoLicencia, HistorialConsumo # Añadir Documento, PeriodoLicencia, HistorialConsumo

admin.site.register(Empresa)
admin.site.register(Servicio)
admin.site.register(PerfilUsuario)
admin.site.register(Documento) 

@admin.register(PeriodoLicencia)
class PeriodoLicenciaAdmin(admin.ModelAdmin):
    list_display = ('empresa', 'tipo_periodo', 'fecha_inicio', 'fecha_fin', 'hojas_licencia_periodo', 'storage_licencia_mb_periodo', 'activo', 'hojas_consumidas_display', 'storage_consumido_display')
    list_filter = ('empresa', 'tipo_periodo', 'activo', 'fecha_inicio', 'fecha_fin')
    search_fields = ('empresa__nombre',)
    actions = ['activar_licencias', 'desactivar_licencias']
    readonly_fields = ('hojas_consumidas_display', 'storage_consumido_display')

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

    def hojas_consumidas_display(self, obj):
        return obj.hojas_consumidas_periodo()
    hojas_consumidas_display.short_description = "Hojas Consumidas"

    def storage_consumido_display(self, obj):
        return f"{obj.storage_consumido_kb_periodo():.2f} KB"
    storage_consumido_display.short_description = "Storage Consumido"

    def activar_licencias(self, request, queryset):
        queryset.update(activo=True)
    activar_licencias.short_description = "Activar periodos de licencia seleccionados"

    def desactivar_licencias(self, request, queryset):
        queryset.update(activo=False)
    desactivar_licencias.short_description = "Desactivar periodos de licencia seleccionados"

@admin.register(HistorialConsumo)
class HistorialConsumoAdmin(admin.ModelAdmin):
    list_display = ('periodo_licencia_info', 'usuario', 'documento_nombre', 'fecha_consumo', 'hojas_consumidas', 'storage_consumido_kb_display')
    list_filter = ('periodo_licencia__empresa', 'usuario', 'fecha_consumo', 'periodo_licencia__tipo_periodo')
    search_fields = ('usuario__username', 'documento__nombre_documento', 'periodo_licencia__empresa__nombre')
    readonly_fields = ('fecha_consumo', 'periodo_licencia', 'documento', 'usuario', 'hojas_consumidas', 'storage_consumido_kb') # Hacer todo readonly

    def periodo_licencia_info(self, obj):
        return str(obj.periodo_licencia)
    periodo_licencia_info.short_description = "Periodo de Licencia"

    def documento_nombre(self, obj):
        return obj.documento.nombre_documento if obj.documento else "N/A"
    documento_nombre.short_description = "Documento"
    
    def storage_consumido_kb_display(self, obj):
        return f"{obj.storage_consumido_kb:.2f} KB"
    storage_consumido_kb_display.short_description = "Storage Consumido"

    def has_add_permission(self, request): # No permitir añadir historial manualmente
        return False

    def has_change_permission(self, request, obj=None): # No permitir cambiar historial manualmente
        return False