; -*- mode: Lisp -*-

(mapc 'require
      '(sb-bsd-sockets
        sb-posix
        sb-introspect
        sb-cltl2
        asdf
        asdf-install))

(defvar *lisp-packages-directory*
  (merge-pathnames "lisp/sbcl/" (user-homedir-pathname)))

(push (list (merge-pathnames "site/" *lisp-packages-directory*)
            (merge-pathnames "systems/" *lisp-packages-directory*)
            "Local Installs")
      asdf-install:*locations*)

(push (merge-pathnames "systems/" *lisp-packages-directory*)
      asdf:*central-registry*)

(defmacro load-or-install (package)
  `(handler-case
       (progn
         (asdf:operate 'asdf:load-op ,package))
     (asdf:missing-component ()
       (asdf-install:install ,package))))

(load-or-install :cl-ppcre)
(load-or-install :md5)
(load-or-install :trivial-gray-streams)
(load-or-install :flexi-streams)
(load-or-install :url-rewrite)
(load-or-install :rfc2388)
(load-or-install :cl-base64)
(load-or-install :chunga)
(push  :hunchentoot-no-ssl *features*)
(load-or-install :hunchentoot)
(load-or-install :cl-who)

;(load (merge-pathnames
;       "lisp/slime/swank-loader" (user-homedir-pathname)))

;(dolist (module '("swank-arglists"
;                  "swank-asdf"
;                  "swank-c-p-c"
;                  "swank-fancy-inspector"
;                  "swank-fuzzy"
;                  "swank-presentation-streams"
;                  "swank-presentations"))
;  (load (merge-pathnames
;         (merge-pathnames "lisp/slime/contrib/"
;                          module)
;         (user-homedir-pathname))))

(sb-ext:save-lisp-and-die (merge-pathnames ".sbcl.core-with-slime" (user-homedir-pathname)))
