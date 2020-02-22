(import
  datetime
  [django.db [models]]
  [django.utils [timezone]])

(defclass Question [models.Model]
  (setv question_text (models.CharField :max_length 200)
        pub_date (models.DateTimeField "date published"))

  (defn __str__ [self]
    self.question_text)

  (defn was_published_recently [self]
    (setv now (.now timezone))
    (<= (- now (.timedelta datetime :days 1))
        self.pub_date
        now))

  (setv was_published_recently.admin_order_field "pub_date"
        was_published_recently.boolean True
        was_published_recently.short_descriptions "Published recently?"))

(defclass Choice [models.Model]
  (setv question (models.ForeignKey Question :on_delete models.CASCADE)
        choice_text (models.CharField :max_length 200)
        votes (models.IntegerField :default 0))

  (defn __str__ [self]
    self.choice_text))
