; error isn't bound by default in Racket R5RS (pity), so this is from
; `http://srfi.schemers.org/srfi-23/srfi-23.html`
(define (error reason . args)
      (display "Error: ")
      (display reason)
      (for-each (lambda (arg) 
                  (display " ")
		  (write arg))
		args)
      (newline)
      (scheme-report-environment -1))

; interval constructor
(define (make-interval lo hi) (cons lo hi))

; alternate constructor: center and width
(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

; 2.12 alternate constructor: center and percentage
(define (make-center-percent c p)
  (let ((w (* c (/ p 2))))
    (make-center-width c w)))

; access lower bound (2.7)
(define (lower-bound interval) (car interval))

; access upper bound (2.7)
(define (upper-bound interval) (cdr interval))

; calculate the width of the interval
(define (width interv) 
  (/ (- (upper-bound interv) (lower-bound interv)) 2))

; calculate (get) the center of the interval
(define (center interv)
  (/ (+ (lower-bound interv) (upper-bound interv)) 2))

; add two intervals
(define (add-interval one two)
  (make-interval (+ (lower-bound one) (lower-bound two))
                 (+ (upper-bound one) (upper-bound two))))

; 2.8 subtract two intervals
(define (sub-interval one two)
  (make-interval (- (lower-bound one) (lower-bound two))
                 (- (upper-bound one) (upper-bound two))))

; multiply two intervals
(define (mul-interval one two)
  (let ((p1 (* (lower-bound one) (lower-bound two)))
        (p2 (* (lower-bound one) (upper-bound two)))
        (p3 (* (upper-bound one) (lower-bound two)))
        (p4 (* (upper-bound one) (upper-bound two))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

; 2.11 maybe
; Three cases per interval: (+ +), (- +), (- -)
; Each case for the  first interval pairs with one of the same three cases for the second,
; ...for a total of 3 x 3 = 9 cases, as the book says.
; This is an abomination!  Presumably, there's some more clever way of doing the 9 cases
; which allows for some code reuse... right?  Right?!  Because *this* is:
; Harder to write + 
; Harder to read +
; Harder to test =
; More error prone!  Not worth it to save 2 multiplications *some of the time*.
(define (mul-interval-alt one two)
  (let ((l1 (lower-bound one))
        (l2 (lower-bound two))
        (h1 (upper-bound one))
        (h2 (upper-bound two)))
    (case (
           ((and (>= 0 l1) (>= 0 h1)) 
            (case 
                 (((and (>= 0 l2) (>= 0 h2)) 
                   (make-interval (* l1 l2) (h1 h2)))
                  ((and (< 0 l2) (>= 0 h2)) 
                   (make-interval (* h1 l2) (* h1 h2)))
                  ((and (< 0 l2) (< 0 h2)) 
                   (make-interval (* h1 l2) (* l1 h2)))))
           ((and (< 0 l1) (>= 0 h1)) 
            (case 
                 (((and (>= 0 l2) (>= 0 h2)) 
                   (make-interval (* l1 h2) (* h1 h2)))
                  ((and (< 0 l2) (>= 0 h2)) 
                   (mul-interval one two)) ; I think this is the one that takes > 2 multiplications
                  ((and (< 0 l2) (< 0 h2)) 
                   (make-interval (* h1 l2) (* l1 l2)))
           ((and (< 0 l1) (< 0 h1)) 
            (case 
                 (((and (>= 0 l2) (>= 0 h2))
                   (make-interval (* l1 h2) (* h1 l2)))
                  ((and (< 0 l2) (>= 0 h2))
                   (make-interval (* l1 h2) (* l1 l2)))
                  ((and (< 0 l2) (< 0 h2))
                   (make-interval (* h1 h2) (* l1 l2))))))))))))))
         

; calculate the width of the interval
(define (width interv) 
  (/ (- (upper-bound interv) 
        (lower-bound interv))
     2))

; divide two intervals
(define (div-interval one two)
  (if (= 0 (width two))
      (error "Divided by zero!") ;; 2.10
      (mul-interval one 
                    (make-interval (/ 1.0 (upper-bound two))
                                   (/ 1.0 (lower-bound two))))))


; some tests and such... division doesn't seem to make much sense, but that definition 
; is straight from the book!  Would certainly explain the weirdness in 2.14 - 2.16 i
; f mult and div operations weren't inverses...
(define int0 (make-interval 10 10))
(define int1 (make-interval 1 3))
(define int2 (make-interval 2 4))

(define int3 (add-interval int1 int2))
(display int3)
(display (sub-interval int3 int1))
(display (sub-interval int3 int2))

(define int4 (mul-interval int1 int2))
(display int4)
(display (div-interval int4 int1))
(display (div-interval int4 int2))
