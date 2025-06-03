# ===============================================================
# IMPORTACIONES NECESARIAS
# ===============================================================
from django.db import connection
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from webapp.forms.document_forms import DocumentoUploadForm, DocumentoFilterForm
from webapp.models import Documento, DocumentoStatus, Grupo, Modulo, Servicio
from webapp.service.document_service import DocumentoService
from django.core.paginator import Paginator
from django.db.models import Q
from django.http import JsonResponse
import json
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings

# ===============================================================
# CARGA DE DOCUMENTOS
# ===============================================================
@login_required
def documento_upload(request):
    """
    Gestiona la subida de documentos al sistema.
    
    Esta vista maneja tanto la presentación del formulario (GET)
    como el procesamiento del archivo subido (POST).
    """
    if request.method == 'POST':
        form = DocumentoUploadForm(
            request.POST, request.FILES, request_user=request.user)

        # Debug: Verificar si hay archivos en la solicitud
        print("FILES:", request.FILES)

        # Debug: Verificar los datos enviados
        print("POST data:", request.POST)

        if form.is_valid():
            print("Formulario es válido")
            archivo = request.FILES.get('archivo')
            grupo_obj = form.cleaned_data.get('grupo_id')
            modulo_obj = form.cleaned_data.get('modulo_id')

            # Debug: Verificar valores obtenidos
            print(
                f"Archivo: {archivo}, Grupo: {grupo_obj}, Módulo: {modulo_obj}")

            # Obtener nombres para compatibilidad
            grupo_texto = grupo_obj.nombre if grupo_obj else None
            modulo_texto = modulo_obj.nombre if modulo_obj else None

            if not archivo:
                messages.error(request, "Debe seleccionar un archivo.")
                return render(request, 'documents/upload_documents.html', {'form': form})

            try:
                # Servicios y procesamiento
                servicio_obj = None
                if hasattr(request.user, 'perfil') and hasattr(request.user.perfil, 'servicio'):
                    servicio_obj = request.user.perfil.servicio

                # Debug: Verificar antes de procesar
                print(
                    f"Procesando archivo: {archivo.name}, tamaño: {archivo.size}")

                success, message, documento_creado = DocumentoService.procesar_archivo(
                    file=archivo,
                    filename=archivo.name,
                    usuario=request.user,
                    grupo=grupo_texto,
                    modulo=modulo_texto,
                    servicio_obj=servicio_obj
                )

                # Debug: Resultado del procesamiento
                print(
                    f"Resultado: success={success}, mensaje={message}, documento={documento_creado}")

                if success and documento_creado:
                    documento_creado.grupo_obj = grupo_obj
                    documento_creado.modulo_obj = modulo_obj
                    documento_creado.save()

                    messages.success(
                        request, f"Documento '{documento_creado.nombre_documento}' subido correctamente.")
                    return redirect('documento_lista')
                else:
                    messages.error(
                        request, f"Error al procesar el documento: {message}")
            except Exception as e:
                print(f"ERROR EN PROCESAMIENTO: {str(e)}")
                messages.error(request, f"Error inesperado: {str(e)}")
        else:
            print("Formulario NO es válido, errores:", form.errors)
            print("Módulos disponibles:", list(
                form.fields['modulo_id'].queryset.values('id', 'nombre')))
            messages.error(
                request, "El formulario contiene errores. Por favor revise los campos.")
    else:
        form = DocumentoUploadForm(request_user=request.user)

    return render(request, 'documents/upload_documents.html', {'form': form})

# ===============================================================
# FORMULARIO PARA FILTRADO DE DOCUMENTOS
# ===============================================================
@login_required
def documento_lista(request):
    """
    Muestra una lista filtrable de documentos.
    
    Esta vista implementa un sistema completo de filtrado con múltiples criterios:
    1. Filtros de URL (ej: servicio específico)
    2. Filtros de seguridad (basados en el rol del usuario)
    3. Filtros de formulario (texto, fechas, estado)
    """
    # ---------------------------------------------------------------
    # 1. INICIALIZACIÓN DE FILTROS
    # ---------------------------------------------------------------
    # Crear formulario con datos de la petición GET (para mantener filtros entre páginas)
    filter_form = DocumentoFilterForm(request.GET)
    
    # Inicializar query base vacío - se irán añadiendo condiciones
    query = Q()

    # ---------------------------------------------------------------
    # 2. FILTRADO POR SERVICIO (DE URL)
    # ---------------------------------------------------------------
    # Este filtro se aplica cuando se accede desde el menú de servicios
    servicio_id = request.GET.get('servicio')
    servicio_actual = None
    
    if servicio_id:
        try:
            # Obtener objeto servicio para mostrar en la interfaz
            servicio_actual = Servicio.objects.get(id=servicio_id)
            # Añadir condición al query para filtrar por este servicio
            query &= Q(servicio_id=servicio_id)
        except Servicio.DoesNotExist:
            messages.warning(request, "El servicio seleccionado no existe.")

    # ---------------------------------------------------------------
    # 3. FILTRADO POR PERMISOS (SEGÚN ROL)
    # ---------------------------------------------------------------
    # Restringir los documentos según el rol del usuario
    if not request.user.is_superuser:
        perfil = request.user.perfil
        if perfil.es_admin_empresa():
            # Admins de empresa ven documentos de su empresa
            query &= Q(empresa=perfil.empresa)
        elif perfil.es_admin_servicio():
            # Admins de servicio ven documentos de su servicio
            query &= Q(servicio=perfil.servicio)
        else:
            # Usuarios normales solo ven sus propios documentos
            query &= Q(usuario=request.user)

    # ---------------------------------------------------------------
    # 4. FILTRADO POR CRITERIOS DE BÚSQUEDA (DEL FORMULARIO)
    # ---------------------------------------------------------------
    # Procesar filtros si el formulario es válido
    if filter_form.is_valid():
        # Extraer valores de los campos del formulario
        texto = filter_form.cleaned_data.get('texto_busqueda')
        estado = filter_form.cleaned_data.get('estado')
        fecha_desde = filter_form.cleaned_data.get('fecha_desde')
        fecha_hasta = filter_form.cleaned_data.get('fecha_hasta')

        # Filtrar por texto (busca en múltiples campos)
        if texto:
            # Búsqueda en varios campos con OR lógico
            query &= Q(nombre_documento__icontains=texto) | Q(
                grupo__icontains=texto) | Q(modulo__icontains=texto)

        # Filtrar por estado del documento
        if estado:
            query &= Q(status=estado)

        # Filtrar por rango de fechas
        if fecha_desde:
            query &= Q(created_at__date__gte=fecha_desde)  # Mayor o igual que fecha_desde

        if fecha_hasta:
            query &= Q(created_at__date__lte=fecha_hasta)  # Menor o igual que fecha_hasta

    # ---------------------------------------------------------------
    # 5. EJECUCIÓN DE CONSULTA Y PAGINACIÓN
    # ---------------------------------------------------------------
    # Aplicar todos los filtros y ordenar por fecha descendente
    documentos = Documento.objects.filter(query).order_by('-created_at')
    
    # Configurar paginación (10 documentos por página)
    paginator = Paginator(documentos, 10)
    page_number = request.GET.get('page', 1)  # Obtener número de página, default 1
    documentos_pagina = paginator.get_page(page_number)  # Obtener página actual

    # Renderizar plantilla con resultados
    return render(request, 'documents/list_documents.html', {
        'documentos': documentos_pagina,  # Lista paginada de documentos
        'filter_form': filter_form,       # Formulario con valores actuales
        'servicio_actual': servicio_actual  # Para mostrar el servicio filtrado
    })

# ===============================================================
# DETALLE DE DOCUMENTOS
# ===============================================================
@login_required
def documento_detalle(request, doc_id):
    """
    Muestra el detalle completo de un documento específico.
    
    Incluye validación de permisos según el rol del usuario
    y el procesamiento del JSON de datos extraídos.
    """
    documento = get_object_or_404(Documento, pk=doc_id)

    # Verificar permisos según rol
    if not request.user.is_superuser:
        perfil = request.user.perfil
        if perfil.es_admin_empresa() and documento.empresa != perfil.empresa:
            messages.error(request, "No tiene permiso para ver este documento")
            return redirect('documento_lista')
        elif perfil.es_admin_servicio() and documento.servicio != perfil.servicio:
            messages.error(request, "No tiene permiso para ver este documento")
            return redirect('documento_lista')
        elif perfil.es_usuario_servicio() and documento.usuario != request.user:
            messages.error(request, "No tiene permiso para ver este documento")
            return redirect('documento_lista')

    # Formatear el JSON para la plantilla
    json_data_pretty = None
    if documento.json_data:
        try:
            # Convertir a formato para la plantilla
            import json
            if isinstance(documento.json_data, str):
                json_data = json.loads(documento.json_data)
            else:
                json_data = documento.json_data

            json_data_pretty = json.dumps(json_data)
        except Exception as e:
            print(f"Error procesando JSON: {e}")
            json_data_pretty = "{}"

    context = {
        'documento': documento,
        'json_data_pretty': json_data_pretty,
    }
    return render(request, 'documents/detail_document.html', context)

# ===============================================================
# ENDPOINTS API PARA PROCESAMIENTO ASÍNCRONO
# ===============================================================
@csrf_exempt
def documento_webhook(request):
    """Endpoint para recibir actualizaciones de n8n"""
    if request.method != 'POST':
        return JsonResponse({'error': 'Método no permitido'}, status=405)

    # Autenticación simple por API_KEY
    api_key = request.headers.get('X-Api-Key')
    if not api_key or api_key != settings.N8N_API_KEY:
        return JsonResponse({'error': 'No autorizado'}, status=401)

    try:
        data = json.loads(request.body)
        doc_id = data.get('documento_id')
        ocr_data = data.get('ocr_data')
        json_data = data.get('json_data')
        status = data.get('status', DocumentoStatus.COMPLETADO)

        if not doc_id:
            return JsonResponse({'error': 'ID de documento requerido'}, status=400)

        documento = get_object_or_404(Documento, pk=doc_id)

        # Actualizar documento con datos de OCR/IA
        if ocr_data:
            documento.ocr_data = ocr_data

        # Limpiar y serializar json_data si es string
        import json as pyjson
        if json_data:
            if isinstance(json_data, str):
                try:
                    # Elimina saltos de línea y espacios innecesarios
                    json_data_clean = json_data.replace('\n', '').replace('\r', '').strip()
                    json_data_obj = pyjson.loads(json_data_clean)
                except Exception as e:
                    return JsonResponse({'error': f'Error procesando json_data: {e}'}, status=400)
            else:
                json_data_obj = json_data
            # Guarda el JSON serializado y limpio
            documento.json_data = pyjson.dumps(json_data_obj, ensure_ascii=False)

        documento.status = status
        documento.save()

        return JsonResponse({
            'success': True,
            'documento_id': str(doc_id),
            'data': data
        })

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=400)


@csrf_exempt
def documento_pendientes(request):
    """Endpoint para que n8n obtenga documentos pendientes de procesar"""
    if request.method != 'GET':
        return JsonResponse({'error': 'Método no permitido'}, status=405)

    # Autenticación simple por API_KEY
    api_key = request.headers.get('X-Api-Key')
    if not api_key or api_key != settings.N8N_API_KEY:
        return JsonResponse({'error': 'No autorizado'}, status=401)

    try:
        # Obtener los 10 documentos más recientes en estado "En espera"
        limit = int(request.GET.get('limit', 10))
        documentos = Documento.objects.filter(
            status=DocumentoStatus.EN_ESPERA).order_by('-created_at')[:limit]

        # Convertir a formato JSON
        docs_list = []
        for doc in documentos:
            docs_list.append({
                'documento_id': str(doc.id),
                'nombre_documento': doc.nombre_documento,
                'nombre_unico': doc.nombre_unico,
                'ruta_documento': doc.ruta_documento,
                'tipo_archivo': doc.tipo_archivo,
                'cantidad_hojas': doc.cantidad_hojas,
                'created_at': doc.created_at.isoformat(),
                'empresa_id': str(doc.empresa.id) if doc.empresa else None,
                'servicio_id': str(doc.servicio.id) if doc.servicio else None,
                'usuario_id': doc.usuario.id if doc.usuario else None,
                # Agregar datos de grupo y módulo
                'grupo': doc.grupo,
                'grupo_obj': {
                    'id': doc.grupo_obj.id,
                    'nombre': doc.grupo_obj.nombre
                } if doc.grupo_obj else None,
                'modulo': doc.modulo,
                'modulo_obj': {
                    'id': doc.modulo_obj.id,
                    'nombre': doc.modulo_obj.nombre,
                    'esquema_json': doc.modulo_obj.esquema_json
                } if doc.modulo_obj else None,
            })

        return JsonResponse({'documentos': docs_list})

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=400)

@csrf_exempt
def documento_update_fragmentos(request):
    """
    Endpoint para actualizar la tabla documents:
    - Coloca el document_id en las filas donde está NULL,
      solo la cantidad de veces indicada por cantidad_fragmentos.
    - Luego actualiza el modelo Documento con ese conteo.
    """
    if request.method != 'POST':
        return JsonResponse({'error': 'Método no permitido'}, status=405)

    api_key = request.headers.get('X-Api-Key')
    if not api_key or api_key != settings.N8N_API_KEY:
        return JsonResponse({'error': 'No autorizado'}, status=401)

    try:
        if request.content_type == 'application/json':
            data = json.loads(request.body)
        else:
            data = request.POST
        doc_id = data.get('document_id')
        cantidad_fragmentos = data.get('cantidad_fragmentos')
        if not doc_id or cantidad_fragmentos is None:
            return JsonResponse({'error': 'Faltan parámetros'}, status=400)

        # Actualizar las filas en documents donde document_id IS NULL
        with connection.cursor() as cursor:
            cursor.execute("""
                UPDATE documents
                SET document_id = %s
                WHERE id IN (
                    SELECT id FROM documents
                    WHERE document_id IS NULL
                    ORDER BY id
                    LIMIT %s
                )
            """, [doc_id, cantidad_fragmentos])

        # Actualizar el modelo Documento
        documento = Documento.objects.get(pk=doc_id)
        documento.cantidad_fragmentos = cantidad_fragmentos
        documento.status = DocumentoStatus.COMPLETADO
        documento.save()

        return JsonResponse({'success': True, 'documento_id': doc_id, 'cantidad_fragmentos': cantidad_fragmentos})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=400)

# ===============================================================
# ENDPOINTS API AUXILIARES
# ===============================================================
def get_modulos_por_grupo(request):
    """API para obtener módulos filtrados por grupo"""
    grupo_id = request.GET.get('grupo_id')
    modulos = []

    if grupo_id:
        modulos = list(Modulo.objects.filter(
            grupo_id=grupo_id, activo=True
        ).values('id', 'nombre'))

    return JsonResponse({'modulos': modulos})
