;;;; -*- Mode: LISP -*-

(in-package :asdf)

(defsystem :cl-probability
  :components
  ((:file "package")
   (:file "utils" :depends-on ("package"))
   (:file "ops" :depends-on ("package"))
   (:file "alist" :depends-on ("ops" "utils"))
   (:file "exp" :depends-on ("ops"))
   (:file "vector" :depends-on ("ops" "utils"))
   (:file "ctmc" :depends-on ("alist")))
  :depends-on ("cl-utils"))