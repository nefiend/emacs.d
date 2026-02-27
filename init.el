;; -*- coding: utf-8; lexical-binding: t; -*-

(add-to-list 'load-path "~/.emacs.d/lisp/")


(setq package-archives
      '(
        ;;("gnu" . "https://elpa.gnu.org/packages/")
        ;;("melpa" . "https://melpa.org/packages/")
        ;;("melpa-stable" . "https://stable.melpa.org/packages/")

        ;; Use either 163 or tsinghua mirror repository when official melpa
        ;; is slow or shutdown.

        ;; ;; {{ Option 1: 163 mirror repository:
        ;; ("gnu" . "https://mirrors.163.com/elpa/gnu/")
        ;; ("melpa" . "https://mirrors.163.com/elpa/melpa/")
        ;; ("melpa-stable" . "https://mirrors.163.com/elpa/stable-melpa/")
        ;; ;; }}

        ;; ;; {{ Option 2: tsinghua mirror repository
        ;; ;; @see https://mirror.tuna.tsinghua.edu.cn/help/elpa/ on usage:
        ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")
        ;; }}
        ))

;; stop creating those #auto-save# files
(setq auto-save-default nil)

(require 'init-basic)
(require 'init-ui)
(require 'init-evil)
(require 'init-pyim)
(require 'init-avy)
(require 'init-completion)

(require 'init-magit)




(use-package desktop
  :ensure t
  :config
  ;; 启用桌面保存模式
  (desktop-save-mode 1)

  ;; 设置桌面文件路径
  (setq desktop-path '("~/.emacs.d/desktops/"))
  (setq desktop-dirname "~/.emacs.d/desktops/")
  (setq desktop-base-file-name "emacs-desktop")
  
  ;; 自动保存设置
  (setq desktop-auto-save-timeout 30)  ; 30秒无操作自动保存
  (setq desktop-save t)                ; 退出时自动保存
  (setq desktop-load-locked-desktop t) ; 允许加载被锁定的桌面
  )



(use-package restart-emacs
  :ensure t)

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package keycast
  :ensure t
  :init
  (keycast-mode-line-mode t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(avy corfu embark-consult evil-anzu evil-escape evil-matchit
	 evil-nerd-commenter evil-surround keycast magit marginalia
	 orderless posframe pyim pyim-basedict restart-emacs vertico
	 winum)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
