(defparameter *puzzle-input* (uiop:read-file-line "data/day2.txt"))

(defun run (program &optional (stack-pointer 0))
  (cond
    ((= 99 (nth stack-pointer program)) program) ; return the state of program when halting
    ((= 1  (nth stack-pointer program)) (run (move #'+ program stack-pointer) (+ stack-pointer 4)))
    ((= 2  (nth stack-pointer program)) (run (move #'* program stack-pointer) (+ stack-pointer 4)))
    (T (format nil "~A program error" (nth stack-pointer program))))) ; If it's anything else it must be an operator.

(defun move (f program stack-pointer)
  (let ((operand1 (nth (nth (+ 1 stack-pointer) program) program))
        (operand2 (nth (nth (+ 2 stack-pointer) program) program))
        (operand3 (nth (+ 3 stack-pointer) program)))
    (setf (nth operand3 program) (funcall f operand1 operand2))
    program))

(defun format-program (stream &key (noun 0 noun-p) (verb 0 verb-p))
  (let ((program (mapcar #'parse-integer (uiop:split-string stream :separator ","))))
    ; Add in the noun, if present
    (if noun-p
        (setf (nth 1 program) noun))

    ; Add in the verb, if present
    (if verb-p
        (setf (nth 2 program) verb))

    (run program)))

;; Part 2
(defun find-nums (input &optional (a 0) (b 0))
  (cond
    ((= 19690720 (first (format-program input :noun a :verb b))) (+ (* 100 a) b))
    ((= 100 a b) nil)
    ((= 100 b) (find-nums input (1+ a) 0))
    (T (find-nums input a (1+ b)))))

;; Tests
(format t "~A~%" (equal '(3 5 6 0 99 5 -2) (format-program "1,5,6,0,99,5,-2")))
(format t "~A~%" (equal '(2 0 0 0 99) (format-program "1,0,0,0,99")))
(format t "~A~%" (equal '(2 3 0 6 99) (format-program "2,3,0,3,99")))
(format t "~A~%" (equal '(2 4 4 5 99 9801) (format-program "2,4,4,5,99,0")))
(format t "~A~%" (equal '(30 1 1 4 2 5 6 0 99) (format-program "1,1,1,4,99,5,6,0,99")))
(format t "~A~%" (equal '(30 1 1 4 2 5 6 0 99) (format-program "1,1,1,4,99,5,6,0,99")))
(format t "~A~%" (equal '(3500 9 10 70 2 3 11 0 99 30 40 50) (format-program "1,9,10,3,2,3,11,0,99,30,40,50")))

;; Part 2
(format t "~A~%" (find-nums *puzzle-input*))

