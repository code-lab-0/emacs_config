
;;(set-frame-parameter (selected-frame) 'alpha '(90 90))
;;(add-to-list 'default-frame-alist '(alpha 90 90))

(getenv "HOME")

(setq load-path
       (append 
		(list nil 
			  (concat (getenv "HOME") "/.emacs.d/emacs_config/")
			  (concat (getenv "HOME") "/.emacs.d/emacs-expect/")
			  ;;(concat (getenv "HOME") "/elpa/color-theme-6.6.1/")
			  (concat (getenv "HOME") "/.emacs.d/elpa/deferred-20160109.2046/")
			  (concat (getenv "HOME") "/.emacs.d/elpa/dash-20160306.1222/")
			  (concat (getenv "HOME") "/.emacs.d/elpa/pcre2el-20151213.234/")
			  ) load-path))

(load "oga.el")


;; 英語
 (set-face-attribute 'default nil
             :family "Menlo" ;; font
             :height 120)    ;; font size

;; 日本語
(set-fontset-font
 nil 'japanese-jisx0208
;; (font-spec :family "Hiragino Mincho Pro")) ;; font
  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; 半角と全角の比を1:2にしたければ
(setq face-font-rescale-alist
;;        '((".*Hiragino_Mincho_pro.*" . 1.2)))
      '((".*Hiragino_Kaku_Gothic_ProN.*" . 1.2)));; Mac用フォント設定

(when (eq window-system 'ns)

  (let ((my-font-height 120)

        (my-font (cond

                  (t   "Monaco")  ;; XCode 3.1 で使っているフォント

                  (nil "Menlo")   ;; XCode 3.2 で使ってるフォント

                  ))

        (my-font-ja "Hiragino Maru Gothic Pro"))

    (setq mac-allow-anti-aliasing t)

  

    ;; フォントサイズの微調節 (12ptで合うように)

    (setq face-font-rescale-alist

          '(("^-apple-hiragino.*" . 1.2)

            (".*osaka-bold.*" . 1.2)

            (".*osaka-medium.*" . 1.2)

            (".*courier-bold-.*-mac-roman" . 1.0)

            (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)

            (".*monaco-bold-.*-mac-roman" . 0.9)

            ("-cdac$" . 1.3)))

    

    ;; デフォルトフォント設定

    (when my-font

      (set-face-attribute 'default nil :family my-font :height my-font-height)

      ;;(set-frame-font (format "%s-%d" my-font (/ my-font-height 10)))

      )

    

    ;; 日本語文字に別のフォントを指定

    (when my-font-ja

      (let ((fn (frame-parameter nil 'font))

            (rg "iso10646-1"))

        (set-fontset-font fn 'katakana-jisx0201 `(,my-font-ja . ,rg))

        (set-fontset-font fn 'japanese-jisx0208 `(,my-font-ja . ,rg))

        (set-fontset-font fn 'japanese-jisx0212 `(,my-font-ja . ,rg))))))


;;------------------------------------------------------------

;; Emacs23 on Mac OS X で '￥'キーで '\' を入力する

;;------------------------------------------------------------

(when (eq (window-system) 'ns)

  (progn

    (define-key global-map [?¥] [?\\])

    (define-key global-map [?\C-¥] [?\C-\\])

    (define-key global-map [?\M-¥] [?\M-\\])

    (define-key global-map [?\C-\M-¥] [?\C-\M-\\])))
