(import datetime
        [django.test [TestCase]]
        [django.urls [reverse]]
        [django.utils [timezone]]
        [polls.models [Question]])

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
                          []))

  (defn test_past_question [self]
    (create_question :question_text "Past question." :days -30)
    (setv response (.get self.client (reverse "polls:index")))
    (.assertQuerysetEqual self
                          (. response context ["latest_question_list"])
                          ["<Question: Past question.>"]))

  (defn test_future_question [self]
    (create_question :question_text "Future question." :days 30)
    (setv response (.get self.client (reverse "polls:index")))
    (.assertQuerysetEqual self
                          (. response context ["latest_question_list"])
                          []))

  (defn test_future_question_and_past_question [self]
    (create_question :question_text "Past question." :days -30)
    (create_question :question_text "Future question." :days 30)
    (setv response (.get self.client (reverse "polls:index")))
    (.assertQuerysetEqual self
                          (. response context ["latest_question_list"])
                          ["<Question: Past question.>"]))

  (defn test_two_past_questions [self]
    (create_question :question_text "Past question 1." :days -30)
    (create_question :question_text "Past question 2." :days -5)
    (setv response (.get self.client (reverse "polls:index")))
    (.assertQuerysetEqual self
                          (. response context ["latest_question_list"])
                          ["<Question: Past question 2.>"
                           "<Question: Past question 1.>"])))

(defclass QuestionDetailViewTests [TestCase]
  (defn test_future_question [self]
    (setv future_question (create_question :question_text "Future question."
                                           :days 5)
          url (reverse "polls:detail" :args [future_question.id])
          response (.get self.client url))
    (.assertEqual self response.status_code 404))

  (defn test_past_question [self]
    (setv past_question (create_question :question_text "Past quyestion."
                                         :days -5)
          url (reverse "polls:detail" :args [past_question.id])
          response (.get self.client url))
    (.assertContains self response past_question.question_text)))
