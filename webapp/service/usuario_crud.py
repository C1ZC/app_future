from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from webapp.models import PerfilUsuario
from webapp.forms.administration_forms import PerfilUsuarioForm, UserForm, UserEditForm
from webapp.service.roles import rol_requerido, RolUsuario
from django.contrib.auth.models import User

@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA, RolUsuario.ADMIN_SERVICIO)
def usuario_list(request):
    usuarios = PerfilUsuario.objects.all()
    user_form = UserForm()
    perfil_form = PerfilUsuarioForm(request_user=request.user)
    edit_forms = {}
    for usuario in usuarios:
        perfil_form_edit = PerfilUsuarioForm(instance=usuario, request_user=request.user)
        user_form_edit = UserEditForm(instance=usuario.user)
        edit_forms[usuario.pk] = {
            'perfil_form': perfil_form_edit,
            'user_form': user_form_edit,
        }
    return render(request, 'administration/usuario/lista_usuarios.html', {
        'usuarios': usuarios,
        'user_form': user_form,
        'perfil_form': perfil_form,
        'edit_forms': edit_forms,
    })


@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA, RolUsuario.ADMIN_SERVICIO)
def usuario_create(request):
    if request.method == 'POST':
        user_form = UserForm(request.POST)
        perfil_form = PerfilUsuarioForm(request.POST, request_user=request.user)
        if user_form.is_valid() and perfil_form.is_valid():
            user = user_form.save()
            perfil = perfil_form.save(commit=False)
            perfil.user = user
            perfil.save()
            messages.success(request, "Usuario creado correctamente.")
            return redirect('lista_usuarios')
        else:
            usuarios = PerfilUsuario.objects.all()
            edit_forms = {usuario.pk: PerfilUsuarioForm(instance=usuario, request_user=request.user) for usuario in usuarios}
            return render(request, 'administration/usuario/lista_usuarios.html', {
                'usuarios': usuarios,
                'user_form': user_form,
                'perfil_form': perfil_form,
                'edit_forms': edit_forms,
                'abrir_modal': True,
            })
    else:
        return redirect('lista_usuarios')
    
@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA, RolUsuario.ADMIN_SERVICIO)
def usuario_update(request, pk):
    perfil = get_object_or_404(PerfilUsuario, pk=pk)
    user = perfil.user
    if request.method == 'POST':
        user_form = UserEditForm(request.POST, instance=user)
        perfil_form = PerfilUsuarioForm(request.POST, instance=perfil, request_user=request.user)
        if user_form.is_valid() and perfil_form.is_valid():
            user_form.save()
            perfil_form.save()
            messages.success(request, "Usuario actualizado correctamente.")
            return redirect('lista_usuarios')
    else:
        user_form = UserEditForm(instance=user)
        perfil_form = PerfilUsuarioForm(instance=perfil, request_user=request.user)
    return render(request, 'administration/usuario/lista_usuarios.html', {'user_form': user_form, 'perfil_form': perfil_form})

@rol_requerido(RolUsuario.SUPERADMIN, RolUsuario.ADMIN_EMPRESA, RolUsuario.ADMIN_SERVICIO)
def usuario_delete(request, pk):
    perfil = get_object_or_404(PerfilUsuario, pk=pk)
    if request.method == 'POST':
        perfil.user.delete()
        perfil.delete()
        messages.success(request, "Usuario eliminado correctamente.")
        return redirect('lista_usuarios')
    return render(request, 'administration/usuario/lista_usuarios.html', {'perfil': perfil})