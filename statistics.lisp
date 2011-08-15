;;;; statistics.lisp

(in-package #:statistics)

;classify a point using the k nearest neighbours algorithm
;'point' is a list of the x,y,z,.. coordinates
;'training set' is a list of tuples. the first of each tuple is
;the point (representing the predictor), and the second value is the
;classification (representing the response)
(defun classify-knn (point training-set k)
  (let ((max-class nil) (max-class-count 0))
    (labels ((set-max-class (key val)
	       (if (> val max-class-count)
		   (progn (setf max-class-count val)
			  (setf max-class key)))))
      (let ((knn (first-n (sort (copy-list training-set) (curry #'compare-training-set point)) k))
            (counts (make-hash-table)))
        (dolist (x knn)
          (let* ((key (second x))
                 (v (gethash key counts)))
            (if (null v) (setf (gethash key counts) 1) (setf (gethash key counts) (1+ v)))))
        (maphash #'set-max-class counts)))
    max-class))

;similar to classify-knn, but use average of the k nearest neighbours' values
(defun classify-knn-avg (point training-set k)
    (average #'second (first-n (sort (copy-list training-set) (curry #'compare-training-set point)) k)))

;linear regression model coefficients: ((X^TX)^-1)X^TY
(defun glm (x y)
  (mult (mult (inv (mult (trans x) x)) 
              (trans x)) 
        y))

(defun average (f lst)
  (let ((sum 0.0))
    (dolist (x lst)
      (incf sum (funcall f x)))
  (/ sum (length lst))))

;distance between two points (any number of dimensions)
(defun distance (p1 p2)
  (labels ((dist-internal (x1 x2)
                          (if (and (null (cdr x1)) (null (cdr x2))) ;i.e. single elements
                              (expt (- (car x1) (car x2)) 2)
                            (+ (expt (- (car x1) (car x2)) 2) (dist-internal (cdr x1) (cdr x2))))))
    (sqrt (dist-internal p1 p2))))

(defun compare-training-set (p d1 d2)
  (< (distance p (first d1)) (distance p (first d2))))

(defun median (lst)
  (let* ((sorted-list (sort (copy-list lst) #'<))
	 (l (length sorted-list))
	 (mid (floor (/ l 2))))
    (if (oddp l)
      (nth mid sorted-list)
      (/ (+ (nth (1- mid) sorted-list) (nth mid sorted-list)) 2.0))))