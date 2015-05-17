; 2.18 - reverse a list
(define (my-rev l)
  (cond
    ((null? l) '())
    ((null? (cdr l)) (list (car l)))
    (else (append (my-rev (cdr l)) (list (car l))))))



(display (my-rev '()))
(newline)
(display (my-rev '(1)))
(newline)
(display (my-rev '(1 2 3)))
(newline)
(display (my-rev '(1 2 3 4 5)))
(newline)