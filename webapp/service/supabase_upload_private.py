from .supabase_client import supabase_private

SUPABASE_BUCKET = "pdfs"  # Cambia si tu bucket tiene otro nombre

def upload_pdf_to_supabase_private(file, filename):
    file.seek(0)
    file_bytes = file.read()
    res = supabase_private.storage.from_(SUPABASE_BUCKET).upload(
        filename, file_bytes, file_options={"content-type": "application/pdf", "upsert": "true"})
    success = hasattr(res, "path") and res.path is not None
    return success, getattr(res, "path", None) or res