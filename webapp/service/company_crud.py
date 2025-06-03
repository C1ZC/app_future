# ===============================================================
# GESTIÓN DE EMPRESAS (CRUD)
# ===============================================================
# Este módulo contiene todas las funciones necesarias para la gestión
# de empresas en el sistema, incluyendo listado, creación, 
# actualización y eliminación.
# ===============================================================

from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from webapp.models import Empresa
from webapp.forms.administration_forms import EmpresaForm
from webapp.service.roles import rol_requerido, RolUsuario
from django.contrib.auth.decorators import login_required

# ===============================================================
# LISTADO DE EMPRESAS
# ===============================================================
@rol_requerido(RolUsuario.SUPERADMIN)
def empresa_list(request):
    """
    Muestra un listado de todas las empresas.
    
    Prepara también un formulario para crear nuevas empresas y
    formularios de edición para cada empresa existente, que se
    utilizarán en modales.
    """
    empresas = Empresa.objects.all()
    form = EmpresaForm()
    edit_forms = {empresa.pk: EmpresaForm(instance=empresa) for empresa in empresas}  # <-- esto es clave
    return render(request, 'administration/company/list_company.html', {
        'empresas': empresas,
        'form': form,
        'edit_forms': edit_forms,  # <-- esto es clave
    })

# ===============================================================
# CREACIÓN DE EMPRESAS
# ===============================================================
@rol_requerido(RolUsuario.SUPERADMIN)
def empresa_create(request):
    """
    Procesa la creación de una nueva empresa.
    
    Si el formulario es válido, guarda la empresa y redirige al listado.
    Si hay errores, vuelve al listado pero con el modal de creación abierto
    mostrando los errores.
    """
    if request.method == 'POST':
        form = EmpresaForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Empresa creada correctamente.")
            return redirect('lista_empresas')
        else:
            # Si hay errores, vuelve a la lista y muestra el modal abierto
            empresas = Empresa.objects.all()
            edit_forms = {empresa.pk: EmpresaForm(instance=empresa) for empresa in empresas}
            return render(request, 'administration/company/list_company.html', {
                'empresas': empresas,
                'form': form,  # este form tiene los errores
                'edit_forms': edit_forms,
                'abrir_modal': True,  # bandera para abrir el modal
            })
    else:
        return redirect('lista_empresas')
    
# ===============================================================
# ACTUALIZACIÓN DE EMPRESAS
# ===============================================================
@rol_requerido(RolUsuario.SUPERADMIN)
def empresa_update(request, pk):
    """
    Actualiza los datos de una empresa existente.
    
    Recibe el ID de la empresa a modificar, valida los datos
    del formulario y guarda los cambios si son correctos.
    """
    empresa = get_object_or_404(Empresa, pk=pk)
    if request.method == 'POST':
        form = EmpresaForm(request.POST, instance=empresa)
        if form.is_valid():
            form.save()
            messages.success(request, "Empresa actualizada correctamente.")
            return redirect('lista_empresas')
    else:
        form = EmpresaForm(instance=empresa)
    return render(request, 'administration/company/list_company.html', {'form': form})

# ===============================================================
# ELIMINACIÓN DE EMPRESAS
# ===============================================================
@rol_requerido(RolUsuario.SUPERADMIN)
def empresa_delete(request, pk):
    """
    Elimina una empresa del sistema.
    
    Recibe el ID de la empresa a eliminar y la elimina si la
    solicitud es de tipo POST. Incluye una confirmación previa
    en la interfaz para evitar eliminaciones accidentales.
    """
    empresa = get_object_or_404(Empresa, pk=pk)
    if request.method == 'POST':
        empresa.delete()
        messages.success(request, "Empresa eliminada correctamente.")
        return redirect('lista_empresas')
    return render(request, 'administration/company/list_company.html', {'empresa': empresa})