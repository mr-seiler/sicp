; point: pair of numbers
(define (make-point x y) (cons x y))

; point selectors
(define (point-x p) (car p))
(define (point-y p) (cdr p))

; helper: display list of things
; 'twas much harder to get working than I thought it would be...
(define (display-list things)
  (if (not (null? things))
      (begin 
        (display (car things))
        (display-list (cdr things)))))

; display point
(define (print-point p)
  (display-list (list "(" (point-x p) "," (point-y p) ")")))

; line: pair of points (more properly - a segment)
(define (make-line p1 p2) (cons p1 p2))

; line selectors
(define (line-start l) (car l))
(define (line-end l) (cdr l))

; line midpoint
(define (line-midpoint l)
  (make-point (/ (+ (point-x (line-start l)) 
                    (point-x (line-end l))) 
                 2) 
              (/ ( + (point-y (line-start l)) 
                     (point-y (line-end l))) 
                 2)))

