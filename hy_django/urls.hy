(import [django.contrib [admin]])
(import [django.urls [path]])

(setv urlpatterns
      [(path "admin/" (. admin site urls))])
