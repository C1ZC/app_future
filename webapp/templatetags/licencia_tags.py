from django import template
from django.utils import timezone

register = template.Library()

@register.filter
def multiply(value, arg):
    """Multiplica el valor por el argumento"""
    try:
        return float(value) * float(arg)
    except (ValueError, TypeError):
        return 0

@register.filter
def divisibleby(value, arg):
    """Devuelve el valor si es divisible por arg, 0 en caso contrario"""
    try:
        if float(value) % float(arg) == 0:
            return float(value)
        return 0
    except (ValueError, TypeError):
        return 0

@register.filter
def mult(value, arg):
    """Multiplica el valor por el argumento y devuelve el resultado"""
    try:
        return float(value) * float(arg)
    except (ValueError, TypeError):
        return 0

@register.simple_tag
def now():
    """Retorna la fecha actual"""
    return timezone.now().date()