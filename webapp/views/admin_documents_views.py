from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.db.models import Q
from django.http import JsonResponse
from webapp.models import Documento, Empresa, Servicio
from webapp.service.roles import rol_requerido, RolUsuario
from webapp.service.supabase_client import supabase_public
from django.core.paginator import Paginator
import json

@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def admin_documentos(request):
    """Panel de administración de documentos para superusuarios"""
    # Filtros
    empresa_id = request.GET.get('empresa')
    servicio_id = request.GET.get('servicio')
    query = Q()
    
    if empresa_id:
        query &= Q(empresa_id=empresa_id)
    if servicio_id:
        query &= Q(servicio_id=servicio_id)
    
    # Obtener documentos
    documentos = Documento.objects.filter(query).order_by('-created_at')
    paginator = Paginator(documentos, 20)  # 20 documentos por página
    page_number = request.GET.get('page', 1)
    documentos_pagina = paginator.get_page(page_number)
    
    # Obtener empresas y servicios para los filtros
    empresas = Empresa.objects.all().order_by('nombre')
    servicios = Servicio.objects.all().order_by('nombre')
    
    return render(request, 'administration/documents/admin_documents.html', {
        'documentos': documentos_pagina,
        'empresas': empresas,
        'servicios': servicios,
        'empresa_seleccionada': empresa_id,
        'servicio_seleccionado': servicio_id
    })

@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def eliminar_documento(request, doc_id):
    """Elimina un documento de la base de datos y del storage"""
    if request.method != 'POST':
        return JsonResponse({'error': 'Método no permitido'}, status=405)
        
    documento = get_object_or_404(Documento, pk=doc_id)
    
    try:
        # Eliminar del storage
        nombre_unico = documento.nombre_unico
        try:
            supabase_public.storage.from_("documents").remove([nombre_unico])
        except Exception as e:
            # Continuar incluso si falla la eliminación del storage
            messages.warning(request, f"No se pudo eliminar del storage: {str(e)}. Utilice la gestión de archivos storage para eliminarlo manualmente.")
            print(f"Error al eliminar del storage: {str(e)}")
        # Eliminar de la base de datos vectorial
        from django.db import connection
        with connection.cursor() as cursor:
            cursor.execute("DELETE FROM documents WHERE document_id = %s", [str(doc_id)])
            
        # Eliminar de la base de datos principal
        documento.delete()
        
        messages.success(request, f"Documento '{documento.nombre_documento}' eliminado correctamente")
        return JsonResponse({'success': True})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def limpiar_documentos(request):
    """Elimina todos los documentos (¡PELIGROSO!)"""
    if request.method != 'POST':
        return JsonResponse({'error': 'Método no permitido'}, status=405)
        
    try:
        # Obtener todos los nombres de archivos
        documentos = Documento.objects.all()
        nombres_archivos = [doc.nombre_unico for doc in documentos]
        
        # Eliminar del storage
        if nombres_archivos:
            try:
                # Eliminar en lotes de 1000 (límite de Supabase)
                for i in range(0, len(nombres_archivos), 1000):
                    lote = nombres_archivos[i:i+1000]
                    supabase_public.storage.from_("documents").remove(lote)
            except Exception as e:
                messages.warning(request, f"Error al limpiar storage: {str(e)}")
        
        # Limpiar tabla vectorial
        from django.db import connection
        with connection.cursor() as cursor:
            cursor.execute("DELETE FROM documents")
            
        # Eliminar todos los documentos
        count = documentos.count()
        documentos.delete()
        
        messages.success(request, f"Se han eliminado {count} documentos")
        return JsonResponse({'success': True, 'count': count})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def listar_archivos_storage(request):
    """Lista todos los archivos en el bucket de Supabase para gestión manual"""
    try:
        # Obtener archivos del storage
        response = supabase_public.storage.from_("documents").list()
        archivos_storage = response
        
        # Obtener nombres de archivos en la base de datos
        archivos_db = set(Documento.objects.values_list('nombre_unico', flat=True))
        
        # Marcar archivos huérfanos (que están en storage pero no en DB)
        for archivo in archivos_storage:
            archivo['huerfano'] = archivo['name'] not in archivos_db
        
        # Ordenar: primero huérfanos, luego por fecha
        archivos_storage.sort(key=lambda x: (not x['huerfano'], x['created_at']), reverse=True)
        
        # Paginación
        paginator = Paginator(archivos_storage, 50)  # 50 archivos por página
        page_number = request.GET.get('page', 1)
        archivos_pagina = paginator.get_page(page_number)
        
        # Obtener URL base de Supabase
        from django.conf import settings
        supabase_url = settings.SUPABASE_URL
        
        return render(request, 'administration/documents/storage_files.html', {
            'archivos': archivos_pagina,
            'total_archivos': len(archivos_storage),
            'total_huerfanos': sum(1 for a in archivos_storage if a.get('huerfano', False)),
            'supabase_url': supabase_url
        })
    except Exception as e:
        messages.error(request, f"Error al listar archivos del storage: {str(e)}")
        return redirect('admin_documentos')

@login_required
@rol_requerido(RolUsuario.SUPERADMIN)
def eliminar_archivo_storage(request, filename):
    """Elimina un archivo específico del storage de Supabase"""
    if request.method != 'POST':
        return JsonResponse({'error': 'Método no permitido'}, status=405)
        
    try:
        # Eliminar archivo del storage
        supabase_public.storage.from_("documents").remove([filename])
        messages.success(request, f"Archivo '{filename}' eliminado correctamente del storage")
        return JsonResponse({'success': True})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)