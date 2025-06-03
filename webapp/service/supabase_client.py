# ===============================================================
# CLIENTE DE CONEXIÓN A SUPABASE
# ===============================================================
# Este módulo configura los clientes de conexión a Supabase para
# acceder al almacenamiento de archivos y otras funcionalidades
# de la plataforma con diferentes niveles de privilegio.
# ===============================================================

from supabase import create_client
import os

# ===============================================================
# CONFIGURACIÓN Y CREDENCIALES
# ===============================================================
# Obtener credenciales desde variables de entorno
# URL base de la instancia Supabase
SUPABASE_URL = os.getenv("SUPABASE_URL")
# Clave anon/pública (acceso limitado)
SUPABASE_KEY = os.getenv("SUPABASE_KEY")
# Clave privilegiada para operaciones administrativas
SUPABASE_SERVICE_ROLE = os.getenv("SUPABASE_SERVICE_ROLE")

# ===============================================================
# INSTANCIAS DE CLIENTE
# ===============================================================
# Cliente con privilegios públicos (para operaciones normales de usuario)
# - Acceso limitado según políticas de seguridad en Supabase
# - Usado para cargar, ver y acceder a documentos según permisos
supabase_public = create_client(SUPABASE_URL, SUPABASE_KEY)

# Cliente con privilegios elevados (para operaciones administrativas)
# - Acceso completo a los buckets de almacenamiento y tablas
# - Usado para mantenimiento, limpieza y operaciones de sistema
supabase_private = create_client(SUPABASE_URL, SUPABASE_SERVICE_ROLE)