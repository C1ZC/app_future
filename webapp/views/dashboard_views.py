from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages

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