; 2.23

(define (my-for-each op lat)
  (if (null? lat) 
      #true
      (begin 
        (op (car lat))
        (my-for-each op (cdr lat)))))

(my-for-each (lambda (it) (newline) (display it))
             (list 1 2 3 4))
  
  