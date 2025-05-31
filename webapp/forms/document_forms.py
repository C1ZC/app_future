from django import forms
from webapp.models import Documento, DocumentoStatus, Grupo, Modulo, Servicio

class DocumentoUploadForm(forms.Form):
    archivo = forms.FileField(
        label="Seleccione un archivo",
        help_text="Archivos permitidos: PDF, JPG, PNG, GIF, TXT, DOCX, XLSX"
    )
    
    grupo_id = forms.ModelChoiceField(
        queryset=Grupo.objects.filter(activo=True),
        label="Grupo de Documento",
        required=False,
        empty_label="Seleccione un grupo"
    )
    
    modulo_id = forms.ModelChoiceField(
        queryset=Modulo.objects.none(),  # Se poblará después
        label="Módulo de Documento",
        required=False,
        empty_label="Seleccione un módulo"
    )
    
    def __init__(self, *args, **kwargs):
        self.request_user = kwargs.pop('request_user', None)
        super().__init__(*args, **kwargs)
        
        # Si tenemos datos POST y un grupo_id, poblar el queryset de módulos
        if args and len(args) > 0 and 'grupo_id' in args[0]:
            try:
                grupo_id = args[0].get('grupo_id')
                if grupo_id:
                    self.fields['modulo_id'].queryset = Modulo.objects.filter(
                        grupo_id=grupo_id, activo=True
                    )
            except (ValueError, TypeError):
                pass
    
    def clean(self):
        """
        Método clean para asegurar que modulo_id sea válido
        """
        cleaned_data = super().clean()
        grupo_id = cleaned_data.get('grupo_id')
        modulo_id = self.data.get('modulo_id')
        
        # Si hay un grupo seleccionado y un módulo enviado, validar
        if grupo_id and modulo_id:
            # Actualizar el queryset del campo modulo_id para validación
            self.fields['modulo_id'].queryset = Modulo.objects.filter(
                grupo=grupo_id, activo=True
            )
        
        return cleaned_data

class DocumentoFilterForm(forms.Form):
    ESTADO_CHOICES = [('', 'Todos')] + list(DocumentoStatus.choices)
    
    texto_busqueda = forms.CharField(required=False, label="Buscar")
    estado = forms.ChoiceField(choices=ESTADO_CHOICES, required=False, label="Estado")
    fecha_desde = forms.DateField(required=False, widget=forms.DateInput(attrs={'type': 'date'}), label="Desde")
    fecha_hasta = forms.DateField(required=False, widget=forms.DateInput(attrs={'type': 'date'}), label="Hasta")