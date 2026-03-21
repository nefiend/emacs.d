
;; evil-tutor
;; M-x package-install evil-tutor
;; M-x evil-tutor-start

(use-package evil
  :ensure t
  :defer t
  :init
  ;; 设置不加载evil-keybindings.el
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (evil-mode)
  ;;设置在insert模式下，可以使用emacs的快捷键
  (setcdr evil-insert-state-map nil)
  ;;设置Ctrl-[为esc键
  (define-key evil-insert-state-map [escape] 'evil-normal-state)

  (define-key evil-normal-state-map (kbd "[ SPC") (lambda () (interactive) (evil-insert-newline-above) (forward-line)))
  (define-key evil-normal-state-map (kbd "] SPC") (lambda () (interactive) (evil-insert-newline-below) (forward-line -1)))
  (define-key evil-normal-state-map (kbd "[ b") 'previous-buffer)
  (define-key evil-normal-state-map (kbd "] b") 'next-buffer)
  (define-key evil-motion-state-map (kbd "[ b") 'previous-buffer)
  (define-key evil-motion-state-map (kbd "] b") 'next-buffer)

  (evil-define-key 'normal dired-mode-map
    (kbd "<RET>") 'dired-find-alternate-file
    (kbd "C-k") 'dired-up-directory
    "`" 'dired-open-term
    "o" 'dired-find-file-other-window
    "s" 'hydra-dired-quick-sort/body
    "z" 'dired-get-size
    "!" 'zilongshanren/do-shell-and-copy-to-kill-ring
    ")" 'dired-omit-mode)

  (evil-define-key 'normal 'global (kbd "C-<mouse-1>") 'evil-jump-to-tag)

  ;; https://emacs.stackexchange.com/questions/46371/how-can-i-get-ret-to-follow-org-mode-links-when-using-evil-mode
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd "RET") nil))
  (evil-set-initial-state 'dired-mode 'emacs) ;; 在 dired 模式下启动 emcas 模式
  )

(use-package evil-anzu
  :ensure t
  :after evil
  :diminish
  :demand t
  :init
  (global-anzu-mode t))

(use-package evil-collection
  :ensure t
  :demand t
  :config
  (setq evil-collection-mode-list (remove 'lispy evil-collection-mode-list))
  (evil-collection-init)

  (cl-loop for (mode . state) in
           '((org-agenda-mode . normal)
             (Custom-mode . emacs)
             (eshell-mode . emacs)
             (makey-key-mode . motion))
           do (evil-set-initial-state mode state)))

;; {{ evil-surround 参考 vi-surround,以结构化的文本进行操作，快速、便捷
;; 参考 https://github.com/emacs-evil/evil-surround/tree/master?tab=readme-ov-file#examples
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
  (setq-default evil-surround-pairs-alist
		(push '(?\; .(";; {{" . ";;  }}")) evil-surround-pairs-alist)))
;;}}
;; evil 注释
(use-package evil-nerd-commenter
  :init
  (define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  )

(use-package undo-tree
  :diminish
  :init
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history nil)
  (evil-set-undo-system 'undo-tree))

;; 设置连续kj作为escape键
(use-package evil-escape
  :ensure t
  :init
  ;; {{ https://github.com/syl20bnr/evil-escape
  (setq-default evil-escape-delay 0.1)
  (setq-default evil-escape-key-sequence "kj")
  (setq evil-escape-excluded-major-modes '(dired-mode))  ;; 设置 dired-mode 禁止使用
  ;; disable evil-escape when input method is on
  (add-to-list 'evil-escape-excluded-major-modes 'treemacs-mode) ;; 禁止在 treemacs 中使用 evil-escape
  (add-to-list 'evil-escape-excluded-major-modes 'magit-status-mode) ;; 禁止在 magit-status 中使用 evil-escape
  (evil-escape-mode 1))
  ;; }}

(use-package evil-matchit
  :init
  (setq evilmi-may-jump-by-percentage nil)
  (setq evilmi-shortcut (kbd "M-m"))
  (global-evil-matchit-mode 1)
  )

;; `paredit-mode' is a requirement
(use-package paredit
  :ensure t
  :commands paredit-mode
  :hook
  (emacs-lisp-mode . paredit-mode))

(use-package enhanced-evil-paredit
  :ensure t
  :commands enhanced-evil-paredit-mode
  :hook (paredit-mode . enhanced-evil-paredit-mode))


(provide 'init-evil)
