;;在文件最开头添加地个;;在文件最开头添加地个 文件作用域的变量设置，设置变量的绑定方式
;; -*- lexical-binding: t -*-
;;; code:

;; {{ 使用 benchmark-init 进行启动时间分析
(use-package benchmark-init
  :ensure t
  :init
  (benchmark-init/activate)
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))
;; 调用函数 benchmark-init/show-durations-tree 和 benchmark-init/show-durations-tabulated 以树或表格方式显示结果
;; }}

(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'init-packages)

(require 'init-basic)

(require 'init-evil)

(require 'init-ui)

(require 'init-tab)

(require 'init-funcs)

(require 'init-keybindings)

(require 'init-keyfreq)

;;(require 'init-company)

(require 'init-completion)

(require 'init-windows)

(require 'init-treemacs)

;;(require 'init-ivy)

(require 'init-avy)

(require 'init-tools)
(require 'init-movetext)
(require 'init-translate)

(require 'init-programming)

(require 'init-git)

(require 'init-org)

(require 'init-md)

(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
