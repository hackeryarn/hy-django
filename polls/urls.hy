(import [django.urls [path]]
        [polls [views]])

(setv urlpatterns
      [(path "" (. views index) :name "index")])
