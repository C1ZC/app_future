from django.http import JsonResponse
from webapp.models import Modulo, Grupo
from django.db.models import Q
from django.shortcuts import get_object_or_404

def buscar_modulos_grupos(request):
    """API para buscar módulos y grupos según término de búsqueda"""
    termino = request.GET.get('termino', '')
    
    if not termino or len(termino) < 2:
        return JsonResponse({'resultados': []})
    
    # Buscar en módulos
    modulos = Modulo.objects.filter(
        Q(nombre__icontains=termino) | 
        Q(descripcion__icontains=termino),
        activo=True
    ).select_related('grupo').values(
        'id', 'nombre', 'grupo_id', 'grupo__nombre'
    )[:15]  # Limitar a 15 resultados
    
    # Preparar resultados con contexto
    resultados = []
    for modulo in modulos:
        resultados.append({
            'id': modulo['id'],
            'texto': f"{modulo['nombre']} ({modulo['grupo__nombre']})",
            'tipo': 'modulo',
            'grupo_id': modulo['grupo_id'],
            'modulo_id': modulo['id'],
            'modulo_nombre': modulo['nombre'],
            'grupo_nombre': modulo['grupo__nombre']
        })
    
    # También podemos agregar resultados de grupos
    grupos = Grupo.objects.filter(
        Q(nombre__icontains=termino) | 
        Q(descripcion__icontains=termino),
        activo=True
    ).values('id', 'nombre')[:5]
    
    for grupo in grupos:
        resultados.append({
            'id': grupo['id'],
            'texto': f"Grupo: {grupo['nombre']}",
            'tipo': 'grupo',
            'grupo_id': grupo['id'],
            'grupo_nombre': grupo['nombre']
        })
    
    return JsonResponse({'resultados': resultados})


def get_modulo_esquema_json(request, modulo_id):
    """API para obtener el esquema JSON de un módulo específico"""
    modulo = get_object_or_404(Modulo, id=modulo_id)
    return JsonResponse({
        'esquema_json': modulo.esquema_json
    })
