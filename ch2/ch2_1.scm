; rename car and cdr to something less cryptic
(define first car)
(define rest cdr)

; construct a rational number from a numerator and denominator
; - reduces to lowest terms using gcd
; - normalizes negativity, but that's a bit of a mess...
; - handles a numerator of zero properly; does NOT throw an error if
; the denominator is zero (don't know how to do that yet)
(define (rational n d)
  (if (zero? n)
      (cons 0 0)
      (let ((g (gcd n d)))
        (let ((nn (/ n g)) (dd (/ d g)))
          (if (positive? (* nn dd))
              (cons (abs nn) (abs dd))
              (cons (- (abs nn)) (abs dd)))))))

; get the numerator of a rational number
(define (numer r) (first r))

; get the denominator of a rational number
(define (denom r) (rest r))


; print a rational number
(define (print-rational r)
  ;(newline)
  (display (numer r))
  (display "/")
  (display (denom r)))

; mathematical operations on rationals
;; add two rationals and return a rational
(define (add-rational r1 r2)
  (rational (+ (* (numer r1) (denom r2)) 
               (* (numer r2) (denom r1))) 
            (* (denom r1) (denom r2))))

;; subtract two rationals
(define (sub-rational r1 r2)
  (rational (- (* (numer r1) (denom r2)) 
               (* (numer r2) (denom r1))) 
            (* (denom r1) (denom r2))))

;; multiply two rationals
(define (mul-rational r1 r2)
  (rational (* (numer r1) (numer r2)) 
            (* (denom r1) (denom r2))))

;; divide two rationals
(define (div-rational r1 r2)
  (rational (* (numer r1) (denom r2)) 
            (* (denom r1) (numer r2))))

;; compare two rationals
(define (equal-rational? r1 r2)
  (= (* (numer r1) (denom r2)) 
     (* (numer r2) (denom r1))))