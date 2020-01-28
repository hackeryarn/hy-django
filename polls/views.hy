(import [django.http [HttpResponse]])

(defn index [request]
  (HttpResponse "Hello, world. You're at the polls index."))
