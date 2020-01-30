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
    (>= self.pub_date (- (timezone.now) (datetime.timedelta :days 1)))))

(defclass Choice [models.Model]
  (setv question (models.ForeignKey Question :on_delete models.CASCADE)
        choice_text (models.CharField :max_length 200)
        votes (models.IntegerField :default 0))

  (defn __str__ [self]
    self.choice_text))
