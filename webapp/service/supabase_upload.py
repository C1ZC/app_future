import requests
import os

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")
SUPABASE_BUCKET = "pdfs"  # Cambia el nombre si tu bucket es diferente

def upload_pdf_to_supabase(file, filename):
    """
    Sube un archivo PDF a Supabase Storage.
    """
    storage_url = f"{SUPABASE_URL}/storage/v1/object/{SUPABASE_BUCKET}/{filename}"
    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
        "Content-Type": "application/pdf",
        "x-upsert": "true"
    }
    response = requests.post(storage_url, headers=headers, data=file.read())
    return response.status_code == 200 or response.status_code == 201, response.text