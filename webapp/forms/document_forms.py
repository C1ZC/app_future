from django import forms
from webapp.models import Documento, DocumentoStatus

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

class DocumentoFilterForm(forms.Form):
    ESTADO_CHOICES = [('', 'Todos')] + list(DocumentoStatus.choices)
    
    texto_busqueda = forms.CharField(required=False, label="Buscar")
    estado = forms.ChoiceField(choices=ESTADO_CHOICES, required=False, label="Estado")
    fecha_desde = forms.DateField(required=False, widget=forms.DateInput(attrs={'type': 'date'}), label="Desde")
    fecha_hasta = forms.DateField(required=False, widget=forms.DateInput(attrs={'type': 'date'}), label="Hasta")