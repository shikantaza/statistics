;;;; package.lisp

(defpackage #:statistics
  (:use #:cl #:matrix #:utils)
  (:export "DISTANCE"
	   "AVERAGE"
	   "MEDIAN"
	   "CLASSIFY-KNN"
	   "CLASSIFY-KNN-AVG"
	   "GLM"))

