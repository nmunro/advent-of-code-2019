(defpackage advent
  (:use :cl))
(in-package :advent)

;; Advent day 1
(defparameter *fuel* #p"fuel.txt")

(defun total-initial-fuel-by-module ()
  (let ((initial-data (mapcar #'(lambda (line) (parse-integer line)) (uiop:read-file-lines *fuel*))))
    (mapcar #'(lambda (num) (- (floor num 3) 2)) initial-data)))

(defun sum-fuels (fuels)
  (reduce #'+ fuels))

(defun calculate-fuel-for-fuel (fuel &optional (fuels '()))
  (let ((fuels (cons fuel fuels)))
    (if (<= 0 fuel)
        (calculate-fuel-for-fuel (- (floor fuel 3) 2) fuels)
        (reverse (remove-if #'(lambda (fuel) (> 0 fuel)) fuels)))))

(defun total-fuels ()
  (let* ((all-initial-fuels (total-initial-fuel-by-module))
         (new-fuels (mapcar #'calculate-fuel-for-fuel all-initial-fuels)))
    (mapcar #'sum-fuels new-fuels)))

(defun total-fuel (fuels)
  (reduce '+ fuels))

(format t "~A~%" (total-fuel (total-fuels)))

;; Advent day 2
