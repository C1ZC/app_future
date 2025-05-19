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