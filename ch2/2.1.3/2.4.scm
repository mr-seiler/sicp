; implementing a pair with procedures
; constructor returns a function of one argument; when passed another function `m`, 
; m is called with the same parameters as the constructor
(define (make x y)
  (lambda (m) (m x y)))

; selector for first, like `car`
; since `z` will be a function returned from `make`, we can call
; z with a lambda that returns the first of its arguments
(define (first z)
  (z (lambda (x y) x)))

; selector for second/rest, like `cdr`
; calls `z` with a lambda that returns its second argument
(define (rest z)
  (z (lambda (x y) y)))