from django.contrib import admin
from django.urls import include, path
from webapp import views
from django.contrib.auth.views import LogoutView
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.home, name='home'),
    path('accounts/', include('django.contrib.auth.urls')),
    path('register/', views.register, name='register'),
    path('logout/', LogoutView.as_view(next_page='home'), name='logout'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('upload-pdf/', views.upload_pdf, name='upload_pdf'),
    path('upload-pdf-private/', views.upload_pdf_private, name='upload_pdf_private'),
    path('upload-pdf-private/', views.upload_pdf_private, name='upload_pdf_private'),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)


