(import datetime
        [django.test [TestCase]]
        [django.utils [timezone]]
        [polls.models [Question]])

(defclass QuestionModelTests [TestCase]
  (defn test_was_published_recently_with_future_question [self]
    (setv time (+ (.now timezone) (.timedelta datetime :days 30))
          future_question (Question :pub_date time))
    (.assertIs self (.was_published_recently future_question) False))

  (defn test_was_published_recently_with_old_question [self]
    (setv time (- (.now timezone) (.timedelta datetime :days 1 :seconds 1))
          old_question (Question :pub_date time))
    (.assertIs self (.was_published_recently old_question) False))

  (defn test_was_published_recently_with_recent_question [self]
    (setv time (- (.now timezone) (.timedelta datetime
                                              :hours 23
                                              :minutes 59
                                              :seconds 59))
          recent_question (Question :pub_date time))
    (.assertIs self (.was_published_recently recent_question) True)))
