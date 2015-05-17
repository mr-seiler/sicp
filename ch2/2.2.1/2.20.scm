;; given a predicate function of one argument, returns a function
;; that filters a list using that predicate
(define (where pred?)
  (define (where-help lat)
    (cond ((null? lat) '())
          ((pred? (car lat)) (cons (car lat) (where-help (cdr lat))))
          (else (where-help (cdr lat)))))
  where-help)

;; get all the even numbers from a list
(define all-evens (where even?))

;; get all the odd numbers from a list
(define all-odds (where odd?))

;; 2.20 - takes 1 or more integers and returns a list of all the arguments that have
;; the same even-odd parity as the first argument
(define (same-parity first . others)
  (if (even? first)
      (cons first (all-evens others))
      (cons first (all-odds others))))

