(use-package avy
  :ensure t
  :config
  :bind
  (("M-g f" . 'avy-goto-line)
   ("M-g w" . 'avy-goto-word-or-subword-1)
   ("M-g a" . 'avy-goto-char-timer)
   ("M-g c" . 'avy-goto-char))
  )



(provide 'init-avy)
