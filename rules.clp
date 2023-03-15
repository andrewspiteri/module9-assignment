(defrule extract_topics
   "Extract topics for list of book titles supplied."
   ?a <- (request (id ?id) (preferences $?preferences))
   ?b <- (amazonbook (rankcategories $?rankcategories) (title ?title))
   ;The member$ function will tell if a single field value is contained in a multifield value.
   (test (member$ ?title $?preferences))
   =>
   (assert (extracted_topics (requestid ?id) (categories $?rankcategories)))
)

(defrule recommend_books
   "Recomend books based on topics of previous list."
   ?u <- (extracted_topics (requestid ?id) (categories $?categories))
   ?b <- (amazonbook (asin ?asin) (title ?title) (rankcategories $?rankcategories) (rank ?rank))   
   ;This function checks if one multifield value is a subset of another; i.e., if all the fields in the first multifield value are also in the second multifield value.
   (test (subsetp $?categories $?rankcategories))
   => 
   (assert (book_recommendation (requestid ?id) (asin ?asin) (title ?title) (rankcategories ?rankcategories) (rank ?rank) ))
   ;Remove the recomendation from the list so it is not presented again. 
   (retract ?u ?b)
)


(defrule retract_books_recomended
   ?a <- (book_recommendation (asin ?asin))
   ?b <- (amazonbook (asin ?asin))
   =>
   (retract ?b)
)