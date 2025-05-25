from django import template

register = template.Library()

@register.filter(name='addclass')
def addclass(value, arg):
    return value.as_widget(attrs={'class': arg})


@register.filter
def dict_get(d, key):
    if isinstance(d, dict):
        return d.get(key)
    return ""

@register.filter
def as_p(form):
    if hasattr(form, 'as_p'):
        return form.as_p()
    return ""


@register.filter
def multiply(value, arg):
    """Multiplica el valor por el argumento"""
    return value * arg


@register.filter
def divisibleby(value, arg):
    """Devuelve value divisible por arg"""
    return value // arg


@register.filter
def mult(value, arg):
    """Multiplica el valor por el argumento"""
    return value * arg


@register.filter
def widthratio(value, max_value, max_width):
    """Calcula el ratio (porcentaje) entre value y max_value, con máximo max_width"""
    try:
        ratio = min(float(value) / float(max_value) *
                    float(max_width), float(max_width))
        return ratio
    except (ValueError, ZeroDivisionError):
        return 0
