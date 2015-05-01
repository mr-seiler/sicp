; an atom is a singular thing - not a list (pair) and not an empty list
(define (atom? thing) 
  (and (not (pair? thing)) 
       (not (null? thing))))

; lat: a list of atoms
(define (lat? l)
  (cond
    ((null? l) #t)
    ((atom? (car l)) (lat? (cdr l)))
    (else #f)))

; check if an atom is in a lat.
; boolean only: not the same as memq/memv/member, which return a sublist or false
(define (member? thing lat)
  (if (null? lat)
      #f
      (or (eq? thing (car lat))
          (member? thing (cdr lat)))))

; rember: remove a member from a lat.
; this is actually "multirember" - removes all occurences 
; of an atom from a lat instead of just the first.
(define (rember m lat)
  (cond
    ((null? lat) '())
    ((eq? m (car lat)) (rember m (cdr lat)))
    (else (cons (car lat) 
                (rember m (cdr lat))))))

; return the first atom from each lat in a list of lats
(define (firsts l)
  (cond
    ((null? l) `())
    (else (cons (caar l) 
                (firsts (cdr l))))))

; [Stopped at page 47]