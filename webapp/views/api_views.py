# ===============================================================
# APIS DE GESTIÓN DE DOCUMENTOS
# ===============================================================
# Este módulo contiene endpoints de API para operaciones relacionadas
# con la gestión de documentos, incluyendo búsqueda de módulos/grupos
# y acceso a esquemas JSON para la extracción de datos.
# ===============================================================

from django.http import JsonResponse
from webapp.models import Modulo, Grupo
from django.db.models import Q
from django.shortcuts import get_object_or_404
import unicodedata

# ===============================================================
# UTILIDADES DE NORMALIZACIÓN DE TEXTO
# ===============================================================
def normalizar_texto(texto):
    """
    Normaliza texto para búsqueda quitando acentos y convirtiendo a minúsculas.
    
    Esta función es crucial para las búsquedas porque permite:
    1. Encontrar coincidencias independientemente de acentos 
       (ej: "curriculum" encuentra "currículum")
    2. Hacer búsquedas insensibles a mayúsculas/minúsculas
    
    Args:
        texto: Texto a normalizar
        
    Returns:
        Texto normalizado sin acentos y en minúsculas
    """
    # Primero normaliza Unicode (separa caracteres base de acentos)
    texto_normalizado = unicodedata.normalize('NFKD', texto)
    # Luego elimina los caracteres no ASCII (como acentos)
    texto_sin_acentos = ''.join(
        [c for c in texto_normalizado if not unicodedata.combining(c)])
    # Convierte a minúsculas
    return texto_sin_acentos.lower()

# ===============================================================
# FORMULARIO PARA FILTRADO DE DOCUMENTOS
# ===============================================================
# Esta sección gestiona las APIs necesarias para los formularios de
# filtrado de documentos. Incluye búsqueda de módulos y grupos
# que se utilizan para poblar selectores y autocompletado en los
# formularios de filtrado.
# ===============================================================
def buscar_modulos_grupos(request):
    """
    API para buscar módulos y grupos según término de búsqueda.
    
    Esta API alimenta el autocompletado en formularios de filtro de documentos,
    permitiendo:
    1. Buscar por coincidencia parcial en nombres o descripciones
    2. Obtener resultados normalizados (sin importar acentos/mayúsculas)
    3. Recibir tanto módulos como grupos en un solo llamado
    
    Args:
        request: Request HTTP con parámetro GET 'termino'
        
    Returns:
        JsonResponse con lista de resultados formateados
    """
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
