from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from django.contrib import messages
from webapp.forms.administration_forms import PerfilUsuarioEditForm, PasswordChangeCustomForm

@login_required
def perfil_view(request):
    user = request.user
    perfil_form = PerfilUsuarioEditForm(instance=user)
    password_form = PasswordChangeCustomForm(user)
    abrir_modal_password = False

    if request.method == 'POST':
        if 'save_profile' in request.POST:
            perfil_form = PerfilUsuarioEditForm(request.POST, instance=user)
            if perfil_form.is_valid():
                perfil_form.save()
                messages.success(request, "Perfil actualizado correctamente.")
                return redirect('perfil')
        elif 'save_password' in request.POST:
            password_form = PasswordChangeCustomForm(user, request.POST)
            abrir_modal_password = True
            if password_form.is_valid():
                password_form.save()
                messages.success(request, "Contraseña cambiada correctamente.")
                return redirect('perfil')
            else:
                messages.success(
                    request, "Corrige los errores en el formulario de contraseña.")

    return render(request, 'pages/perfiles.html', {
        'form': perfil_form,
        'password_form': password_form,
        'abrir_modal_password': abrir_modal_password,
    })