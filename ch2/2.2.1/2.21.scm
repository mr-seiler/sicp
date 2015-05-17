; 2.21

; square-list w/ out map
(define (square-list-1 nums)
  (if (null? nums)
      '()
      (cons (* (car nums) 
               (car nums)) 
            (square-list-1 (cdr nums)))))

; square-list w/ map
(define (square-list-2 nums)
  (map (lambda (n) (* n n)) nums))