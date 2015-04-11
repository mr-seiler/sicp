;;;; A few chapter 1 exercises
;;;; Relatively difficult mathematics in Lisp syntax is... pretty hard.
;;;; Not sure if I can ever finish all of these.
;;;; Also, just an aside... SublimeREPL kind of sucks (on Windows, anyway)
;;;; No Scheme interpreter actually uses 'scheme' as the frakking binary name!

;;; define the delta used to cutoff recursion when seeking a fixed-point
(define tolerance 0.00001)

;;; Approximates a fixed point of the function f by repeated application
(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

(define (average x y)
    (/ (+ x y) 2))

(define (average-damp f)
    (lambda (x) (average x (f x))))

(define (square x)
    (* x x))

(define (sqrt x)
    (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

(define (cube-root x)
    (fixed-point (average-damp (lambda (y) (/ x (square y)))) 1.0))


(define dx tolerance)

;;; Define the derivative of g(x), Dg(x)
(define (deriv g)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x)) dx)))

(define (newton-transform g)
    (lambda (x)
        (- x (/ (g x) ((deriv g) x)))))

;;; define newton's method in as a fixed-point transformation
(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess))


(define (fixed-point-of-transform g transform guess)
    (fixed-point (transform g) guess))

(define (cubic a b c)
    ;; I have no idea what this wants
    )

;;; returns procedure that applies function f to it's argument twice
(define (double f)
    (lambda (x)
        (f (f x))))

(define (inc n)
    (+ n 1))

(define (add-two n)
    ((double inc) n))

;;; compose two single-argument functions f and g
(define (compose f g)
    (lambda (x) (f (g x))))

;;; return a function that applies f() to a single argument "n" times
(define (repeated f n)
    (if (= n 0)
        (lambda (x) x)
        (compose f (repeated f (- n 1)))
    )
)

;;; smooths a function by averages f(x), f(x + dx), and f(x - dx)
(define (smooth f)
    (lambda (x) (/ (+ (f x) (f (+ x dx)) (f (- x dx))) 3)))

;;; smooths a function n-times
(define (nth-smooth f n)
    (repeated (smooth f) n))
