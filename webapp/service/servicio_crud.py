from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from webapp.models import Servicio
from webapp.forms.administration_forms import ServicioForm
from webapp.service.roles import rol_requerido, RolUsuario

@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA)
def servicio_list(request):
    servicios = Servicio.objects.all()
    form = ServicioForm()
    edit_forms = {servicio.pk: ServicioForm(instance=servicio) for servicio in servicios}
    return render(request, 'administration/servicio/lista_servicios.html', {
        'servicios': servicios,
        'form': form,
        'edit_forms': edit_forms,
    })

@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA)
def servicio_create(request):
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
            return render(request, 'administration/servicio/lista_servicios.html', {
                'servicios': servicios,
                'form': form,  # este form tiene los errores
                'edit_forms': edit_forms,
                'abrir_modal': True,  # bandera para abrir el modal
            })
    else:
        return redirect('lista_servicios')

@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA)
def servicio_update(request, pk):
    servicio = get_object_or_404(Servicio, pk=pk)
    if request.method == 'POST':
        form = ServicioForm(request.POST, instance=servicio)
        if form.is_valid():
            form.save()
            messages.success(request, "Servicio actualizado correctamente.")
            return redirect('lista_servicios')
    else:
        form = ServicioForm(instance=servicio)
    return render(request, 'administration/servicio/lista_servicios.html', {'form': form})

@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA)
def servicio_delete(request, pk):
    servicio = get_object_or_404(Servicio, pk=pk)
    if request.method == 'POST':
        servicio.delete()
        messages.success(request, "Servicio eliminado correctamente.")
        return redirect('lista_servicios')
    return render(request, 'administration/servicio/lista_servicios.html', {'servicio': servicio})