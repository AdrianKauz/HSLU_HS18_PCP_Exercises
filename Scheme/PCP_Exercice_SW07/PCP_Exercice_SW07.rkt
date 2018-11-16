;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname PCP_Exercice_SW07) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Aufgabe 2*
; =============================================================================
; Die Definition einer strukturellen Rekursion könnte so aussehen:
(define (fib_a n)
  (cond
    ((or (= n 0) (= n 1)) n)
    (else (+ (fib_a (- n 1)) (fib_a (- n 2)))))
  )

; a) Implementieren Sie eine Rekursion mit Akkumulator. Nutzen Sie dazu die local Definition.

(define (fib_b n)
  (local (
          (define (fib-acc x current previous) ; Mit Hilfsvariablen
            (cond ((equal? x n) current)
                   (else (fib-acc (+ x 1)  (+ current previous) current))
            ))
          )
  (fib-acc 0 0 1)))

; b) Führen Sie Vergleich Tests mit und ohne Akkumulator durch. Welche Unterschiede sehen Sie?
;   Für grosse Zahlen ist die Variante mit Hilfsvariablen um einiges schneller. Stack füllt sich mit Zwischenresultaten.
; =============================================================================


; Aufgabe 3* "PCP-Scheme-5.pdf" Seite 16 & 17
; =============================================================================
(define a 42)

(let ((a 1)
      (b (+ a 1))) ;a ist hier obiges a aus "define"
  b)

(let* ((a 1)
       (b (+ a 1))) ;a ist hier (a 1)
  b)

; a) Was ist die Ausgabe des folgenden Scheme-Programms?
;    let: Spezielle Form der Variablendefinition.
;    Erstes "let" : 43
;    Zweites "let": 2

; b) Erklären Sie, warum sich die beiden Ausdrücke unterscheiden.
;    Erstes "let" :
;    Zweites "let": Sequentielles let*, Auswertung erfolgt von links nach rechts
; =============================================================================


; Aufgabe 4*
; =============================================================================
(define x 1)
(define y 5)

((lambda (x y)
   (+ (* 2 x) y))
 y x) ; <- Hier erfolgt Variablenzuweisung!

((lambda (a b)
   (+ (* 2 x) y))
 y x) ; <- Hier erfolgt Variablenzuweisung! Aber diesmal im Zusammenspiel mit a b

; a) Was ist die Ausgabe des folgenden Scheme-Programms?
;    11
;    7

; b) Erklären Sie, warum sich die beiden Ausdrücke unterscheiden.
;    Erstes Lambda : x(1) zu y, y(5) zu x, danach Auswertung
;    Zweites Lambda: x(1) zu b, y(5) zu a, danach Auswetung von x y. 
; =============================================================================


; Aufgabe 5*
; =============================================================================
; Angenommen, man hat die Liste...
(define a-list (list (list 1 2 3) (list 1 2) (list 1 2 3 4)))
; und möchte jede Liste mit 0 beginnen lassen. Wie kann man dies erreichen, ohne, dass extra eine
; Funktion (mit Namen) geschrieben werden muss?
; Bö???
; =============================================================================


; Aufgabe 6*
; =============================================================================
(define rect-calc-list
  (list (lambda (a b) (* a b)) (lambda (a b) (* 2 (+ a b)))))

(define (calc-a-list functionlist a b)
  (if (empty? functionlist)
      (
        (write 'finished)
        (newline)
      )
      (
        (write ((first functionlist) a b))
        (newline)
        (calc-a-list (rest functionlist) a b)
      )
  )
)

(calc-a-list rect-calc-list 2 3)
(calc-a-list rect-calc-list 5 5)
; =============================================================================

