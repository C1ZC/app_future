from django import forms
from django.contrib.auth.models import User
from django.contrib.auth import password_validation
from django.core.exceptions import ValidationError
import re

from webapp.models import Empresa, Servicio, PerfilUsuario

# ===============================================================
# FORMULARIOS DE EMPRESA
# ===============================================================
class EmpresaForm(forms.ModelForm):
    """Formulario para crear y editar empresas."""

    class Meta:
        model = Empresa
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'

    def clean_telefono(self):
        telefono = self.cleaned_data['telefono']
        # Solo números, opcionalmente con +56 al inicio
        telefono = re.sub(r'\D', '', telefono)
        if len(telefono) < 9:
            raise ValidationError("El teléfono debe tener al menos 9 dígitos.")
        return telefono

    def clean_RUT(self):
        rut = self.cleaned_data['RUT']
        rut = re.sub(r'\D', '', rut)  # Solo números
        if len(rut) < 8 or len(rut) > 9:
            raise ValidationError("El RUT debe tener 8 o 9 dígitos.")
        # Formatear a xx.xxx.xxx-x
        cuerpo = rut[:-1]
        dv = rut[-1]
        cuerpo = cuerpo[::-1]
        partes = [cuerpo[i:i+3][::-1] for i in range(0, len(cuerpo), 3)]
        cuerpo_formateado = '.'.join(partes[::-1])
        rut_formateado = f"{cuerpo_formateado}-{dv}"
        return rut_formateado

# ===============================================================
# FORMULARIOS DE SERVICIO
# ===============================================================
class ServicioForm(forms.ModelForm):
    """Formulario para crear y editar servicios."""

    class Meta:
        model = Servicio
        fields = ['nombre', 'empresa']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'
        self.fields['empresa'].empty_label = "Seleccione una empresa"
        self.fields['empresa'].queryset = Empresa.objects.all()

# ===============================================================
# FORMULARIOS DE USUARIO
# ===============================================================
class UserForm(forms.ModelForm):
    """Formulario para crear nuevos usuarios."""

    password = forms.CharField(widget=forms.PasswordInput, required=True)

    class Meta:
        model = User
        fields = ['username', 'email', 'password', 'first_name', 'last_name']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'

    def save(self, commit=True):
        user = super().save(commit=False)
        user.set_password(self.cleaned_data["password"])
        if commit:
            user.save()
        return user

class UserEditForm(forms.ModelForm):
    """Formulario para editar usuarios existentes."""

    class Meta:
        model = User
        fields = ['username', 'email', 'first_name', 'last_name']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'

class PerfilUsuarioEditForm(forms.ModelForm):
    """Formulario para editar el perfil de un usuario."""

    class Meta:
        model = User
        fields = ['username', 'first_name', 'last_name', 'email']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'

class PasswordChangeCustomForm(forms.Form):
    """Formulario personalizado para cambiar la contraseña de un usuario."""

    old_password = forms.CharField(
        label="Contraseña actual",
        widget=forms.PasswordInput,
    )
    new_password1 = forms.CharField(
        label="Nueva contraseña",
        widget=forms.PasswordInput,
        help_text=password_validation.password_validators_help_text_html()
    )
    new_password2 = forms.CharField(
        label="Confirmar nueva contraseña",
        widget=forms.PasswordInput,
    )

    def __init__(self, user, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.user = user
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'

    def clean_old_password(self):
        old_password = self.cleaned_data["old_password"]
        if not self.user.check_password(old_password):
            raise forms.ValidationError("La contraseña actual es incorrecta.")
        return old_password

    def clean(self):
        cleaned_data = super().clean()
        p1 = cleaned_data.get("new_password1")
        p2 = cleaned_data.get("new_password2")
        if p1 and p2 and p1 != p2:
            self.add_error("new_password2", "Las contraseñas no coinciden.")
        password_validation.validate_password(p1, self.user)
        return cleaned_data

    def save(self, commit=True):
        self.user.set_password(self.cleaned_data["new_password1"])
        if commit:
            self.user.save()
        return self.user

# ===============================================================
# FORMULARIOS DE PERFIL DE USUARIO
# ===============================================================
class PerfilUsuarioForm(forms.ModelForm):
    """Formulario para gestionar los permisos y roles del usuario."""

    class Meta:
        model = PerfilUsuario
        fields = ['servicio', 'empresa', 'rol']

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('request_user', None)
        super().__init__(*args, **kwargs)

        # Aplicar estilos a todos los campos
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'

        # Limitar opciones según el rol del usuario autenticado
        if user:
            perfil = getattr(user, 'perfil', None)
            if perfil:
                if perfil.es_admin_empresa():
                    # Admins de empresa solo ven su empresa y sus servicios
                    self.fields['empresa'].queryset = Empresa.objects.filter(pk=perfil.empresa_id)
                    self.fields['servicio'].queryset = Servicio.objects.filter(empresa=perfil.empresa)
                    self.fields['rol'].choices = [
                        (choice, label) for choice, label in self.fields['rol'].choices
                        if choice in ['admin_servicio', 'usuario_servicio']
                    ]
                elif perfil.es_admin_servicio():
                    # Admins de servicio solo ven su empresa y servicio
                    self.fields['empresa'].queryset = Empresa.objects.filter(pk=perfil.empresa_id)
                    self.fields['servicio'].queryset = Servicio.objects.filter(pk=perfil.servicio_id)
                    self.fields['rol'].choices = [
                        (choice, label) for choice, label in self.fields['rol'].choices
                        if choice == 'usuario_servicio'
                    ]
                elif perfil.es_superadmin():
                    # Superadmins ven todas las opciones
                    self.fields['empresa'].queryset = Empresa.objects.all()
                    self.fields['servicio'].queryset = Servicio.objects.all()