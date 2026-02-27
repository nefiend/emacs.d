;; 更改光标的样式
(setq-default cursor-type 'bar)

;; 设置括号配对高亮
(show-paren-mode t)

(use-package winum
  :ensure t
  :init
  (setq winum-keymap
	(let ((map (make-sparse-keymap)))
	  (define-key map (kbd "M-0") 'winum-select-window-0-or-10)
	  (define-key map (kbd "M-1") 'winum-select-window-1)
	  (define-key map (kbd "M-2") 'winum-select-window-2)
	  (define-key map (kbd "M-3") 'winum-select-window-3)
	  (define-key map (kbd "M-4") 'winum-select-window-4)
	  (define-key map (kbd "M-5") 'winum-select-window-5)
	  (define-key map (kbd "M-6") 'winum-select-window-6)
	  (define-key map (kbd "M-7") 'winum-select-window-7)
	  (define-key map (kbd "M-8") 'winum-select-window-8)
	  (define-key map (kbd "M-9") 'winum-select-window-9)
	  map))
  :config
  (winum-mode))

(provide 'init-ui)
