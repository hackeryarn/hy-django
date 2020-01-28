(import [django.contrib [admin]])
(import [django.urls [include path]])

(setv urlpatterns
      [(path "admin/" (. admin site urls))
       (path "polls/" (include "polls.urls"))])
