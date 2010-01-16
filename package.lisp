(defpackage :cl-probability
  (:nicknames :cl-prob)
  (:use :cl :cl-utils)
  (:export 
   :probability :condition-on-event :sample
   
   :normalize-alist!))
