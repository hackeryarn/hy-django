(import [django.urls [reverse]])

(defn create_question [question_text days]
  (setv time (+ (.now timezone) (.timedelta datetime :days days)))
  (.create Question.objects
           :question_text question_text
           :pub_date time))

(defclass QuestionIndexViewTest [TestCase]
  (defn test_no_questions [self]
    (setv response (.get self.client (reverse "polls:index")))
    (.assertEqual self response.status_code 200)
    (.assertContains self response "No polls are available.")
    (.assertQuerysetEqual self
                          (. response context ["latest_question_list"])
                          [])))
