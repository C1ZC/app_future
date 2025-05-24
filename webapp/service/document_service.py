import os
import uuid
import mimetypes
from io import BytesIO
import PyPDF2
from webapp.models import Documento, ConfigTenant, DocumentoStatus
from webapp.service.supabase_client import supabase_public
from django.utils.text import slugify
from docx import Document as DocxDocument
import openpyxl

ALLOWED_EXTENSIONS = {'pdf', 'jpg', 'jpeg',
                      'png', 'gif', 'txt', 'docx', 'xlsx'}
SUPABASE_BUCKET = "documents"

class DocumentoService:
    @staticmethod
    def validar_extension(filename):
        return '.' in filename and \
               filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
    

    @staticmethod
    def validar_licencia(empresa, hojas=1):
        # Si no hay empresa (superadmin), permitimos la operación
        if not empresa:
            return True
            
        try:
            config = ConfigTenant.objects.get(empresa=empresa)
            return config.licencia_disponible(hojas)
        except ConfigTenant.DoesNotExist:
            # Si no existe config, creamos una por defecto
            ConfigTenant.objects.create(empresa=empresa)
            return True
    
    @staticmethod
    def actualizar_licencia(empresa, hojas_usadas):
        # Si no hay empresa, no actualizamos licencia
        if not empresa:
            return
            
        config, created = ConfigTenant.objects.get_or_create(empresa=empresa)
        config.hojas_leidas += hojas_usadas
        config.save()
    
    @staticmethod
    def generar_nombre_unico(filename):
        base_name = os.path.basename(filename)
        nombre_slug = slugify(os.path.splitext(base_name)[0])
        extension = os.path.splitext(base_name)[1].lower()
        nombre_unico = f"{uuid.uuid4().hex}_{nombre_slug}{extension}"
        return nombre_unico
    
    @staticmethod
    def procesar_archivo(file, filename, usuario):
        """
        Procesa un archivo, lo convierte si es necesario y lo sube a Supabase
        """
        # Validación básica
        if not file or not filename:
            return False, "Archivo no proporcionado o nombre vacío"
        
        if not DocumentoService.validar_extension(filename):
            return False, "Extensión no permitida"
        
        # Manejar el caso especial para usuarios sin perfil (superadmins)
        empresa = None
        servicio = None
        
        # Verificar si el usuario tiene perfil
        try:
            if hasattr(usuario, 'perfil'):
                perfil = usuario.perfil
                empresa = perfil.empresa
                servicio = perfil.servicio
                
                # Validar licencia solo para usuarios con empresa
                if empresa and not DocumentoService.validar_licencia(empresa):
                    return False, "Límite de licencia excedido"
        except:
            # Si es superuser pero no tiene perfil, continuamos sin empresa/servicio
            if not usuario.is_superuser:
                return False, "Usuario no tiene perfil configurado"
        
        try:
            # Normalizar nombre
            nombre_unico = DocumentoService.generar_nombre_unico(filename)
            
            # Leer archivo y obtener metadatos
            file.seek(0)
            file_bytes = file.read()
            file_size = len(file_bytes) / 1024.0  # KB
            tipo_archivo = mimetypes.guess_type(filename)[0] or "application/octet-stream"
            
            # Contar páginas/hojas
            cantidad_hojas = 1
            ext = filename.lower().rsplit('.', 1)[-1]
            if ext == 'pdf':
                try:
                    with BytesIO(file_bytes) as pdf_bytes:
                        pdf_reader = PyPDF2.PdfReader(pdf_bytes)
                        cantidad_hojas = len(pdf_reader.pages)
                except Exception as e:
                    print(f"Error contando páginas del PDF: {str(e)}")
            elif ext == 'txt':
                try:
                    text = file_bytes.decode('utf-8', errors='ignore')
                    lineas = text.splitlines()
                    # 50 líneas por hoja (ajustable)
                    cantidad_hojas = max(1, len(lineas) // 50)
                except Exception as e:
                    print(f"Error contando hojas en TXT: {str(e)}")
            elif ext == 'docx':
                try:
                    with BytesIO(file_bytes) as docx_bytes:
                        doc = DocxDocument(docx_bytes)
                        # Cuenta saltos de página (estimación)
                        page_breaks = sum(
                            1 for p in doc.paragraphs if 'pageBreak' in p._element.xml)
                        cantidad_hojas = max(1, page_breaks + 1)
                except Exception as e:
                    print(f"Error contando hojas en DOCX: {str(e)}")
            elif ext == 'xlsx':
                try:
                    with BytesIO(file_bytes) as xlsx_bytes:
                        wb = openpyxl.load_workbook(xlsx_bytes, read_only=True)
                        cantidad_hojas = len(wb.sheetnames)
                except Exception as e:
                    print(f"Error contando hojas en XLSX: {str(e)}")
            # Para imágenes y otros, cantidad_hojas queda en 1

            # Subir archivo a Supabase
            try:
                res = supabase_public.storage.from_(SUPABASE_BUCKET).upload(
                    nombre_unico, file_bytes, 
                    file_options={"content-type": tipo_archivo, "upsert": "true"}
                )
                
                if not hasattr(res, "path") or res.path is None:
                    return False, "Error al subir archivo a Supabase"
                
                # Obtener URL pública
                url_documento = supabase_public.storage.from_(SUPABASE_BUCKET).get_public_url(nombre_unico)
                
                # Crear registro en base de datos
                documento = Documento.objects.create(
                    nombre_documento=filename,
                    nombre_unico=nombre_unico,
                    ruta_documento=url_documento,
                    tipo_archivo=tipo_archivo,
                    file_size=file_size,
                    cantidad_hojas=cantidad_hojas,
                    usuario=usuario,
                    empresa=empresa,  # Puede ser None para superadmins sin perfil
                    servicio=servicio  # Puede ser None para superadmins sin perfil
                )
                
                # Actualizar licencia solo si hay empresa
                if empresa:
                    DocumentoService.actualizar_licencia(empresa, cantidad_hojas)
                

                return True, documento
            
            except Exception as e:
                return False, f"Error en el proceso: {str(e)}"
                
        except Exception as e:
            return False, f"Error general: {str(e)}"
