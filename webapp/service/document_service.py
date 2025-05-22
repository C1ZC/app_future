import os
import uuid
import mimetypes
from io import BytesIO
from PIL import Image
import PyPDF2
from webapp.models import Documento, ConfigTenant, DocumentoStatus
from webapp.service.supabase_client import supabase_public
from django.utils.text import slugify

ALLOWED_EXTENSIONS = {'pdf', 'jpg', 'jpeg', 'png', 'gif', 'txt'}
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
            if filename.endswith('.pdf'):
                try:
                    with BytesIO(file_bytes) as pdf_bytes:
                        pdf_reader = PyPDF2.PdfReader(pdf_bytes)
                        cantidad_hojas = len(pdf_reader.pages)
                except Exception as e:
                    print(f"Error contando páginas del PDF: {str(e)}")
            
            # Convertir imagen a PDF si es necesario
            if tipo_archivo.startswith('image/') and not filename.endswith('.pdf'):
                try:
                    img_bytes = BytesIO(file_bytes)
                    img = Image.open(img_bytes)
                    
                    # Guardar como PDF
                    pdf_bytes = BytesIO()
                    img.save(pdf_bytes, 'PDF')
                    pdf_bytes.seek(0)
                    
                    # Actualizar variables
                    file_bytes = pdf_bytes.getvalue()
                    nombre_base = os.path.splitext(nombre_unico)[0]
                    nombre_unico = f"{nombre_base}.pdf"
                    tipo_archivo = "application/pdf"
                except Exception as e:
                    return False, f"Error convirtiendo imagen a PDF: {str(e)}"
            
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
                
                # Notificar a n8n (opcional)
                DocumentoService.notificar_documento_nuevo(documento)
                
                return True, documento
            
            except Exception as e:
                return False, f"Error en el proceso: {str(e)}"
                
        except Exception as e:
            return False, f"Error general: {str(e)}"

    @staticmethod
    def notificar_documento_nuevo(documento):
        """
        Envía un webhook a n8n para iniciar el procesamiento
        """
        import requests
        import json
        from django.conf import settings
        
        # URL del webhook en n8n (configúralo en settings.py o .env)
        # Por ejemplo: N8N_WEBHOOK_URL = "https://n8n.tudominio.com/webhook/documento-nuevo"
        webhook_url = getattr(settings, 'N8N_WEBHOOK_URL', None)
        
        if not webhook_url:
            print("No se ha configurado N8N_WEBHOOK_URL en settings.py")
            return False
            
        try:
            # Preparar los datos a enviar
            payload = {
                "documento_id": str(documento.id),
                "nombre_documento": documento.nombre_documento,
                "nombre_unico": documento.nombre_unico,
                "ruta_documento": documento.ruta_documento,
                "tipo_archivo": documento.tipo_archivo,
                "cantidad_hojas": documento.cantidad_hojas,
                "created_at": documento.created_at.isoformat(),
                "empresa_id": str(documento.empresa.id) if documento.empresa else None,
                "servicio_id": str(documento.servicio.id) if documento.servicio else None,
                "usuario_id": documento.usuario.id,
                "status": documento.status
            }
            
            # Enviar la solicitud POST a n8n
            headers = {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
            
            response = requests.post(
                webhook_url, 
                data=json.dumps(payload),
                headers=headers,
                timeout=10  # Timeout de 10 segundos
            )
            
            # Verificar la respuesta
            if response.status_code >= 200 and response.status_code < 300:
                print(f"Notificación enviada correctamente a n8n. Respuesta: {response.text}")
                return True
            else:
                print(f"Error al enviar notificación: {response.status_code} - {response.text}")
                return False
                
        except Exception as e:
            print(f"Error al notificar a n8n: {str(e)}")
            return False