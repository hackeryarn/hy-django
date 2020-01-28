(import os
        [django.core.asgi [get_asgi_application]])

((. os environ setdefault) "DJANGO_SETTINGS_MODULE" "hy_django.settings")

(setv application
      (get_asgi_application))
