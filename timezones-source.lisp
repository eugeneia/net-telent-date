;;;; This is an MPC grammar to parse the timezone.source file. I used
;;;; this to genreate the alist for *ZONE-STRINGS*. It requires MPC to be
;;;; loaded (see http://mr.gy/maintenance/mpc/).

(defpackage net.telent.date.timezones-source
  (:use :cl :mpc :mpc.characters :mpc.numerals)
  (:export :timezones-source-to-alist))

(in-package :net.telent.date.timezones-source)

(defun =abbreviation ()
  (=string-of (=not (=whitespace))))

(defun =junk ()
  (=and (=string-of (=not (=string "UTC")))
        (=string "UTC")))

(defun =offset ()
  (=let* ((sign (=one-of '(#\+ #\-)))
          (hours (=integer-number))
          (minutes (=maybe (=and (=character #\:)
                                 (=integer-number)))))
    (=result (* (if minutes
                    (+ hours (/ minutes 60))
                    hours)
                (if (char= #\- sign)
                    -1
                    1)))))

(defun =definition ()
  (=let* ((abbreviation (=abbreviation))
          (_ (=junk))
          (offset (=offset)))
    (=result (cons (string-downcase abbreviation)
                   (if (integerp offset)
                       offset
                       (float offset))))))

(defun =definitions ()
  (=zero-or-more (=prog1 (=definition)
                         (=or (=character #\Newline)
                              (=end-of-input)))))

(defun timezones-source-to-alist (path)
  "Convert time zone source file at PATH to alist."
  (with-open-file (in path)
    (run (=definitions) in)))
