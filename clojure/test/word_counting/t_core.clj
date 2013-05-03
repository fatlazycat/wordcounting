(ns word_counting.t-core
  (:use midje.sweet)
  (:use [word_counting.core]))

(facts "can add item"
  (addItem {} "a") => { "a" 1}
  (addItem {"a" 1} "a") => { "a" 2}
  (addItem {"a" 2} "b") => { "a" 2 "b" 1}
  )

(facts "can count words from file"
       (count (words)) => 6077
       (first (words)) => "Well"
       (last (words)) => "up"
       )

(facts "counts of words match"
;  (get (test-by-fold) "the") => 277
  (get (test-by-freq) "the") => 277
;  (test-by-group-by) => ""
  )

(facts "remove blank lines from split"
       (remove-blank-lines "\n\n") => ""
       (remove-blank-lines "\na b\n") => "a b"
       (remove-blank-lines "\na\nc") => "ac"
       )