;;;; -*- Mode: LISP -*-

(in-package :asdf)

(defsystem :cl-probability
  :components
  ((:file "package")
   (:file "ops" :depends-on ("package"))
   (:file "alist" :depends-on ("ops"))
   (:file "exp" :depends-on ("ops"))
   (:file "ctmc" :depends-on ("alist")))
  :depends-on ("cl-utils"))