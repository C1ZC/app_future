from django.shortcuts import render, redirect
from django.urls import reverse
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AuthenticationForm
from django.contrib import messages
from webapp.service.auth import AuthService
from webapp.service.supabase_upload import upload_pdf_to_supabase

def register(request):
    success, result, message = AuthService.register_user(request)

    if success:
        messages.success(request, message)
        return redirect('home')

    return render(request, 'registration/register.html', {'form': result})

def login_view(request):
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')    
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)
                return redirect('home')
        else:
            messages.error(request, "Invalid username or password.")
    else:
        form = AuthenticationForm()
    return render(request, 'registration/login.html', {'form': form})

def logout_view(request):
    logout(request)
    return redirect('login')

@login_required
def home(request):
    return render(request, 'pages/home.html')

@login_required
def dashboard(request):
    try:
        context = {
            'user': request.user,
        }
        return render(request, 'pages/dashboard.html', context)
    except Exception as e:
        messages.error(request, f'Error al cargar el dashboard: {str(e)}')
        return redirect('home')

@login_required
def sidebar(request):
    try:
        context = {
            'user': request.user,
        }
        return render(request, 'pages/sidebar.html', context)
    except Exception as e:
        messages.error(request, f'Error al cargar el sidebar: {str(e)}')
        return redirect('home')


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
    return render(request, "menu/upload_pdf.html")
