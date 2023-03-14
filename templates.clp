(deftemplate amazonbook  
    (slot asin (type STRING))
    (slot ISBN10 (type STRING))
    (multislot categories (type STRING))
    (multislot rankcategories (type STRING))
    (slot title (type STRING))
    (slot rank)
)


(deftemplate request
   (slot id (type STRING))
   (multislot preferences (type STRING))
)

(deftemplate book_recommendation
   (slot requestid)
   (slot asin (type STRING))
   (multislot rankcategories (type STRING))   
   (slot rank)
)


(deftemplate extracted_topics
    (slot requestid (type STRING))
    (multislot categories (type STRING))

)