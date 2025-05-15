from django.shortcuts import render, redirect
from django.urls import reverse
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AuthenticationForm
from django.contrib import messages
from webapp.service.auth import AuthService

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
