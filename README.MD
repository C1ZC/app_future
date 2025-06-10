# Plataforma de Procesamiento Inteligente de Documentos con IA

Este proyecto es una plataforma web desarrollada en Django y Python, diseñada para la **gestión, procesamiento y extracción inteligente de datos de documentos** (tributarios, legales, comerciales, etc.) usando técnicas de IA y flujos automatizados con n8n. Está adaptada a la realidad documental chilena, permitiendo a empresas y usuarios automatizar la carga, clasificación y extracción de información estructurada desde archivos PDF, imágenes y otros formatos.

---

## Características principales

- **Gestión de empresas, servicios y usuarios** con roles y permisos.
- **Clasificación jerárquica** de documentos por grupos y módulos (más de 100 tipos de documentos chilenos predefinidos).
- **Carga y almacenamiento seguro** de archivos (integración con Supabase).
- **Procesamiento asíncrono** de documentos vía API y webhook (integración con n8n).
- **Extracción de datos estructurados** usando IA (OpenAI, Ollama, LangChain, etc.).
- **Editor visual y búsqueda inteligente** de tipos de documentos.
- **Historial de consumo y control de licencias** por empresa.
- **Panel de administración avanzado** para gestión de esquemas JSON y plantillas de extracción.
- **Soporte para personalización de esquemas de extracción** por documento.
- **Automatización de flujos** con n8n para scraping, OCR, IA y almacenamiento vectorial.

---

## Estructura del Proyecto

```
.
├── manage.py                            # Script principal para gestionar el proyecto Django
├── requirements.txt                     # Dependencias y librerías necesarias para el proyecto
├── README.MD                            # Documentación principal del proyecto
├── .env                                 # Variables de entorno (API keys, conexiones DB, etc.)
├── .gitignore                           # Archivos ignorados por git (entorno virtual, caché, etc.)
├── BotAI_n8n.json                       # Flujo n8n para procesamiento asíncrono con IA
├── script_datos de grupos_modulos.sql   # Script SQL con grupos/módulos y esquemas JSON predefinidos
├── script_eliminar_vector_supabase.sql  # Script SQL para limpiar vectores en Supabase
├── script_vector_supabase.sql           # Script SQL para crear vectores en Supabase
├── web_project/                         # Directorio principal del proyecto Django
│   ├── __init__.py                      # Indica que el directorio es un paquete Python
│   ├── asgi.py                          # Configuración ASGI para despliegue
│   ├── settings.py                      # Configuración principal de Django (DB, apps, etc.)
│   ├── urls.py                          # Rutas principales del proyecto
│   ├── wsgi.py                          # Configuración WSGI para despliegue
└── webapp/                              # Aplicación principal del proyecto
    ├── __init__.py                      # Indica que el directorio es un paquete Python
    ├── admin.py                         # Configuración del panel de administración de Django
    ├── apps.py                          # Configuración de la aplicación Django
    ├── models.py                        # Modelos de datos (Empresas, Documentos, etc.)
    ├── tests.py                         # Tests unitarios y de integración
    ├── views.py                         # Archivo de vistas genéricas (redirecciones a módulos)
    ├── forms/                           # Formularios del proyecto
    │   ├── __init__.py                  # Inicializador del paquete
    │   ├── administration_forms.py      # Formularios para administración (empresas, usuarios)
    │   └── document_forms.py            # Formularios para carga y gestión de documentos
    ├── migrations/                      # Migraciones de base de datos
    │   ├── __init__.py                  # Inicializador del paquete
    │   ├── 0001_initial.py              # Migración inicial de modelos
    │   └── ...                          # Migraciones adicionales
    ├── service/                         # Servicios y lógica de negocio
    │   ├── __init__.py                  # Inicializador del paquete
    │   ├── document_service.py          # Lógica de procesamiento de documentos
    │   ├── supabase_client.py           # Cliente para Supabase (almacenamiento)
    │   ├── company_crud.py              # CRUD de empresas
    │   ├── service_crud.py              # CRUD de servicios
    │   ├── users_crud.py                # CRUD de usuarios
    │   ├── auth.py                      # Servicio de autenticación y registro
    │   └── roles.py                     # Sistema de control de acceso basado en roles
    ├── static/                          # Archivos estáticos
    │   ├── css/                         # Hojas de estilo CSS
    │   │   ├── style.css                # Estilos generales de la aplicación
    │   │   ├── dark-theme.css           # Estilos para el tema oscuro
    │   │   ├── components/              # Estilos específicos de componentes
    │   │   │   ├── sidenav.css          # Estilos para la barra lateral
    │   │   │   └── document-detail.css  # Estilos para la vista detalle de documentos
    │   │   └── bootstrap.min.css        # Framework CSS Bootstrap
    │   └── js/                          # Scripts JavaScript
    │       ├── json-editor.js           # Editor de JSON para esquemas
    │       ├── bootstrap.bundle.min.js  # JavaScript de Bootstrap
    │       └── jquery.min.js            # Biblioteca jQuery
    ├── templates/                       # Plantillas HTML
    │   ├── base.html                    # Plantilla base con estructura común
    │   ├── components/                  # Componentes reutilizables
    │   │   └── sidebar.html             # Barra lateral de navegación
    │   ├── pages/                       # Páginas principales
    │   │   ├── home.html                # Página de inicio
    │   │   ├── administration.html      # Panel de administración
    │   │   ├── administration_user.html # Panel de administración de usuarios
    │   │   └── perfiles.html            # Página de perfil de usuario
    │   ├── administration/              # Plantillas de administración
    │   │   ├── empresas/                # Plantillas de gestión de empresas
    │   │   │   ├── lista_empresas.html  # Lista de empresas
    │   │   │   └── modal_*.html         # Modales para operaciones CRUD
    │   │   ├── service/                 # Plantillas de gestión de servicios
    │   │   │   ├── list_service.html    # Lista de servicios
    │   │   │   └── modal_*.html         # Modales para operaciones CRUD
    │   │   ├── users/                   # Plantillas de gestión de usuarios
    │   │   │   ├── list_users.html      # Lista de usuarios
    │   │   │   └── modal_*.html         # Modales para operaciones CRUD
    │   │   ├── licences/                # Plantillas de gestión de licencias
    │   │   │   ├── licences_list.html   # Lista de licencias
    │   │   │   └── modal_*.html         # Modales para operaciones CRUD
    │   │   └── documents/               # Plantillas de gestión de documentos
    │   │       ├── admin_documentos.html # Panel admin de documentos
    │   │       ├── grupos_modulos.html   # Gestión de grupos y módulos
    │   │       ├── storage_files.html    # Gestión de archivos en storage
    │   │       └── editar_esquema_modulo.html # Edición de esquemas JSON
    │   ├── documents/                   # Plantillas de documentos (frontend)
    │   │   ├── upload_documents.html    # Subida de documentos
    │   │   ├── lista_documentos.html    # Lista de documentos
    │   │   └── documento_detalle.html   # Detalle de documento
    │   └── registration/                # Plantillas de autenticación
    │       ├── login.html               # Inicio de sesión
    │       └── register.html            # Registro de usuario
    ├── templatetags/                    # Tags y filtros personalizados
    │   ├── __init__.py                  # Inicializador del paquete
    │   └── form_filters.py              # Filtros personalizados para plantillas
    └── views/                           # Vistas organizadas por módulos
        ├── __init__.py                  # Inicializador del paquete
        ├── home_views.py                # Vistas de la página principal
        ├── auth_views.py                # Vistas de autenticación
        ├── profile_views.py             # Vistas de perfil de usuario
        ├── administration_views.py      # Vistas del panel de administración
        ├── administration_user_views.py # Vistas de administración de usuarios
        ├── document_views.py            # Vistas para documentos y APIs
        ├── admin_documents_views.py     # Vistas de administración de documentos
        ├── api_views.py                 # Vistas para endpoints de API
        ├── licences_views.py            # Vistas de gestión de licencias
        ├── dashboard_cosumo_view.py     # Vistas de dashboard de consumo
        └── context_processors.py        # Procesadores de contexto para plantillas
```

---

## Ejemplo de archivo `.env`

Configura tus variables de entorno en un archivo `.env` en la raíz del proyecto.  
**No compartas este archivo públicamente.**

```env

# Supabase
SUPABASE_URL=https://tuproyecto.supabase.co
SUPABASE_KEY=clave_publica_supabase
SUPABASE_SERVICE_ROLE=clave_service_role_supabase
SUPABASE_JWT=jwt_supabase

# PostgreSQL
DB_NAME=postgres
DB_USER=postgres
DB_PASSWORD=tu_password
DB_HOST=host_de_tu_db
DB_PORT=5432

# n8n (automatización)
N8N_API_KEY=tu_api_key_n8n

# Django
DJANGO_SECRET_KEY=tu_clave_secreta_django
```

**Descripción de variables:**
- `OPENAI_API_KEY`, `OPENAI_ENDPOINT`: Credenciales para IA (GPT, etc).
- `SUPABASE_URL`, `SUPABASE_KEY`, `SUPABASE_SERVICE_ROLE`, `SUPABASE_JWT`: Acceso a Supabase (almacenamiento y vectores).
- `DB_*`: Configuración de la base de datos PostgreSQL.
- `N8N_API_KEY`: Clave para integración segura con n8n.
- `DJANGO_SECRET_KEY`: Clave secreta de Django para seguridad.

---

## Instalación y configuración

### 1. Requisitos previos

- Python 3.10+
- PostgreSQL (recomendado para producción)
- Node.js (para n8n)
- Supabase (para almacenamiento de archivos y vectores)
- Entorno virtual recomendado

### 2. Clonar el repositorio

```sh
git clone https://github.com/C1ZC/app_future.git
cd app_future
```

### 3. Crear y activar entorno virtual

```sh
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
```

### 4. Instalar dependencias

```sh
pip install -r requirements.txt
```

### 5. Configurar variables de entorno

Copia `.env.example` a `.env` y completa los valores necesarios (ver ejemplo arriba).

### 6. Migrar la base de datos

```sh
python manage.py migrate
```

### 7. Crear superusuario

```sh
python manage.py createsuperuser
```

### 8. Cargar datos de grupos y módulos (opcional pero recomendado)

```sh
psql -U tu_usuario -d tu_db -f "script_datos de grupos_modulos.sql"
```

### 9. Ejecutar el servidor de desarrollo

```sh
python manage.py runserver
```

---

## Integración con n8n y procesamiento IA

- El archivo [`BotAI_n8n.json`](BotAI_n8n.json) contiene el flujo de procesamiento automatizado:
  - Consulta documentos pendientes vía API.
  - Descarga y procesa archivos (OCR, IA, extracción de datos).
  - Actualiza el estado y los datos extraídos en Django vía webhook.
  - Almacena vectores en Supabase para búsquedas semánticas.

- Puedes importar este flujo en tu instancia de n8n y configurar los nodos según tus credenciales.

---

## Estructura de la aplicación

### Modelos principales

- **Empresa, Servicio, PerfilUsuario:** Organización y permisos.
- **Grupo, Modulo:** Clasificación jerárquica de documentos.
- **Documento:** Archivo subido, metadatos, estado, datos extraídos, esquema JSON personalizado.
- **PeriodoLicencia, HistorialConsumo:** Control de licencias y consumo.

### Vistas y endpoints

- **Carga y detalle de documentos:** Formularios inteligentes, búsqueda y autocompletado.
- **API REST:** Para consulta de módulos, búsqueda, obtención de esquemas JSON, endpoints para n8n.
- **Panel de administración:** Gestión avanzada de empresas, usuarios, grupos, módulos y esquemas.

### Plantillas y frontend

- **Bootstrap 5** y componentes modernos.
- **Editor visual de esquemas JSON** (con validación y formateo).
- **Buscador inteligente** de tipos de documentos.
- **Historial y favoritos** para carga rápida.

---

## Personalización y extensibilidad

- Puedes agregar nuevos tipos de documentos editando el script SQL o desde el panel de administración.
- Los esquemas de extracción (JSON) pueden ser personalizados por módulo o por documento.
- El sistema soporta integración con cualquier motor de IA compatible con API REST (OpenAI, Ollama, etc.).
- Fácil de extender para scraping de portales externos (SII, bancos, etc.) usando microservicios (ej: FastAPI).

---

## Seguridad

- Autenticación y permisos por usuario, empresa y servicio.
- Validación de archivos y control de extensiones permitidas.
- API protegida por API Key para integración con n8n y servicios externos.

---

## Casos de uso recomendados

- Automatización de ingreso y extracción de datos de **facturas electrónicas, boletas, contratos, certificados, etc.**
- Integración con sistemas contables y ERPs.
- Gestión documental para estudios contables, PYMEs, inmobiliarias, clínicas, etc.
- Búsqueda semántica y análisis de grandes volúmenes de documentos.

---

## Créditos y licencias

Desarrollado por Camilo Zavala.  
Basado en Django, n8n, Supabase y tecnologías de IA.