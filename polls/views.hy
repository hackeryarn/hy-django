(import [django.shortcuts [render get_object_or_404]]
        [django.http [HttpResponse]]
        [polls.models [Question]])

(defn assoc-pipe [struct key val]
  (assoc struct key val)
  struct)

(defn index [request]
  (->> (Question.objects.order_by "-pub_date")
       (take 5)
       (assoc-pipe {} "latest_question_list")
       (render request "polls/index.html")))

(defn detail [request question_id]
  (->> (get_object_or_404 Question :pk question_id)
       (assoc-pipe {} "question")
       (render request "polls/detail.html")))

(defn results [request question_id]
  (setv response "You're lookint at the results of question %s.")
  (HttpResponse (% response question_id)))

(defn vote [request question_id]
  (HttpResponse (% "You're voting on question %s." question_id)))
