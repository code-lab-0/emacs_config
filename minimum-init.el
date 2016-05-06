(setq load-path
       (append 
		(list nil 
			  "/Users/oogasawa/.emacs.d/emacs_config/"
			  ) load-path))

;;(load "oga.el")

;;;=================================================
;;; package.el
;;; http://emacs-jp.github.io/packages/package-management/package-el.html
;;; M-x package-list-packages
;;;=================================================
(require 'package)
(add-to-list 'package-archives
			 '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

