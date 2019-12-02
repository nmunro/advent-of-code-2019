(defsystem "advent"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "advent/tests"))))

(defsystem "advent/tests"
  :author ""
  :license ""
  :depends-on ("advent"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for advent"

  :perform (test-op (op c) (symbol-call :rove :run c)))
