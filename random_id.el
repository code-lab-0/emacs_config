(defun insert-date ()
  "Insert current date yyyy-mm-dd."
  (interactive)
  (when (region-active-p)
    (delete-region (region-beginning) (region-end) )
    )
  (format-time-string "%Y-%m-%d"))


;; by Christopher Wellons. 2011-11-18. Editted by Xah Lee.
(defun insert-random-id ()
  "Insert a UUID. This uses a simple hashing of variable data."
  (interactive)
  (let ((myStr (md5 (format "%s%s%s%s%s%s%s%s%s%s"
                        (user-uid)
                        (emacs-pid)
                        (system-name)
                        (user-full-name)
                        (current-time)
                        (emacs-uptime)
                        (garbage-collect)
                        (buffer-string)
                        (random)
                        (recent-keys)))))
    
    (insert (format "%s-a%s-%s"
					(insert-date)
                    ;(substring myStr 0 8)
                    ;(substring myStr 8 12)
                    ;(substring myStr 13 16)
                    (substring myStr 17 20)
                    (substring myStr 20 32)))))

