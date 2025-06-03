# ===============================================================
# SERVICIO DE GESTIÓN DE DOCUMENTOS
# ===============================================================
# Este módulo proporciona servicios para el procesamiento, validación y
# almacenamiento de documentos, gestionando también el control de licencias.
# ===============================================================

# Importaciones estándar
import os
import uuid
import mimetypes
from io import BytesIO

# Importaciones de procesamiento de documentos
import PyPDF2
from docx import Document as DocxDocument
import openpyxl

# Importaciones de Django
from django.utils.text import slugify
from django.utils import timezone
from django.db.models import Q

# Importaciones locales
from webapp.models import (
    Documento, DocumentoStatus, PeriodoLicencia,
    HistorialConsumo, Empresa, Servicio
)
from webapp.service.supabase_client import supabase_public

# Constantes para validación y almacenamiento
ALLOWED_EXTENSIONS = {'pdf', 'jpg', 'jpeg',
                      'png', 'gif', 'txt', 'docx', 'xlsx'}
SUPABASE_BUCKET = "documents"

class DocumentoService:
    """
    Servicio para gestionar el procesamiento de documentos.
    Incluye validación de tipos de archivo, carga a almacenamiento,
    y gestión de licencias y consumo.
    """

    @staticmethod
    def validar_extension(filename):
        """
        Valida si la extensión del archivo está permitida.
        
        Args:
            filename: Nombre del archivo a validar
            
        Returns:
            bool: True si la extensión está permitida, False en caso contrario
        """
        return '.' in filename and \
               filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

    @staticmethod
    def generar_nombre_unico(filename):
        """
        Genera un nombre único para el archivo usando slugify y UUID.
        
        Args:
            filename: Nombre original del archivo
            
        Returns:
            str: Nombre único generado para el archivo
        """
        ext = filename.rsplit('.', 1)[1].lower()
        slug = slugify(filename.rsplit('.', 1)[0])
        return f"{slug}-{uuid.uuid4().hex[:8]}.{ext}"

    @staticmethod
    def get_periodo_licencia_activo(empresa: Empresa):
        """
        Obtiene el periodo de licencia activo para una empresa.
        
        Args:
            empresa: Objeto Empresa para la que se busca la licencia
            
        Returns:
            PeriodoLicencia: El periodo activo o None si no existe
        """
        if not empresa:
            return None
        now_date = timezone.now().date()
        
        # Busca un periodo activo que cubra la fecha actual
        # Prioriza el que tiene fecha_fin más lejana si hay solapamientos
        # y entre esos, el que tiene fecha_inicio más reciente.
        periodo = PeriodoLicencia.objects.filter(
            empresa=empresa,
            activo=True,
            fecha_inicio__lte=now_date,
            fecha_fin__gte=now_date
        ).order_by('-fecha_fin', '-fecha_inicio').first()
        return periodo

    @staticmethod
    def procesar_archivo(file, filename, usuario, grupo=None, modulo=None, servicio_obj: Servicio = None):
        """
        Procesa un archivo subido por el usuario:
        1. Valida la extensión
        2. Verifica las licencias y cuotas
        3. Sube el archivo al almacenamiento
        4. Crea el registro en la base de datos
        5. Registra el consumo de recursos
        
        Args:
            file: Archivo subido por el usuario
            filename: Nombre del archivo
            usuario: Usuario que realiza la subida
            grupo: Grupo al que pertenece el documento (opcional)
            modulo: Módulo específico del documento (opcional)
            servicio_obj: Servicio asociado al documento (opcional)
            
        Returns:
            tuple: (éxito, mensaje, documento)
        """
        # 1. Validación básica del archivo
        if not file or not filename:
            return False, "Archivo no proporcionado o nombre vacío", None

        if not DocumentoService.validar_extension(filename):
            return False, f"Extensión no permitida. Permitidas: {', '.join(ALLOWED_EXTENSIONS)}", None

        # 2. Determinar la empresa del usuario para verificar licencias
        empresa_del_usuario = None
        if hasattr(usuario, 'perfil') and usuario.perfil:
            empresa_del_usuario = usuario.perfil.empresa
        elif not usuario.is_superuser: # Usuario regular sin perfil/empresa
             return False, "Usuario no tiene perfil o empresa asociada para determinar la licencia.", None
        # Si es superadmin y no tiene empresa, se permite la carga sin chequeo de licencia.

        # 3. Verificar licencia activa para la empresa
        periodo_licencia_activo = None
        if empresa_del_usuario:
            periodo_licencia_activo = DocumentoService.get_periodo_licencia_activo(empresa_del_usuario)
            if not periodo_licencia_activo:
                return False, f"La empresa '{empresa_del_usuario.nombre}' no tiene un periodo de licencia activo o válido.", None
        
        try:
            # 4. Preparar los datos del archivo
            nombre_unico = DocumentoService.generar_nombre_unico(filename)
            file.seek(0)
            file_bytes = file.read()
            file_size_kb = len(file_bytes) / 1024.0
            tipo_archivo = mimetypes.guess_type(filename)[0] or "application/octet-stream"
            
            # 5. Determinar cantidad de hojas según tipo de archivo
            cantidad_hojas = 1 # Default
            ext = filename.lower().rsplit('.', 1)[-1]
            if ext == 'pdf':
                try:
                    with BytesIO(file_bytes) as pdf_bytes_io:
                        pdf_reader = PyPDF2.PdfReader(pdf_bytes_io)
                        cantidad_hojas = len(pdf_reader.pages)
                except Exception: # Ser más genérico en la excepción de PyPDF2
                    pass # Mantener 1 hoja si falla el conteo
            elif ext == 'txt':
                try:
                    text_content = file_bytes.decode('utf-8', errors='ignore')
                    lines = text_content.count('\n') + 1
                    cantidad_hojas = max(1, (lines + 49) // 50) # 50 líneas por hoja, redondeo hacia arriba
                except Exception:
                    pass
            elif ext == 'docx':
                try:
                    with BytesIO(file_bytes) as docx_bytes_io:
                        doc = DocxDocument(docx_bytes_io)
                        # Estimación: contar saltos de página explícitos o un número basado en párrafos/longitud
                        page_breaks = sum(1 for p in doc.paragraphs if 'w:br' in p._p.xml and 'type="page"' in p._p.xml)
                        cantidad_hojas = max(1, page_breaks + 1)
                except Exception:
                    pass
            elif ext == 'xlsx':
                try:
                    with BytesIO(file_bytes) as xlsx_bytes_io:
                        wb = openpyxl.load_workbook(xlsx_bytes_io, read_only=True)
                        cantidad_hojas = len(wb.sheetnames) # Una hoja por cada "sheet"
                except Exception:
                    pass

            # 6. Chequeo de Licencia (si aplica)
            if periodo_licencia_activo:
                # Chequeo de Hojas disponibles
                hojas_ok, msg_hojas = periodo_licencia_activo.licencia_hojas_disponible(cantidad_hojas)
                if not hojas_ok:
                    return False, msg_hojas, None
                
                # Chequeo de Storage disponible
                storage_ok, msg_storage = periodo_licencia_activo.licencia_storage_disponible_kb(file_size_kb)
                if not storage_ok:
                    return False, msg_storage, None

            # 7. Subir archivo a Supabase
            res = supabase_public.storage.from_(SUPABASE_BUCKET).upload(
                nombre_unico, file_bytes,
                file_options={"content-type": tipo_archivo, "upsert": "true"}
            )

            # 8. Verificar respuesta de Supabase
            error_message_supabase = None
            if hasattr(res, 'error') and res.error:
                error_message_supabase = f"Error Supabase: {res.error.get('message', str(res.error))}"
            elif not hasattr(res, 'path') or res.path is None:
                 error_message_supabase = "Error desconocido al subir archivo a Supabase."
            
            if error_message_supabase:
                return False, error_message_supabase, None

            # 9. Generar URL pública del documento
            url_documento = supabase_public.storage.from_(SUPABASE_BUCKET).get_public_url(nombre_unico)

            # 10. Crear registro en la base de datos
            documento = Documento.objects.create(
                nombre_documento=filename,
                nombre_unico=nombre_unico,
                ruta_documento=url_documento,
                tipo_archivo=tipo_archivo,
                file_size=file_size_kb,
                cantidad_hojas=cantidad_hojas,
                usuario=usuario,
                empresa=empresa_del_usuario,
                servicio=servicio_obj if servicio_obj else (usuario.perfil.servicio if hasattr(usuario, 'perfil') and usuario.perfil else None),
                status=DocumentoStatus.EN_ESPERA,
                grupo=grupo,
                modulo=modulo
            )

            # 11. Registrar consumo de licencia
            if periodo_licencia_activo:
                HistorialConsumo.objects.create(
                    periodo_licencia=periodo_licencia_activo,
                    documento=documento,
                    usuario=usuario,
                    hojas_consumidas=cantidad_hojas,
                    storage_consumido_kb=file_size_kb
                )
            
            return True, "Documento procesado y subido.", documento
        except Exception as e:
            # Capturar cualquier excepción no prevista
            return False, f"Error general en el procesamiento: {str(e)}", None