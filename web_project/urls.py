from django.contrib import admin
from django.urls import include, path
from django.contrib.auth.views import LogoutView
from django.conf import settings
from django.conf.urls.static import static
from webapp.views.auth_views import register
from webapp.views.home_views import home
from webapp.views.dashboard_views import dashboard
from webapp.views.upload_views import upload_pdf, upload_pdf_private
from webapp.service.empresas_crud import empresa_list, empresa_create, empresa_update, empresa_delete
from webapp.service.servicio_crud import servicio_list, servicio_create, servicio_update, servicio_delete
from webapp.service.usuario_crud import usuario_list, usuario_create, usuario_update, usuario_delete

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', home, name='home'),
    path('accounts/', include('django.contrib.auth.urls')),
    path('register/', register, name='register'),
    path('logout/', LogoutView.as_view(next_page='home'), name='logout'),
    path('dashboard/', dashboard, name='dashboard'),
    path('upload-pdf/', upload_pdf, name='upload_pdf'),
    path('upload-pdf-private/', upload_pdf_private, name='upload_pdf_private'),
    path('empresas/', empresa_list, name='lista_empresas'),
    path('empresas/nueva/', empresa_create, name='empresa_create'),
    path('empresas/<int:pk>/editar/', empresa_update, name='empresa_update'),
    path('empresas/<int:pk>/eliminar/', empresa_delete, name='empresa_delete'),
    path('servicios/', servicio_list, name='lista_servicios'),
    path('servicios/nuevo/', servicio_create, name='servicio_create'),
    path('servicios/<int:pk>/editar/', servicio_update, name='servicio_update'),
    path('servicios/<int:pk>/eliminar/',
         servicio_delete, name='servicio_delete'),
    path('usuarios/', usuario_list, name='lista_usuarios'),
    path('usuarios/nuevo/', usuario_create, name='usuario_create'),
    path('usuarios/<int:pk>/editar/', usuario_update, name='usuario_update'),
    path('usuarios/<int:pk>/eliminar/', usuario_delete, name='usuario_delete'),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)


