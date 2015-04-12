; Defining pairs of integers with just some maths
(define (int-pair a b)
  (* (expt 2 a) (expt 3 b)))

; R5RS `log` is the natural logarithm; this creates a function that 
; performs log_b (log base b) of x using log_e(x) / log_e(b)
;(define (log_b b)
;  (lambda (x)
;    (/ (log x) (log b))))

; log base 2
;(define log_2 (log_b 2))

; log base 3
;(define log_3 (log_b 3))

; count how many times n can be evenly divided by d
(define (count-divisions n d)
  (if (= (remainder n d) 0)
      (+ 1 (count-divisions (/ n d) d))
      0))

; select `a` (car, first, etc.) from int pair `p` 
; there ought to be a nice way to get this to work with logarithms...
; but that wasn't working so well.  Repeated division seems to work just fine.
(define (int-first p)
  (count-divisions p 2))

; select `b` (cdr, rest, second, etc.) from int pair `p` 
; (see `int-first`)
(define (int-second p)
  (count-divisions p 3))

; test pairs
(define p1 (int-pair 3 5))
(define p2 (int-pair 10 53))
(define p3 (int-pair 1 1))