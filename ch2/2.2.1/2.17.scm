; 2.17 - return the last element from a nonempty list
(define (last-pair l)
  (cond
    ((null? l) '())
    ((null? (cdr l)) (car l))
    (else (last-pair (cdr l)))))

(display (last-pair '(1 2 3)))
(newline)
(display (last-pair '(1)))
(newline)
(display (last-pair '()))