(in-package :cl-prob)

(defun event-function (event)
  (typecase event
    (function event)
    (list #'(lambda (x) (member x event :test #'equal)))
    (otherwise (partial #'equal event))))