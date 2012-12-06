;;; scrapbook.el

(defun create-random-ip-addr ()
  "Creates a random IPv4 address string."
  (concat (number-to-string (+ 1 (random 253)))
	  "." (number-to-string (random 254))
	  "." (number-to-string (random 254))
	  "." (number-to-string (random 254))))

(defun char-at (str i)
  (substring str i (+ 1 i)))

(defun char-at (str i)
  (string (elt str i)))

(defun char-at (str i)
  (string (aref str i)))

(char-at 2 "martin")

(defun create-random-string (len chars)
  (let ((chars-len (string-width chars)))
    ;;careful 'from 1 to len' or 'from 0 to (- len 1)'
    (loop for x from 1 to len concat
	  (char-at chars (random chars-len)))
    ))

(defun create-random-string (len chars)
  (let ((chars-len (string-width chars))
	(str ""))
    (dotimes (x len str) 
      (setq str (concat str (char-at chars (random chars-len)))))
    ))

;; recursive version - just for fun
(defun create-random-string (len char-table)
  (flet ((f (str len char-table)
	    (let((index (random (string-width char-table))))
	      (if (> len (string-width str))
		  (f (concat str (substring char-table index (+ 1 index))) len char-table)
		str )))) (f "" len char-table)))

(create-random-string 4 "0123456789abcdef")

(defun string-reverse (s)
  (apply #'string (nreverse (string-to-list s))))

(string-reverse "crap")

(defun make-random-host (&optional chars len)
  "Returns a random hostname (string) or an IPv4 address."

  (if (= 0 (random 2))	      ;; throw a dice
      (create-random-ip-addr) ;; 0 = IP address
    (progn		      ;; 1 = hostname
      (if (not chars) (setq chars "_0123456789abcdefghijklmnopqrstuvxywz"))
      (if (not len) (setq len 8))
      (create-random-string len chars))
    ))

;;test
(make-random-host "abcdef" 4)

;;create a generic function for collecting random values

;;
(defun make-unique-random-host ()
  (let ((host (make-random-host)))
    (if (member host hosts-table) 
	(make-unique-random-host))
    (setq hosts-table (cons host hosts-table))
    host))

;;test
(make-unique-random-host)

(defun make-list-of-random-hosts (num-hosts)
  (loop for x from 1 to num-hosts collect (make-unique-random-host)))

(make-list-of-random-hosts 10)

;;
(defun create-list-of-random-ip-addr (len)
  (let((addresses ()))
    (dotimes (x len addresses)
      (setq addresses (cons (create-random-ip-addr) addresses)))
    ))

(create-list-of-random-ip-addr 4)

(message "%04d" 12)

(defvar hosts-table ())

(defun make-unique-host (hosts)
  ""
  (let ((h ""))
    (setq h (make-random-host))
    (if (member h hosts)
	(make-unique-host hosts))
    h))

;; hosts are IPs or hostnames
(defun make-list-of-random-hosts (len)
  (let ((hosts ()))
    (dotimes (x len hosts)
      (setq hosts (cons (make-unique-host hosts) hosts)))
    ))

(make-list-of-random-hosts 3)

(nth 2  (get-internal-run-time))



(set-buffer
 (create-file-buffer (concat "~/test-0x"
			     (create-random-string 16 "0123456789abcdef")
			     ".out")))
;;
(insert "blah")

;;
(print record (get-buffer "test-script.sql"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(loop for x from 1 to 10 collect x)

(loop for x from 1 to 10 if (oddp x) collect x into z)

;;fix later
(defun create-random-string-loop (len char-table)
  (loop for x from 0 to 12 collect (random x)))
  
(defun clamp (val from to)
  (* val (/ (float to) (float from))))

(setq max 320)
(clamp (random max) max 128)

;;use round to get an integer
(round (clamp (random max) max 128))

;; find unique elements, number of unique elements in a list
(setq testseq '(1 2 1 1 2 1 3 3 2 1 4 1 5 6 6 1 1 2 3))

(defun count-unique-elements (seq) 
  (- (length seq) (length (remove-duplicates seq))))

(count-unique-elements testseq)

;; my clumsy version
(defun foo-rec (x s) (let ((c -1)) (if s (setq c (+ 1 (foo-rec x (cdr (member x s)))))) c))

;; ivan's version 1
(defun foo-rec (x l) (reduce #'+ (map 'list (lambda (y) (if (= x y) 1 0)) l)))

;; ivan's version 2
(defun foo-rec (x l) (reduce #'+ (mapcar (lambda (y) (if (= x y) 1 0)) l)))

(foo-rec 1 testseq)

(defun fac (n)
  "Factorial of n."
  (let ((a (loop for x from 1 to n collect x)))
    (apply `* a)))

(defun fac (n)
  "Factorial of n."
  (if (> n 1)
      (* n (fac (- n 1)))
    n))

(fac 11)

;; (fib 10) => (0 1 1 2 3 5 8 13 21 34)
;; n[i+1] = n[i] + n[i-1]

(defun fib (n)
  "Returns a list of Fibonacci series of length n."
  (cond

   ((< n 1) '())

   ((= n 1) '(0))

   ((> n 1)
    (let ((z '(1 0)))
      (flet ((f (x n)
		(if (< (length x) n)
		    (f (cons (+ (nth 0 x) (nth 1 x)) x) n)
		  ;;(f (cons (+ (car x) (car (cdr x))) x) n)
		  x)

		))
	(setq z (f z n)))
      (nreverse z)))
   ))

(fib 10)

(do ((x 1)
     (n 10))        ;; local vars
    ((= x n) )      ;; ((condition) optional-result)
  (message "%d" x)  ;; body of the loop
  (setf x (+ 1 x)))

(defun quote-region (point mark &optional quote-char)
  (interactive "rsQuote char (default '>'):")
  (let ((start-line (line-number-at-pos point))
	(end-line (line-number-at-pos mark)))
    (if (not quote-char)
	(setq quote-char 62))		;62 is '>'
    (save-excursion 
      (goto-line start-line)
      (while (> end-line (line-number-at-pos (point)))
	(if (eq quote-char (char-after (point)))
	    (insert quote-char)
	    (progn
	      (insert quote-char)
	      (insert " ")))
	(forward-line)))))

(defun quote-buffer (&optional quote-char)
  (interactive)
  (if (not quote-char)
      (setq quote-char 62))
  (save-excursion
    (quote-region (point-min) 
 		  (line-number-at-pos (goto-char (point-max))) 
 		  quote-char)))

(quote-buffer)

(defun test-interactive (point mark)
  (interactive "r")
  (message "point: %d, mark: %d" point mark))
