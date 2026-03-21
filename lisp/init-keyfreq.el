(use-package keyfreq
  :ensure t
  :init
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1)
  (setq keyfreq-excluded-commands
	'(self-insert-command
	  forward-char
	  backward-char
	  previous-line
	  next-line
	  evil-next-line
	  evil-previous-line
	  evil-forward-char
	  evil-backward-char
	  mwheel-scroll
	  vertico-next
	  vertico-previous
	  org-self-insert-command
	  ;; treemacs-next-line
	  ;; treemacs-previous-line
	  )))

(provide 'init-keyfreq)
