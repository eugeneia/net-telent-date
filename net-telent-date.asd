;;; System definition for NET.TELENT.DATE.

(defsystem net-telent-date
    :version "0.43"
    :components ((:file "defpackage")
		 (:file "date" :depends-on ("defpackage"))
		 (:file "parse-time" :depends-on ("defpackage"))))
