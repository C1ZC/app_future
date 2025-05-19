from django import forms
from webapp.models import Empresa, Servicio, PerfilUsuario
from django.contrib.auth.models import User

class EmpresaForm(forms.ModelForm):
    class Meta:
        model = Empresa
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'

class ServicioForm(forms.ModelForm):
    class Meta:
        model = Servicio
        fields = ['nombre', 'empresa']
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'
        self.fields['empresa'].empty_label = "Seleccione una empresa"
        self.fields['empresa'].queryset = Empresa.objects.all()

class PerfilUsuarioForm(forms.ModelForm):
    class Meta:
        model = PerfilUsuario
        fields = ['servicio', 'empresa', 'rol']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'


class UserForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput, required=True)
    class Meta:
        model = User
        fields = ['username', 'email', 'password']

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
    class Meta:
        model = User
        fields = ['username', 'email']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'
    
