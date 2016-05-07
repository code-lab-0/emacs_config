;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Configuration file for Emacs 
;;      Osamu Ogasawara (since 2001/05/24)
;; 
;;--- .emacs ---
;;(setq load-path
;;      (append (list nil "/home/oogasawa/dot-files")
;;              load-path))
;;(load "oga.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;=================================================
;;;
;;; Common settings on the emacs screen.
;;;
;;;=================================================

;;; common settings.

;;(setq visible-bell t)       ;; Enable Visual Bell (disable beep sound)
(setq-default tab-width 4)
(column-number-mode t)


(if (display-graphic-p)
	(progn
	  ;;(menu-bar-mode 0) ;; hide menu bar
	  (tool-bar-mode 0) ;; hide tool bar
	  ))

(require 'sr-speedbar)

;; color-theme.el
;; apt-get install emacs-goodies-el

;;(require 'color-theme)
;;(color-theme-initialize)

;;(if (display-graphic-p)
(load-theme 'tango)
;;  (load-theme 'color-theme-aalto-light))
;;(color-theme-blue-mood)
;;

;;;=================================================
;;;
;;; System specific settings on the screen.
;;;
;;;=================================================


;; (defvar os-type nil)

;; (cond ((string-match "apple-darwin" system-configuration) ;; Mac
;;        (setq os-type 'mac))
;;       ((string-match "linux" system-configuration)        ;; Linux
;;        (setq os-type 'linux))
;;       ((string-match "freebsd" system-configuration)      ;; FreeBSD
;;        (setq os-type 'bsd))
;;       ((string-match "mingw" system-configuration)        ;; Windows
;;        (setq os-type 'win)))

;; (defun mac? ()
;;   (eq os-type 'mac))

;; (defun linux? ()
;;   (eq os-type 'linux))

;; (defun bsd? ()
;;   (eq os-type 'freebsd))

;; (defun win? ()
;;   (eq os-type 'win))

;; (if mac?
;; 	(define-key global-map [?¥] [?\\]))  ;; \の代わりにバックスラッシュを入力する

;;; ---

 ;; (if (linux?)
 ;; 	 (progn
 ;; 	   (if (display-graphic-p)
 ;; 		   (color-theme-dark-blue2)
 ;; 		 (color-theme-gray30))
 ;; 	   (set-face-attribute 'default nil :height 100)

 ;;   ))


;; (if (mac?)
;; 	(progn
;; 	 ;; Mac用フォント設定
;; 	 ;; http://tcnksm.sakura.ne.jp/blog/2012/04/02/emacs/

;; 	 ;; 英語
;; 	 (set-face-attribute 'default nil
;; 						 :family "Menlo" ;; font
;; 						 :height 120)    ;; font size

;; 	 ;; 日本語
;; 	 (set-fontset-font
;; 	  nil 'japanese-jisx0208
;; 	  ;; (font-spec :family "Hiragino Mincho Pro")) ;; font
;; 	  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font
	 
;; 	 ;; 半角と全角の比を1:2にしたければ
;; 	 (setq face-font-rescale-alist
;; 		   ;;        '((".*Hiragino_Mincho_pro.*" . 1.2)))
;; 		   '((".*Hiragino_Kaku_Gothic_ProN.*" . 1.2)));; Mac用フォント設定
;; 	 ))



;;;=================================================
;;;
;;; ee : emacs expect
;;;
;;;=================================================

(require 'emacs-expect)
(require 'emacs-expect-util)

(require 'tramp)

;;; emacs bash completion
;;; https://github.com/szermatt/emacs-bash-completion
(require 'bash-completion)
(bash-completion-setup)


;;;=================================================
;;; Browse-kill-ring.el
;;;=================================================
;;;(require 'browse-kill-ring)
;;;(global-set-key (kbd "M-C-y") 'browse-kill-ring)


;;;=================================================
;;; Searching google from Emacs
;;; 
;;; http://www.emacswiki.org/emacs/BrowseUrl
;;;=================================================
(defun google (start end)
  (interactive "r")
  (let ((q (buffer-substring-no-properties start end)))
    (browse-url (concat "http://www.google.com/search?q="
			(url-hexify-string q)))))

(defun dictionary-com (start end)
  (interactive "r")
  (let ((q (buffer-substring-no-properties start end)))
    (browse-url (concat "http://dictionary.reference.com/browse/"
			(url-hexify-string q)))))

(defun weblio (start end)
  (interactive "r")
  (let ((q (buffer-substring-no-properties start end)))
    (browse-url (concat "http://ejje.weblio.jp/content/"
			(url-hexify-string q)))))

;;;=================================================
;;; goto-file in Emacs
;;; 
;;; http://stackoverflow.com/questions/259354/goto-file-in-emacs 
;;;=================================================

;;(ffap-bindings)


;;(load "random_id.el")


;;;=================================================
;;; aspell
;;;=================================================

;; コマンドの設定
(setq ispell-program-name "aspell")	; ispell の代わりに aspell を使う
;;(setq ispell-grep-command "grep")	; デフォルトの egrep が Cygwin ではシンボリックリンク
;;
					; なので、Meadow から起動できない
;; 日本語ファイル中の英単語スペルチェックを可能にする
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]")))

;;;=================================================
;;; Buffer Switcher
;;;=================================================
(global-set-key [(f7)]   'previous-buffer)
(global-set-key [(f8)]  'next-buffer)



;;;=================================================
;;; clojure-mode.el
;;;=================================================
;(require 'clojure-mode)
;(setq lisp-indent-offset 2)
;(defun turn-on-paredit () (paredit-mode 1))
;(add-hook 'clojure-mode-hook 'turn-on-paredit)





;;;=================================================
;;; dired
;;;=================================================
(require 'dired)
;; ファイルなら別バッファで、ディレクトリなら同じバッファで開く
(defun dired-open-in-accordance-with-situation ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (file-directory-p file)
        (dired-find-alternate-file)
      (dired-find-file))))

;; dired-find-alternate-file の有効化
(put 'dired-find-alternate-file 'disabled nil)
;; RET 標準の dired-find-file では dired バッファが複数作られるので
;; dired-find-alternate-file を代わりに使う
(define-key dired-mode-map (kbd "RET") 'dired-open-in-accordance-with-situation)
(define-key dired-mode-map (kbd "a") 'dired-find-file)

;; ディレクトリの移動キーを追加(wdired 中は無効)
(define-key dired-mode-map (kbd "<left>") 'dired-up-directory)
(define-key dired-mode-map (kbd "<right>") 'dired-open-in-accordance-with-situation)


;;;=================================================
;;; ess (Emacs Speak Statistics)
;;;=================================================
;(require 'ess-site)



;=================================================
; iimage-mode (inline image minor mode)
;=================================================
; Support image file name as follows. 
; You can be customized via ''iimage-mode-image-regex-alist''.
;
; file://foo.png
; `file://foo.png'
; [[foo.gif]]
; <foo.gif>
; `foo.JPG'

;; ;(auto-image-file-mode t)
;; ;(autoload 'iimage-mode "iimage" "SUpport Inline image minor mode." t)



;;;=================================================
;;; markdown mode
;;;=================================================
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;;;=================================================
;;; Outline mode
;;;=================================================

;; = section = A
;; body of the section a
;; == subsection == B
;; body of the subsection b
;; === subsubheading === C
;; body of the subsubsection c
 
 
;; `C-c C-q' ([A]) : hide-sublevels
;; Hide everything except the top N levels of heading lines
;; (`hide-sublevels').
 
 
;; `C-c C-i' ([AB]) : show-children
;; Make immediate subheadings (one level down) of the current heading
;; line visible (`show-children').
 
 
;; `C-c C-e' : show-entry
;; Make the current heading line's body visible (`show-entry').
 
 
;; `C-c C-k' : show-branches
;; Make all subheadings of the current heading line, at all levels,
;; visible (`show-branches').
 
;; `C-c C-a' : show-all
;; Make all lines in the buffer visible (`show-all').
 
 
;; `C-c C-c' [ABbCc] : hide-entry
;; Make the current heading line's body invisible (`hide-entry').
 
;;------------------------------------------------------------------------
 
;; `C-c C-s' : show-subtree
;; Make everything under the current heading visible, including body,
;; subheadings, and their bodies (`show-subtree').
 
 
;; `C-c C-d' [A] : hide-subtree
;; Make everything under the current heading invisible, not including
;; the heading itself (`hide-subtree').
 
 
;; `C-c C-o' ([Aa]) : hide-other
;; Hide everything except for the heading or body that point is in,
;; plus the headings leading up from there to the top level of the
;; outline (`hide-other').
;; `C-c C-l' [ABC] : hide-leaves
;; Make the body of the current heading line, and of all its
;; subheadings, invisible (`hide-leaves').
 
 
;; `C-c C-t' ([ABC]) : hide-body
;; Make all body lines in the buffer invisible (`hide-body').
 
 
 
;; (require 'outline)
;; ;(setq outline-regexp "#+ ")
;; (setq outline-regexp "[ \t]*# \\|[ \t]+\\(class\\|def\\) ")
;; (setq auto-mode-alist
;; 	  (cons (cons "\\.page$" 'outline-mode) auto-mode-alist))
 

;;;=================================================
;;; Outline minor mode
;;;=================================================


;; ; Outline-minor-mode key map
;;  (define-prefix-command 'cm-map nil "Outline-")
;;  ; HIDE
;;  (define-key cm-map "C-q" 'hide-sublevels)    ; Hide everything but the top-level headings
;;  (define-key cm-map "C-t" 'hide-body)         ; Hide everything but headings (all body lines)
;;  (define-key cm-map "C-o" 'hide-other)        ; Hide other branches
;;  (define-key cm-map "C-c" 'hide-entry)        ; Hide this entry's body
;;  (define-key cm-map "C-l" 'hide-leaves)       ; Hide body lines in this entry and sub-entries
;;  (define-key cm-map "C-d" 'hide-subtree)      ; Hide everything in this entry and sub-entries
;;  ; SHOW
;;  (define-key cm-map "C-a" 'show-all)          ; Show (expand) everything
;;  (define-key cm-map "C-e" 'show-entry)        ; Show this heading's body
;;  (define-key cm-map "C-i" 'show-children)     ; Show this heading's immediate child sub-headings
;;  (define-key cm-map "C-k" 'show-branches)     ; Show all sub-headings under this heading
;;  (define-key cm-map "C-s" 'show-subtree)      ; Show (expand) everything in this heading & below
;;  ;; ; MOVE
;;  ;; (define-key cm-map "u" 'outline-up-heading)                ; Up
;;  ;; (define-key cm-map "n" 'outline-next-visible-heading)      ; Next
;;  ;; (define-key cm-map "p" 'outline-previous-visible-heading)  ; Previous
;;  ;; (define-key cm-map "f" 'outline-forward-same-level)        ; Forward - same level
;;  ;; (define-key cm-map "b" 'outline-backward-same-level)       ; Backward - same level
;;  (global-set-key "\C-c" cm-map)

;; (setq outline-regexp "#+ ")
;; ;; (setq outline-regexp "[ \t]*# \\|[ \t]+\\(class\\|def\\) ")
;; ;;(setq outline-regexp "[ \t]+\\(class\\|def\\) ")

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
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)


;;;=================================================
;;; python-magic
;;; http://stackoverflow.com/questions/4079648/combine-python-mode-with-org-mode-for-emacs/4093889#4093889
;;;=================================================
;(require 'python-magic)




;;;=================================================
;;; scala mode
;;;=================================================
;;(require 'scala-mode)

;;;=================================================
;;; toggle-truncate-line
;;;=================================================
(defun toggle-truncate-lines()
  "toggle truncate lines"
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))

(global-set-key "\C-c\C-l" 'toggle-truncate-lines)


;;;=================================================
;;; Yet Another Snippet mode
;;;=================================================


;; ;; yasnippetを置いているフォルダにパスを通す
;; (add-to-list 'load-path
;;              (expand-file-name "~/.emacs.d/emacs_config/yasnippet"))

;; ;;自分用のスニペットフォルダと，拾ってきたスニペットフォルダの2つを作っておきます．
;; ;;(一つにまとめてもいいけど)
;; (require 'yasnippet)
;; (setq yas-snippet-dirs
;;       '(
;; 		"~/.emacs.d/emacs_config/yasnippet/snippets"
;;         ))

;; ;; yas起動
;; (yas-global-mode 1)

;; ;; 既存スニペットを挿入する
;; (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; ;; 新規スニペットを作成するバッファを用意する
;; (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; ;; 既存スニペットを閲覧・編集する
;; (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map (kbd "<home>") 'yas-expand)

