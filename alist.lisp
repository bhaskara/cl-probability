(in-package :cl-prob)

;; Probability distributions represented as alist, where entries are compared using #'equal

(defmethod probability ((dist list) event)
  (let ((fn (event-function event)))
    (reduce #'+ dist :key #'(lambda (pair) (if (funcall fn (car pair)) (cdr pair) 0.0)))))

(defmethod condition-on-event ((dist list) event &key return-type)
  (assert (null return-type))
  (let* ((fn (event-function event))
	 (norm (probability dist fn)))
    (assert (> norm 0) nil "Can't condition dist ~a on event ~a with probability 0" dist event)
    (loop
       for pair in dist
       for x = (car pair)
       when (funcall fn x)
       collect (cons x (/ (cdr pair) norm)))))

(defmethod sample ((dist list))
  (let ((p (random 1.0))
	(s 0.0))
    (dolist (pair dist (caar (last dist)))
      (incf s (cdr pair))
      (when (> s p)
	(return (car pair))))))

(defun normalize-alist! (dist)
  "Normalize an alist distribution to sum to 1"
  (let ((total (reduce #'+ dist :key #'cdr)))
    (assert (not (zerop total)))
    (dolist (pair dist dist)
      (_f / (cdr pair) total))))
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Internal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun event-function (event)
  (typecase event
    (function event)
    (list #'(lambda (x) (member x event :test #'equal)))
    (otherwise (partial #'equal event))))