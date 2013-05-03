(ns word_counting.core
  (:use [clojure.string :only (split split-lines join)]
        [criterium.core]
        ))

(defn remove-blank-lines [str]
  (join
    (filter (complement empty?)
            (split-lines str))))

(defn words []
  (split 
    (slurp "resources/test.txt")
    #"([\.,\-– \t\"\':;\?…]+)"))


(defn test-by-group-by []
  (apply hash-map
    (mapcat (fn [i] [(key i) (count (val i))]) (group-by (fn [x] == x) (words)))
    ))

(defn addItem [acc x]
  (let [total (get acc x 0)]
  (assoc acc x (inc total))
  ))

(defn test-by-freq []
  (frequencies (words))
  )

(defn test-by-fold []
  (reduce #(addItem %1 %2) {} (words))
  )

(defn test-perf []
;    (bench (+ 1 2)))
  (bench
    (doall
      (test-by-fold))))
;      (test-by-freq))))

(defn -main "main function" [& args]
  (test-perf))