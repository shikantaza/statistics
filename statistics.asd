;;;; statistics.asd

(asdf:defsystem #:statistics
  :serial t
  :depends-on (#:utils
               #:matrix)
  :components ((:file "package")
               (:file "statistics")))

