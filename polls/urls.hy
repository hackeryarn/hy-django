(import [django.urls [path]]
        [polls [views]])

(setv app_name "polls"
      urlpatterns
      [(path "" (views.IndexView.as_view) :name "index")
       (path "<int:pk>/" (views.DetailView.as_view) :name "detail")
       (path "<int:pk>/results" (views.ResultsView.as_view) :name "results")
       (path "<int:question_id>/vote" views.vote :name "vote")])
