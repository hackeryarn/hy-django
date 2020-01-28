"""
ASGI config for hy_django project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/howto/deployment/asgi/
"""
(import os
        [django.core.asgi [get_asgi_application]])

((. os environ setdefault) 'DJANGO_SETTINGS_MODULE' 'hy_django.settings')

(setv application
      (get_asgi_application))
