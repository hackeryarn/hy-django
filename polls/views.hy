(import [django.shortcuts [render get_object_or_404]]
        [django.http [HttpResponse HttpResponseRedirect]]
        [django.urls [reverse]]
        [polls.models [Choice Question]])

(defn ->dict [&rest pairs]
  (dict (partition pairs)))

(defn index [request]
  (->> (Question.objects.order_by "-pub_date")
       (take 5)
       (->dict "latest_question_list")
       (render request "polls/index.html")))

(defn detail [request question_id]
  (->> (get_object_or_404 Question :pk question_id)
       (->dict "question")
       (render request "polls/detail.html")))

(defn results [request question_id]
  (->> (get_object_or_404 Question :pk question_id)
      (->dict "question")
      (render request "polls/results.html")))

(defn vote [request question_id]
  (setv question (get_object_or_404 Question :pk question_id))
  (try
    (setv selected_choice (.choice_set.get question :pk (. request POST ["choice"])))
    (except [[KeyError Choice.DoesNotExist]]
      (return (render request
                      "polls/detail.html"
                      {"question" question
                       "error_message" "You didn't select a choice."})))
    (else
      (+= selected_choice.votes 1)
      (.save selected_choice)
      (HttpResponseRedirect (reverse "polls:results" :args [question.id])))))
