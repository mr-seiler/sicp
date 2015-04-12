; Church numerals
; One day, somehow, I will understand how these work.  For now, the exercise solutions (one, two, and add)
; are from wikipedia.  compose and repeat are from earlier in the book.  `church` uses those to create
; arbitrary church numerals

; "The higher=order function that represents the natural number `n` is a function that maps any function `f`
; to it's `n`-fold composition.  In simpler terms, the "value" of the numeral is equivalent to the number
; of times the function encapsulates its argument."

; "The Church numeral 3 represents the action of applying any given function three times to a value. 
; The supplied function is first applied to a supplied parameter and then successively to its own result. 
; The end result is not the numeral 3 (unless the supplied parameter happens to be 0 and the function is 
; a successor function). The function itself, and not its end result, is the Church numeral 3. The Church 
; numeral 3 means simply to do anything three times. It is an ostensive demonstration of what is meant by 'three times'."

; ...so methinks we can write a function that creates Church numerals, yes?

(define (compose f g)
  (lambda (x)
    (f (g x))))

; Creates a function that applies function `f` to its argument 'n' times
(define (repeat f n)
  (if (= n 0)
      (lambda (x) x)
      (compose f (repeat f (- n 1)))))

; Create Church numeral `n` - a lambda that maps some function to its nth-degree composition
(define (church n)
  (lambda (f)
    (repeat f n)))

; Given: zero
; Given a function f, applies f to argument x zero times
(define zero 
  (lambda (f) 
    (lambda (x) (x))))

; From Wiki: applies f to argumnet x once
(define one
  (lambda (f)
    (lambda (x) (f x))))

; From Wiki: applies f to argument x twice
(define two
  (lambda (f)
    (lambda (x) (f (f x)))))

; I'll be honest.  I have no idea what this does.
(define (add-1 n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))

; wiki refers to the previous as the "successor function"
(define succ add-1)

; Without looking it up?  Never in a million years.  Brain... it hurts.
(define (add m n)
  (lambda (f)
    (lambda (x)
      (m (f ((n f) x))))))