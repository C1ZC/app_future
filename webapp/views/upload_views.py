from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from webapp.service.supabase_upload import upload_pdf_to_supabase
from webapp.service.supabase_upload_private import upload_pdf_to_supabase_private

@login_required
def upload_pdf(request):
    if request.method == "POST":
        pdf_file = request.FILES.get("pdf_file")
        if not pdf_file:
            messages.error(request, "Debes seleccionar un archivo PDF.")
            return redirect('upload_pdf')
        if not pdf_file.name.lower().endswith('.pdf'):
            messages.error(request, "Solo se permiten archivos PDF.")
            return redirect('upload_pdf')
        success, resp = upload_pdf_to_supabase(pdf_file, pdf_file.name)
        if success:
            messages.success(request, "Archivo PDF subido correctamente.")
        else:
            messages.error(request, f"Error al subir el archivo: {resp}")
        return redirect('upload_pdf')
    return render(request, "menu/upload_pdf.html", {"modo": "publico"})

@login_required
def upload_pdf_private(request):
    if request.method == "POST":
        pdf_file = request.FILES.get("pdf_file")
        if not pdf_file:
            messages.error(request, "Debes seleccionar un archivo PDF.")
            return redirect('upload_pdf_private')
        if not pdf_file.name.lower().endswith('.pdf'):
            messages.error(request, "Solo se permiten archivos PDF.")
            return redirect('upload_pdf_private')
        success, resp = upload_pdf_to_supabase_private(pdf_file, pdf_file.name)
        if success:
            messages.success(request, "Archivo PDF privado subido correctamente.")
        else:
            messages.error(request, f"Error al subir el archivo privado: {resp}")
        return redirect('upload_pdf_private')
    return render(request, "menu/upload_pdf.html", {"modo": "privado"})