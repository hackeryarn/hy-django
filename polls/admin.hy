(import [django.contrib [admin]]
        [polls.models [Question]])

(admin.site.register Question)
