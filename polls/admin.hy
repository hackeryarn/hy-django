(import [django.contrib [admin]]
        [polls.models [Choice Question]])

(defclass ChoiceInline [admin.TabularInline]
  (setv model Choice
        extra 3))

(defclass QuestionAdmin [admin.ModelAdmin]
  (setv fieldsets [[None {"fields" ["question_text"]}]
                   ["Date information" {"fields" ["pub_date"]}]]
        inlines [ChoiceInline]
        list_display ["question_text" "pub_date" "was_published_recently"]
        list_filter ["pub_date"]
        search_fields ["question_text"]))


(.register admin.site Question QuestionAdmin)
