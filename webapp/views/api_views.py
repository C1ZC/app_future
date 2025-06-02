from django.http import JsonResponse
from webapp.models import Modulo, Grupo
from django.db.models import Q
from django.shortcuts import get_object_or_404
import unicodedata


def normalizar_texto(texto):
    """Normaliza texto para búsqueda quitando acentos y convirtiendo a minúsculas"""
    # Primero normaliza Unicode (separa caracteres base de acentos)
    texto_normalizado = unicodedata.normalize('NFKD', texto)
    # Luego elimina los caracteres no ASCII (como acentos)
    texto_sin_acentos = ''.join(
        [c for c in texto_normalizado if not unicodedata.combining(c)])
    # Convierte a minúsculas
    return texto_sin_acentos.lower()

def buscar_modulos_grupos(request):
    """API para buscar módulos y grupos según término de búsqueda"""
    termino = request.GET.get('termino', '')
    
    if not termino or len(termino) < 2:
        return JsonResponse({'resultados': []})
    
    # Buscar con filtros modificados para ignorar acentos
    termino_normalizado = normalizar_texto(termino)

    # Buscar en módulos usando función personalizada
    modulos = []
    for modulo in Modulo.objects.filter(activo=True).select_related('grupo'):
        # Normalizar nombres y descripciones para comparación
        nombre_normalizado = normalizar_texto(modulo.nombre)
        descripcion_normalizada = normalizar_texto(modulo.descripcion or '')

        # Si coincide con el término normalizado, agregar a resultados
        if termino_normalizado in nombre_normalizado or termino_normalizado in descripcion_normalizada:
            modulos.append({
                'id': modulo.id,
                'nombre': modulo.nombre,
                'grupo_id': modulo.grupo.id,
                'grupo__nombre': modulo.grupo.nombre
            })

            # Limitar a 15 resultados
            if len(modulos) >= 15:
                break
    
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
    
    # También podemos agregar resultados de grupos con el mismo enfoque
    grupos = []
    for grupo in Grupo.objects.filter(activo=True):
        nombre_normalizado = normalizar_texto(grupo.nombre)
        descripcion_normalizada = normalizar_texto(grupo.descripcion or '')

        if termino_normalizado in nombre_normalizado or termino_normalizado in descripcion_normalizada:
            grupos.append({
                'id': grupo.id,
                'nombre': grupo.nombre
            })

            if len(grupos) >= 5:
                break
    
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
