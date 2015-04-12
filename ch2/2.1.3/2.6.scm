; Church numerals

; "The higher=order function that represents the natural number `n` is a function that maps any function `f`
; to it's `n`-fold composition.  In simpler terms, the "value" of the numeral is equivalent to the number
; of times the function encapsulates its argument."

; "The Church numeral 3 represents the action of applying any given function three times to a value. 
; The supplied function is first applied to a supplied parameter and then successively to its own result. 
; The end result is not the numeral 3 (unless the supplied parameter happens to be 0 and the function is 
; a successor function). The function itself, and not its end result, is the Church numeral 3. The Church 
; numeral 3 means simply to do anything three times. It is an ostensive demonstration of what is meant by 'three times'."

; ...so methinks we can write a function that creates Church numerals, yes?

; compose two functions, f ang g (this is from chapter 1)
(define (compose f g)
  (lambda (x)
    (f (g x))))

; Creates a function that applies function `f` to its argument 'n' times
; (also from chapter 1)
(define (repeat f n)
  (if (= n 0)
      (lambda (x) x)
      (compose f (repeat f (- n 1)))))

; Create Church numeral `n` - a lambda that maps some function to its nth-degree composition
(define (church n)
  (lambda (f)
    (repeat f n)))

; Given in ch 2: zero
; Given a function f, applies f to argument x zero times
(define zero 
  (lambda (f) 
    (lambda (x) (x))))

; From Wiki: applies f to argumnet x once
; (same as `(church 1)`)
(define one
  (lambda (f)
    (lambda (x) (f x))))

; From Wiki: applies f to argument x twice
; (same as `(church 2)`)
(define two
  (lambda (f)
    (lambda (x) (f (f x)))))

; (n f) is the function that applies f to argument n times.
; Therefore ((n f) x) calls f on x n times.
; Lastly, (f ((n f) x)) wraps the above in one additional application of f.
; So given Church numeral n, returns numeral n+1
(define (add-1 n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))

; wiki refers to the previous as the "successor function"
(define succ add-1)

; Addition of church numerals
; Would never have been able to come up with this.  First looked it up,
; then slept on it, now it somewhat makes sense.
; (n f) applies f n-times.  (m f) applies f m-times.  First we call
; ((n f) x) to apply f to argument x n-times.  Then, we call ((m f) "result")
; to apply f to x m more times.
; This can alternatively be defined in terms of add-1 (the successor function)
(define (add m n)
  (lambda (f)
    (lambda (x)
      ((m f) ((n f) x)))))

; Multiplication of church numerals
; Much less sure about this one... why isn't it `((m (n f)) x)`?
; (n f) is a function that applies f n-times.  (m (n f)) is the function
; that applies (n f) m-times. So the total number of applications of
; f to its argument will be m * n.  
; But... why don't we need to have a `lambda (x)` inside the `lambda (f)`, as with addition?
; Exponentiation reduces even further: instead of (l (f) (m (n f)))m it's just (m n).  
; This seems to imply that you _cannot_ define tetration of church numerals using only their definition?
(define (mul m n)
  (lambda (f)
    (m (n f))))

; SUBTRACTION... is totally nuts.  It can apparently only be defined in terms of the 
; predecessor function, and it might take me years to understand the predecessor function...


; for testing
(define (inc n) (+ n 1))

(define three (add one two))

(define five (church 5))

(define ten (mul two five))

(define add-three (three inc))

(define add-ten (ten inc))