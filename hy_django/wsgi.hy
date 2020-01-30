(import os
        [django.core.wsgi [get_wsgi_application]])

(os.environ.setdefault "DJANGO_SETTINGS_MODULE" "hy_django.settings")

(setv application (get_wsgi_application))
