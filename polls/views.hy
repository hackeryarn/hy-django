(import [django.shortcuts [render get_object_or_404]]
        [django.http [HttpResponseRedirect]]
        [django.urls [reverse]]
        [django.utils [timezone]]
        [django.views [generic]]
        [polls.models [Choice Question]])

(defn ->dict [&rest pairs]
  (dict (partition pairs)))

(defclass IndexView [generic.ListView]
  (setv template_name "polls/index.html"
        context_object_name "latest_question_list")

  (defn get_queryset [self]
    (setv questions (-> (.filter Question.objects :pub_date__lte (.now timezone))
                        (.order_by "-pub_date")))
    (list (take 5 questions))))


(defclass DetailView [generic.DetailView]
  (setv model Question
        template_name "polls/detail.html"))

(defclass ResultsView [generic.DetailView]
  (setv model Question
        template_name "polls/results.html"))

(defn vote [request question_id]
  (setv question (get_object_or_404 Question :pk question_id))
  (try
    (setv selected_choice (.get question.choice_set :pk (. request POST ["choice"])))
    (except [[KeyError Choice.DoesNotExist]]
      (return (render request
                      "polls/detail.html"
                      {"question" question
                       "error_message" "You didn't select a choice."})))
    (else
      (+= selected_choice.votes 1)
      (.save selected_choice)
      (HttpResponseRedirect (reverse "polls:results" :args [question.id])))))
