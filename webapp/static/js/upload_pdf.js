document.getElementById('uploadForm').addEventListener('submit', function(e) {
    const fileInput = document.getElementById('pdf_file');
    if (fileInput.files.length === 0) {
        alert('Por favor selecciona un archivo PDF.');
        e.preventDefault();
        return;
    }
    const file = fileInput.files[0];
    if (file.type !== 'application/pdf') {
        alert('Solo se permiten archivos PDF.');
        e.preventDefault();
    }
});
