(defpackage :net.telent.date
  (:nicknames :date)
  (:use #:CL)
  (:export dayname monthname
	   with-date			; deprecated
	   with-decoding		; also deprecated, but more recently
	   decode-universal-time/plist
	   secondp minute hour day year weekday month zone
           universal-time-to-rfc-date
	   universal-time-to-http-date
	   universal-time-to-rfc2822-date parse-time))
   
