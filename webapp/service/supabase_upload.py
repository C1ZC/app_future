from .supabase_client import supabase_public

SUPABASE_BUCKET = "pdfs"  # Cambia si tu bucket tiene otro nombre

def upload_pdf_to_supabase(file, filename):
    file.seek(0)
    file_bytes = file.read()
    res = supabase_public.storage.from_(SUPABASE_BUCKET).upload(
        filename, file_bytes, file_options={
            "content-type": "application/pdf", "upsert": "true"}
    )
    print("DEBUG:", res)
    # Considera éxito si hay un path, error si no lo hay
    success = hasattr(res, "path") and res.path is not None
    return success, getattr(res, "path", None) or res
