from django import forms
from webapp.models import Documento, DocumentoStatus, Servicio

class DocumentoUploadForm(forms.Form):
    archivo = forms.FileField(
        label="Seleccione un archivo",
        help_text="Archivos permitidos: PDF, JPG, PNG, GIF, TXT"
    )
    grupo = forms.CharField(
        max_length=100, 
        required=False,
        widget=forms.TextInput(attrs={'placeholder': 'Opcional'})
    )
    modulo = forms.CharField(
        max_length=100, 
        required=False,
        widget=forms.TextInput(attrs={'placeholder': 'Opcional'})
    )
        # Si quieres permitir seleccionar un servicio específico al subir (útil para admins):
    servicio_id = forms.ModelChoiceField(
        queryset=Servicio.objects.none(), # Se poblará en la vista o __init__
        label="Servicio (Opcional)",
        required=False,
        widget=forms.Select(attrs={'class': 'form-select'})
    )

    def __init__(self, *args, **kwargs):
        request_user = kwargs.pop('request_user', None) # Ejemplo para filtrar queryset
        super().__init__(*args, **kwargs)
        if request_user and hasattr(request_user, 'perfil') and request_user.perfil.empresa:
            self.fields['servicio_id'].queryset = Servicio.objects.filter(empresa=request_user.perfil.empresa)
        elif request_user and request_user.is_superuser:
             self.fields['servicio_id'].queryset = Servicio.objects.all()


class DocumentoFilterForm(forms.Form):
    ESTADO_CHOICES = [('', 'Todos')] + list(DocumentoStatus.choices)
    
    texto_busqueda = forms.CharField(required=False, label="Buscar")
    estado = forms.ChoiceField(choices=ESTADO_CHOICES, required=False, label="Estado")
    fecha_desde = forms.DateField(required=False, widget=forms.DateInput(attrs={'type': 'date'}), label="Desde")
    fecha_hasta = forms.DateField(required=False, widget=forms.DateInput(attrs={'type': 'date'}), label="Hasta")