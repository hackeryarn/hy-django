"""
WSGI config for hy_django project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/howto/deployment/wsgi/
"""
(import os
        [django.core.wsgi [get_wdgi_application]])

((. os environ setdefault) 'DJANGO_SETTINGS_MODULE' 'hy_django.settings')

(setv application (get_wdgi_application))
