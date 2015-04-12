; point: pair of numbers
(define (make-point x y) (cons x y))

; point selectors
(define (point-x p) (car p))
(define (point-y p) (cdr p))

; helper: display list of things
; `begin` was the key, to keep it from exploding
(define (display-list things)
  (if (not (null? things))
      (begin 
        (display (car things))
        (display-list (cdr things)))))

; display point
(define (print-point p)
  (display-list (list "(" (point-x p) "," (point-y p) ")")))

; rectangle as a pair of points
(define (make-rect top-left bottom-right) (cons top-left bottom-right))

(define (rect-width r)
  (- (point-x (cdr r))
     (point-x (car r))))

(define (rect-height r)
  (- (point-y (cdr r)) 
     (point-y (car r))))

; area of rectangle
(define (rect-area r)
  (* (rect-width r) (rect-height r)))

;perimeter of rectangle
(define (rect-perim r)
  (+ (* 2 (rect-width r)) 
     (* 2 (rect-height r))))

; rectangle as width, height, and origin
(define (make-rect-2 top-left, width, height)
  (cons top-left (cons width height)))

; same as (car (cdr r))
(define (rect-width-2 r) (cdar r))

; same as (cdr (cdr r))
(define (rect-height-2 r) (cddr r))

; the area and perimeter functions will work with either 
; version of the width and height functions