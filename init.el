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

(use-package evil
  :init
  (evil-mode 1))
(use-package evil-escape
  :ensure t
  :init
  (evil-escape-mode))

(use-package vertico
  :ensure t
  :init
  (vertico-mode t))

(use-package corfu
  :ensure t
  :init
  (progn
    (setq corfu-auto t)
    (setq corfu-cycle t)
    (setq corfu-quit-at-boundary t)
    (setq corfu-quit-no-match t)
    (setq corfu-preview-current nil)
    (setq corfu-min-width 80)
    (setq corfu-max-width 100)
    (setq corfu-auto-delay 0.2)
    (setq corfu-auto-prefix 1)
    (setq corfu-on-exact-match nil)
    (global-corfu-mode)
    ))

(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless)))

(use-package consult
  :ensure t)


(use-package embark
  :ensure t
  :init
  :config
  (global-set-key (kbd "C-;") 'embark-act)
  )

(use-package embark-consult
  :ensure t
  )

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

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

(use-package evil
  :init
  (evil-mode 1))
(use-package evil-escape
  :ensure t
  :init
  (evil-escape-mode))

(use-package vertico
  :ensure t
  :init
  (vertico-mode t))

(use-package corfu
  :ensure t
  :init
  (progn
    (setq corfu-auto t)
    (setq corfu-cycle t)
    (setq corfu-quit-at-boundary t)
    (setq corfu-quit-no-match t)
    (setq corfu-preview-current nil)
    (setq corfu-min-width 80)
    (setq corfu-max-width 100)
    (setq corfu-auto-delay 0.2)
    (setq corfu-auto-prefix 1)
    (setq corfu-on-exact-match nil)
    (global-corfu-mode)
    ))

(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless)))

(use-package consult
  :ensure t)


(use-package embark
  :ensure t
  :init
  :config
  (global-set-key (kbd "C-;") 'embark-act)
  )

(use-package embark-consult
  :ensure t
  )

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

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
