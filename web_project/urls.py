from django.contrib import admin
from django.urls import include, path
from django.contrib.auth.views import LogoutView
from django.conf import settings
from django.conf.urls.static import static
from webapp.views import administration_views
from webapp.views.admin_documents_views import admin_documentos, eliminar_documento, limpiar_documentos, listar_archivos_storage, eliminar_archivo_storage
from webapp.views.administration_views import (
    admin_grupos_modulos, administracion, crear_grupo, crear_modulo,
    toggle_grupo_activo, eliminar_grupo, eliminar_modulo
)
from webapp.views.api_views import buscar_modulos_grupos, get_modulo_esquema_json
from webapp.views.auth_views import register
from webapp.views.dashboard_cosumo_view import dashboard_consumo_empresa
from webapp.views.home_views import home
from webapp.service.company_crud import empresa_list, empresa_create, empresa_update, empresa_delete
from webapp.service.service_crud import servicio_list, servicio_create, servicio_update, servicio_delete
from webapp.service.users_crud import usuario_list, usuario_create, usuario_update, usuario_delete
from webapp.views.licences_views import crear_licencia, editar_licencia, lista_licencias, eliminar_licencia, detalle_licencia
from webapp.views.profile_views import perfil_view
from webapp.views.administration_user_views import administracion_user
from webapp.views.document_views import documento_update_fragmentos, documento_upload, documento_lista, documento_detalle, documento_webhook, documento_pendientes, get_modulos_por_grupo

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', home, name='home'),
    path('accounts/', include('django.contrib.auth.urls')),
    path('register/', register, name='register'),
    path('logout/', LogoutView.as_view(next_page='home'), name='logout'),
    path('empresas/', empresa_list, name='lista_empresas'),
    path('empresas/nueva/', empresa_create, name='empresa_create'),
    path('empresas/<int:pk>/editar/', empresa_update, name='empresa_update'),
    path('empresas/<int:pk>/eliminar/', empresa_delete, name='empresa_delete'),
    path('servicios/', servicio_list, name='lista_servicios'),
    path('servicios/nuevo/', servicio_create, name='servicio_create'),
    path('servicios/<int:pk>/editar/', servicio_update, name='servicio_update'),
    path('servicios/<int:pk>/eliminar/', servicio_delete, name='servicio_delete'),
    path('usuarios/', usuario_list, name='lista_usuarios'),
    path('usuarios/nuevo/', usuario_create, name='usuario_create'),
    path('usuarios/<int:pk>/editar/', usuario_update, name='usuario_update'),
    path('usuarios/<int:pk>/eliminar/', usuario_delete, name='usuario_delete'),
    path('perfil/', perfil_view, name='perfil'),
    path('administracion_user/', administracion_user, name='administracion_user'),
    path('administration/', administracion, name='administration'),
    # URLs para documentos
    path('documentos/', documento_lista, name='documento_lista'),
    path('documentos/upload/', documento_upload, name='documento_upload'),
    path('documentos/<uuid:doc_id>/', documento_detalle, name='documento_detalle'),
    path('api/documentos/webhook/', documento_webhook, name='documento_webhook'),
    path('api/documentos/update_fragmentos/', documento_update_fragmentos, name='documento_update_fragmentos'),
    path('api/documentos/pendientes/', documento_pendientes, name='documento_pendientes'),
    path('administration/documentos/', admin_documentos, name='admin_documentos'),
    path('administration/documentos/<uuid:doc_id>/eliminar/',
         eliminar_documento, name='eliminar_documento'),
    path('administration/documentos/limpiar/',
         limpiar_documentos, name='limpiar_documentos'),
    path('administration/documentos/storage/', listar_archivos_storage,
         name='listar_archivos_storage'),
    path('administration/documentos/storage/<str:filename>/eliminar/',
         eliminar_archivo_storage, name='eliminar_archivo_storage'),
     # En la sección de administración
    path('administration/documentos/modulos/<int:modulo_id>/esquema/', 
         administration_views.editar_esquema_modulo, 
     name='editar_esquema_modulo'),
     # Nueva URL para el Dashboard de Consumo
    path('dashboard/consumo/', dashboard_consumo_empresa, name='dashboard_consumo_empresa'),
    # URLs de gestión de licencias
    path('administration/licencias/', lista_licencias, name='lista_licencias'),
    path('administration/licencias/crear/', crear_licencia, name='crear_licencia'),
    path('administration/licencias/<int:pk>/editar/', editar_licencia, name='editar_licencia'),
    path('administration/licencias/<int:pk>/eliminar/', eliminar_licencia, name='eliminar_licencia'),
    path('administration/licencias/<int:pk>/detalle/', detalle_licencia, name='detalle_licencia'),
    path('api/modulos-por-grupo/', get_modulos_por_grupo,
         name='get_modulos_por_grupo'),
    path('administration/documentos/grupos-modulos/',
         admin_grupos_modulos, name='admin_grupos_modulos'),
    path('administration/documentos/grupos/crear/',
         crear_grupo, name='crear_grupo'),
    path('administration/documentos/modulos/crear/',
         crear_modulo, name='crear_modulo'),
    path('administration/documentos/grupos/<int:grupo_id>/toggle-activo/',
         toggle_grupo_activo, name='toggle_grupo_activo'),
    path('administration/documentos/grupos/<int:grupo_id>/eliminar/',
         eliminar_grupo, name='eliminar_grupo'),
    path('administration/documentos/modulos/<int:modulo_id>/eliminar/',
         eliminar_modulo, name='eliminar_modulo'),
    path('api/buscar-modulos-grupos/', buscar_modulos_grupos, name='buscar_modulos_grupos'),
    path('api/modulo/<int:modulo_id>/esquema/', get_modulo_esquema_json, name='get_modulo_esquema_json'),


] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)


