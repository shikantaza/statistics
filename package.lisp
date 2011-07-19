;;;; package.lisp

(defpackage #:statistics
  (:use #:cl #:matrix #:utils)
  (:export "DISTANCE"
	   "AVERAGE"
	   "CLASSIFY-KNN"
	   "CLASSIFY-KNN-AVG"
	   "GLM"))

