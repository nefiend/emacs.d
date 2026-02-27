
(use-package evil
  :ensure t
  :defer t
  :init
  ;; 设置不加载evil-keybindings.el
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)   
  (evil-mode 1)
  ;; 设置在insert模式下，可以使用emacs的快捷键
  (setcdr evil-insert-state-map nil)


  )



(use-package evil-escape
  :ensure t
  :init
  (setq-default evil-escape-delay 0.1)
  (setq-default evil-escape-key-sequence "kj")
  (evil-escape-mode))



(provide 'init-evil)
