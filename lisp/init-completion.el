;;; 核心五件套配置 (Vertico/Embark/Corfu/Marginalia/Orderless)
(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom (vertico-cycle t) ; 循环补全
  )

(use-package marginalia
  :ensure t
  :after vertico
  :init (marginalia-mode))

(use-package orderless
  :ensure t
  :custom (completion-styles '(orderless basic))
           (completion-category-overrides '((file (styles partial-completion)))))

(use-package embark
  :ensure t
  :bind (("C-;" . embark-act)       ; 快速操作
         ("M-." . embark-dwim)      ; 智能操作
         ("C-h B" . embark-bindings)) ; 查看绑定
  :init (setq prefix-help-command #'embark-prefix-help-command))

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
    ) 

  :config
  ;; 美化补全面板
  (corfu-popupinfo-mode)
  (setq corfu-popupinfo-delay 0.5))

;;; 增强体验的补充配置
;; 使用 Tab 作为通用补全键
(global-set-key [remap completion-at-point] #'completion-at-point)
(global-set-key [remap complete-symbol] #'completion-at-point)
(global-set-key (kbd "TAB") #'completion-at-point)

;; 文件补全优化 (使用 Vertico + Consult)
(use-package consult
  :ensure t
  :bind (("C-x b" . consult-buffer)
         ("C-x C-r" . consult-recent-file)
         ("C-c h" . consult-history)))
(use-package embark-consult
  :ensure t
  )

;; 模糊查找增强 (可选)
;; (use-package flx
;;   :ensure t
;;   :custom (orderless-matching-styles '(orderless-flx)))

(provide 'init-completion)
