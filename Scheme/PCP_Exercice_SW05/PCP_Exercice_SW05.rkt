;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname PCP_Exercice_SW05) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Aufgabe 1
;; =============================================================================
(/ [+ 42 (- 25 (* 3 4))] 11)
(+ [/ (+ 24 32 ) 7] [* 3 ( - 17 15)])
(- (/ 34428 38) (- 1103 197))
;; =============================================================================



;; Aufgabe 2
;; =============================================================================
(/ 1 (+ 1 1)) ; Berechnungen erfolgen von Innen nach Aussen
(/ 1 (+ 1 (/ 1 (+ 1 1)))) ; 1 / 1.5 = 0.6666666667
(/ 1 (+ 1 (/ 1 (+ 1 (/ 1 (+ 1 1)))))) ; Auch hier, berechnung von Innen nach Aussen
;; =============================================================================



;; Aufgabe 3
;; =============================================================================
(define (diagonale length width)
  (sqrt (+ (sqr length) (sqr width))))
;; =============================================================================




;; Aufgabe 4
;; =============================================================================


;; Aufgabe 5*
;; =============================================================================
;; a)
(define (tempInWords temperatur)
  (cond
    ((> temperatur 35) "heiss")
    ((> temperatur 25) "warm")
    ((> temperatur 15) "mittel")
    (else "kalt")
  )
)
;; Klauseln dürfen hier nicht verschoben werden.

;; b)
(define (teilbar zahl)
  (cond
    ((zero? (remainder zahl 2)) "durch 2 teilbar")
    ((zero? (remainder zahl 3)) "durch 3 teilbar")
    (else "weder durch 2 noch durch 3 teilbar")
  )
)
;; Hier kommt's nicht drauf an. Bei z.B. 6 sind beide Antworten korrekt.
;; Einfach die Antwort ist eine andere. Je nachdemw as zuerst zutrifft.
;; =============================================================================



;; Aufgabe 6*
;; =============================================================================
(define (toll total-weight)
  (cond
    ((not (number? total-weight)) "Eingabe muss Zahl sein!")
    ((<= total-weight 0) "Zahl muss größer 0 sein!")
    ((<= total-weight 1000) 20)
    ((<= total-weight 2000) 30)
    ((<= total-weight 5000) 50)
    ((<= total-weight 10000) 100)
    (else 250)
  )
)
;; a) Ob "total-weight" eine Zahl un grösser 0 ist.
;; b) Reihenfolge ist wichtig, schon alleine bezüglich der Prüfung ob's eine Nummer ist oder nicht.
;;    Überprüfung der Gewichte erfolgt hier aufsteigend. Dies darf auch nicht verändert werden.
;; c) z.B. wenn ein Gewicht exakt 1000 sein muss.
;; =============================================================================



;; Aufgabe 7*
;; =============================================================================
(define (doSomething a b)
  (* (cond
       ((> a b) a)
       ((< a b) b)
       (else -1)
     )
     (+ a 1)
  )
)

;; a) Nein. "a" und "b" wurden nicht definiert.
;; b) Siehe Oben...
;; =============================================================================



;; Aufgabe 8*
;; =============================================================================
;; Aus Folie
(define-struct point (x y)) ; Strukturdefinition
(define p (make-point 2 3)) ; Aufruf Konstruktor, "p" als point(x, y) mit (2, 3)

(define (calcDistance p)
  (sqrt (+ (sqr (point-x p)) (sqr (point-y p))))
)
;; =============================================================================



;; Aufgabe 9*
;; =============================================================================
(define-struct human (age gender thighLength))

(define man (make-human 45 "m" 50))
(define woman (make-human 30 "w" 52))

(define (b-length currHuman)
  (cond
    ((string=? (human-gender currHuman) "m") (- (+ 69.089 (* 2.238 (human-thighLength currHuman))) 
                                               [cond 
                                                 (
                                                   (> (human-age currHuman) 30)
                                                     (* (-(human-age currHuman) 30) 0.06)
                                                 )                             
                                                 (else 0)
                                               ]
                                             )
    )
    ((string=? (human-gender currHuman) "w") (- (+ 61.412 (* 2.317 (human-thighLength currHuman))) 
                                               [cond
                                                 (
                                                   (> (human-age currHuman) 30)
                                                     (* (-(human-age currHuman) 30) 0.06)
                                                 )                             
                                                 (else 0)
                                               ]
                                             )
    )
    (else "Geschlecht unbekannt!"))
  )



