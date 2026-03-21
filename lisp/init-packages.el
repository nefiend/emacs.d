(require 'package)
;;(setq package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
;;			 ("melpa" . "http://elpa.zilongshanren.com/melpa/")))
(setq package-archives '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")))
(package-initialize)

;; 取消gpg的签名检查
(setq package-check-signature nil)

;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))

;; (package-install 'use-package)

;; Setup `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; 默认use-package设置ensure:t
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; 重启emacs
(use-package restart-emacs
  :ensure t
  :config
  (defun nefiend/restart-emacs-debug-init ()
    (interactive)
    (restart-emacs (list "--debug-init")))  ;;  --debug-init
  )


(provide 'init-packages)
