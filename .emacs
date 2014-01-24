(setq
 ;; move #blah# files to a folder
 backup-directory-alist '(("." . "~/.emacs.d/saves"))
 ;; don't show annoing startup msg
 inhibit-startup-message t
 ;; follow symlinks and don't ask
 vc-follow-symlinks t)

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  ;; for when gnu is being slow, just use setq instead of adding
					; (setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")))
  )

					;(load "~/.emacs.d/.ercrc.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/.org-mode/work.org")))
 '(tramp-remote-path (quote (tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin")))
 '(tramp-verbose 6))

;; gnus
(setq
 user-mail-address "mbasnight@gmail.com"
 user-full-name "Michael Basnight"
 gnus-select-method '(nntp "news.gwene.org"))

;; Flymake + flake8
(require 'flymake)
(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))

(add-hook 'post-command-hook 'my-flymake-show-help)

					; This runs flake8 via flymake. you must have flake8 installed
					; via pip or whatever
(when (load "flymake" t) 
  (defun flymake-pyflakes-init () 
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 
		       'flymake-create-temp-inplace)) 
	   (local-file (file-relative-name 
			temp-file 
			(file-name-directory buffer-file-name)))) 
      (list "flake8" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks 
	       '("\\.py\\'" flymake-pyflakes-init)))
;; This is not working in tramp mode!
;;(add-hook 'find-file-hook 'flymake-find-file-hook)

(require 'tramp)
(setq tramp-default-method "ssh")

(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

; fix tramp up so it can talk to remote servers. be sure
; that the remote machine is configured so that if TERM
; comes in as dumb to set PS1="$".
; http://stackoverflow.com/questions/6954479/emacs-tramp-doesnt-work
(setq tramp-terminal-type "dumb")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
