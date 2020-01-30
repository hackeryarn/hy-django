(import [django.apps [AppConfig]])

(defclass PollsConfig [AppConfig]
  (setv name "polls"))

(print PollsConfig)
