from django.db import connection
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from webapp.forms.document_forms import DocumentoUploadForm, DocumentoFilterForm
from webapp.models import Documento, DocumentoStatus, Servicio  # Importar Servicio
from webapp.service.document_service import DocumentoService
from django.core.paginator import Paginator
from django.db.models import Q
from django.http import JsonResponse
import json
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings

@login_required
def documento_upload(request):
    if request.method == 'POST':
        form = DocumentoUploadForm(request.POST, request.FILES)
        if form.is_valid():
            archivo = request.FILES.get('archivo')
            grupo = form.cleaned_data.get('grupo')
            modulo = form.cleaned_data.get('modulo')
            # Si tienes un campo para seleccionar el servicio en el formulario:
            servicio_id = form.cleaned_data.get('servicio_id')
            servicio_obj = None
            if servicio_id:
                try:
                    servicio_obj = Servicio.objects.get(id=servicio_id)
                except Servicio.DoesNotExist:
                    messages.error(request, "Servicio seleccionado no válido.")
                    return render(request, 'documents/upload_documents.html', {'form': form})
            
            if not archivo:
                messages.error(request, "Debe seleccionar un archivo.")
            else:
                # Pasar servicio_obj si lo obtienes del formulario, sino se tomará del perfil del usuario si existe
                success, message, documento_creado = DocumentoService.procesar_archivo(
                    file=archivo,
                    filename=archivo.name,
                    usuario=request.user,
                    grupo=grupo,
                    modulo=modulo
                    # servicio_obj=servicio_obj # Descomentar si obtienes servicio del form
                )
            
                if success:
                    messages.success(
                        request, f"Documento '{documento_creado.nombre_documento}' subido. {message}")
                    # O a 'documento_detalle' si prefieres
                    return redirect('documento_lista')
                else:
                    messages.error(
                        request, f"Error al procesar el documento: {message}")
    else:
        # Puedes pasar request.user al form si necesitas filtrar campos (ej. servicios)
        form = DocumentoUploadForm()
    
    return render(request, 'documents/upload_documents.html', {
        'form': form
    })

@login_required
def documento_lista(request):
    # Inicializar formulario de filtro y query base
    filter_form = DocumentoFilterForm(request.GET)
    query = Q()

    # Filtrar por servicio si se proporciona en la URL
    servicio_id = request.GET.get('servicio')
    if servicio_id:
        query &= Q(servicio_id=servicio_id)
    
    # Aplicar filtros del usuario actual según rol
    if not request.user.is_superuser:
        perfil = request.user.perfil
        if perfil.es_admin_empresa():
            # Ver documentos de su empresa
            query &= Q(empresa=perfil.empresa)
        elif perfil.es_admin_servicio():
            # Ver documentos de su servicio
            query &= Q(servicio=perfil.servicio)
        else:
            # Usuario normal, solo ve sus documentos
            query &= Q(usuario=request.user)
    
    # Aplicar filtros de búsqueda
    if filter_form.is_valid():
        texto = filter_form.cleaned_data.get('texto_busqueda')
        estado = filter_form.cleaned_data.get('estado')
        fecha_desde = filter_form.cleaned_data.get('fecha_desde')
        fecha_hasta = filter_form.cleaned_data.get('fecha_hasta')
        
        if texto:
            query &= Q(nombre_documento__icontains=texto) | Q(grupo__icontains=texto) | Q(modulo__icontains=texto)
        
        if estado:
            query &= Q(status=estado)
        
        if fecha_desde:
            query &= Q(created_at__date__gte=fecha_desde)
            
        if fecha_hasta:
            query &= Q(created_at__date__lte=fecha_hasta)
    
    # Obtener documentos filtrados y paginar
    documentos = Documento.objects.filter(query).order_by('-created_at')
    paginator = Paginator(documentos, 10)  # 10 documentos por página
    page_number = request.GET.get('page', 1)
    documentos_pagina = paginator.get_page(page_number)

    return render(request, 'documents/list_documents.html', {
        'documentos': documentos_pagina,
        'filter_form': filter_form
    })

@login_required
def documento_detalle(request, doc_id):
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




# Elimina el decorador @login_required
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
        
        if json_data:
            documento.json_data = json_data
        
        documento.status = status
        documento.save()
        
        return JsonResponse({'success': True, 'documento_id': str(doc_id), 'data': data})
        
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
        documentos = Documento.objects.filter(status=DocumentoStatus.EN_ESPERA).order_by('-created_at')[:limit]
        
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
                'usuario_id': doc.usuario.id if doc.usuario else None
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
        documento.save()

        return JsonResponse({'success': True, 'documento_id': doc_id, 'cantidad_fragmentos': cantidad_fragmentos})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=400)
