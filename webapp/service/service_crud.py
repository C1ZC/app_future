# ===============================================================
# GESTIÓN DE SERVICIOS (CRUD)
# ===============================================================
# Este módulo contiene todas las funciones necesarias para la gestión
# de servicios en el sistema, incluyendo listado, creación, 
# actualización y eliminación.
# ===============================================================

from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from webapp.models import Servicio
from webapp.forms.administration_forms import ServicioForm
from webapp.service.roles import rol_requerido, RolUsuario

# ===============================================================
# LISTADO DE SERVICIOS
# ===============================================================
@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA)
def servicio_list(request):
    """
    Muestra un listado de todos los servicios disponibles.
    
    Prepara un formulario para crear nuevos servicios y formularios
    de edición para cada servicio existente, que serán utilizados
    en modales dentro de la interfaz.
    """
    servicios = Servicio.objects.all()
    form = ServicioForm()
    # Crea un formulario de edición para cada servicio existente
    edit_forms = {servicio.pk: ServicioForm(instance=servicio) for servicio in servicios}
    return render(request, 'administration/service/list_service.html', {
        'servicios': servicios,
        'form': form,
        'edit_forms': edit_forms,
    })

# ===============================================================
# CREACIÓN DE SERVICIOS
# ===============================================================
@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA)
def servicio_create(request):
    """
    Maneja la creación de un nuevo servicio.
    
    Si el formulario es válido, crea el servicio y redirige al listado.
    Si hay errores, vuelve al listado mostrando el modal con los errores.
    """
    if request.method == 'POST':
        form = ServicioForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Servicio creado correctamente.")
            return redirect('lista_servicios')
        else:
            # Si hay errores, vuelve a la lista y muestra el modal abierto
            servicios = Servicio.objects.all()
            edit_forms = {servicio.pk: ServicioForm(instance=servicio) for servicio in servicios}
            return render(request, 'administration/service/list_service.html', {
                'servicios': servicios,
                'form': form,  # este form tiene los errores
                'edit_forms': edit_forms,
                'abrir_modal': True,  # bandera para abrir el modal
            })
    else:
        return redirect('lista_servicios')

# ===============================================================
# ACTUALIZACIÓN DE SERVICIOS
# ===============================================================
@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA)
def servicio_update(request, pk):
    """
    Actualiza los datos de un servicio existente.
    
    Recibe el ID del servicio a modificar, valida el formulario
    y guarda los cambios si son válidos.
    """
    servicio = get_object_or_404(Servicio, pk=pk)
    if request.method == 'POST':
        form = ServicioForm(request.POST, instance=servicio)
        if form.is_valid():
            form.save()
            messages.success(request, "Servicio actualizado correctamente.")
            return redirect('lista_servicios')
    else:
        form = ServicioForm(instance=servicio)
    return render(request, 'administration/service/list_service.html', {'form': form})

# ===============================================================
# ELIMINACIÓN DE SERVICIOS
# ===============================================================
@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA)
def servicio_delete(request, pk):
    """
    Elimina un servicio del sistema.
    
    Recibe el ID del servicio a eliminar y lo elimina si la solicitud
    es de tipo POST. Incluye una confirmación previa para evitar
    eliminaciones accidentales.
    """
    servicio = get_object_or_404(Servicio, pk=pk)
    if request.method == 'POST':
        servicio.delete()
        messages.success(request, "Servicio eliminado correctamente.")
        return redirect('lista_servicios')
    return render(request, 'administration/servicio/lista_servicios.html', {'servicio': servicio})