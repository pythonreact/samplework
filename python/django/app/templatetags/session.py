from django import template
register = template.Library()


@register.simple_tag(takes_context=True)
def delsession(context):
    try:
        del context.request.session['msg']
        context.request.session.modified=True
        return ''
    except KeyError:
        return ''
    
