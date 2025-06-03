# ===============================================================
# DASHBOARD DE CONSUMO DE LICENCIAS
# ===============================================================
# Este módulo proporciona vistas para visualizar el consumo de
# licencias por empresa, mostrando métricas de uso y alertas
# cuando se acercan a sus límites de licencia.
# ===============================================================

# Importaciones estándar de Django
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.utils import timezone

# Importaciones de modelos y servicios propios
from webapp.models import PeriodoLicencia, Empresa, HistorialConsumo
from webapp.service.document_service import DocumentoService  # Para get_periodo_licencia_activo

# ===============================================================
# DASHBOARD PRINCIPAL DE CONSUMO
# ===============================================================
@login_required
def dashboard_consumo_empresa(request):
    """
    Muestra el dashboard de consumo de licencias para una empresa.
    
    Funcionalidades:
    - Para superadmins: permite seleccionar la empresa a visualizar
    - Para usuarios normales: muestra solo su empresa asociada
    - Calcula y muestra métricas de consumo (hojas y almacenamiento)
    - Genera alertas según niveles de consumo
    
    Returns:
        Página HTML renderizada con datos de consumo y alertas
    """
    # ---------------------------------------------------------------
    # 1. Inicialización de variables y determinación de empresa
    # ---------------------------------------------------------------
    perfil = getattr(request.user, 'perfil', None)
    empresa_para_dashboard = None
    periodo_activo = None
    consumo_data = {}
    alerta_mensaje = None
    empresas_disponibles_para_superadmin = None

    # ---------------------------------------------------------------
    # 2. Determinar la empresa a mostrar según el tipo de usuario
    # ---------------------------------------------------------------
    if request.user.is_superuser:
        # Para superadmins: mostrar empresa seleccionada o selector
        empresa_id_param = request.GET.get('empresa_id')
        if empresa_id_param:
            try:
                empresa_para_dashboard = Empresa.objects.get(id=empresa_id_param)
            except Empresa.DoesNotExist:
                messages.error(request, "Empresa seleccionada no encontrada.")
                return redirect('dashboard_consumo_empresa')  # Redirige para limpiar el parámetro
        # Lista de empresas para el selector (solo superadmin)
        empresas_disponibles_para_superadmin = Empresa.objects.all().order_by('nombre')
    elif perfil and perfil.empresa:
        # Para usuarios normales: mostrar su empresa asociada
        empresa_para_dashboard = perfil.empresa
    else:  # Usuario regular sin empresa o superadmin sin seleccionar
        if not request.user.is_superuser:
            messages.warning(request, "No estás asociado a ninguna empresa para ver el consumo.")
        # Para superadmin, se mostrará el selector si no eligió empresa.

    # ---------------------------------------------------------------
    # 3. Calcular métricas de consumo si hay empresa seleccionada
    # ---------------------------------------------------------------
    if empresa_para_dashboard:
        # Obtener periodo activo de licencia
        periodo_activo = DocumentoService.get_periodo_licencia_activo(empresa_para_dashboard)
        if periodo_activo:
            # Calcular consumo actual
            hojas_usadas = periodo_activo.hojas_consumidas_periodo()
            storage_usado_kb = periodo_activo.storage_consumido_kb_periodo()
            
            # Obtener límites de licencia
            hojas_total_licencia = periodo_activo.hojas_licencia_periodo
            storage_total_licencia_kb = periodo_activo.storage_licencia_mb_periodo * 1024.0

            # Preparar datos de consumo para la vista
            consumo_data = {
                'empresa_nombre': empresa_para_dashboard.nombre,
                'periodo_info': f"{periodo_activo.get_tipo_periodo_display()} (Vence: {periodo_activo.fecha_fin.strftime('%d/%m/%Y')})",
                'hojas_usadas': hojas_usadas,
                'hojas_total': hojas_total_licencia,
                'hojas_porcentaje': (hojas_usadas / hojas_total_licencia * 100) if hojas_total_licencia > 0 else 0,
                'storage_usado_kb': storage_usado_kb,
                'storage_total_kb': storage_total_licencia_kb,
                'storage_porcentaje': (storage_usado_kb / storage_total_licencia_kb * 100) if storage_total_licencia_kb > 0 else 0,
                'hojas_restantes': hojas_total_licencia - hojas_usadas,
                'storage_restante_mb': (storage_total_licencia_kb - storage_usado_kb) / 1024.0,
            }

            # ---------------------------------------------------------------
            # 4. Sistema de alertas basado en umbrales de consumo
            # ---------------------------------------------------------------
            if consumo_data['hojas_porcentaje'] >= 100 or consumo_data['storage_porcentaje'] >= 100:
                # Alerta crítica: límite excedido (rojo)
                alerta_mensaje = f"¡Alerta Límite Excedido! La empresa {empresa_para_dashboard.nombre} ha superado uno o más límites de su licencia actual."
                messages.error(request, alerta_mensaje)
            elif consumo_data['hojas_porcentaje'] > 90 or consumo_data['storage_porcentaje'] > 90:
                # Alerta alta: más del 90% consumido (amarillo)
                alerta_mensaje = f"Atención: La empresa {empresa_para_dashboard.nombre} está cerca (más del 90%) de alcanzar sus límites de licencia."
                messages.warning(request, alerta_mensaje)
            elif consumo_data['hojas_porcentaje'] > 75 or consumo_data['storage_porcentaje'] > 75:
                # Alerta media: más del 75% consumido (azul)
                alerta_mensaje = f"Aviso: La empresa {empresa_para_dashboard.nombre} ha consumido más del 75% de alguno de sus límites."
                messages.info(request, alerta_mensaje)
        else:
            # No hay periodo de licencia activo
            messages.info(request, f"La empresa '{empresa_para_dashboard.nombre}' no tiene un periodo de licencia activo o válido en este momento.")
    
    # ---------------------------------------------------------------
    # 5. Renderizar la vista con todos los datos
    # ---------------------------------------------------------------
    context = {
        'consumo_data': consumo_data,
        # 'alerta_mensaje': alerta_mensaje,  # Las alertas ahora se manejan con messages de Django
        'empresa_actual_dashboard': empresa_para_dashboard,
        'empresas_disponibles_para_superadmin': empresas_disponibles_para_superadmin,
        'periodo_activo': periodo_activo,
    }
    return render(request, 'pages/dashboard.html', context)