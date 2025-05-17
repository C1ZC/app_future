from supabase import create_client
import os

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")
SUPABASE_SERVICE_ROLE = os.getenv("SUPABASE_SERVICE_ROLE")

supabase_public = create_client(SUPABASE_URL, SUPABASE_KEY)
supabase_private = create_client(SUPABASE_URL, SUPABASE_SERVICE_ROLE)