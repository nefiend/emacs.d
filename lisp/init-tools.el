;; 手动安装插件
(add-to-list 'load-path (expand-file-name "~/.emacs.d/awesome-tab/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/sort-tab/"))

;; 设置 sort-tab
;; (require 'sort-tab)
;; (sort-tab-mode 1)
;; (global-set-key (kbd "C-<tab>") 'sort-tab-select-next-tab) ;; 设置 ctrl + tab 切换下一个 tab
;; (global-set-key (kbd "C-<iso-lefttab>") 'sort-tab-select-prev-tab) ;; 设置 ctrl + shift + tab 切换上一个 tab

;; 设置awesome-tab
;; (require 'awesome-tab)
;; (awesome-tab-mode t)

;; (defun awesome-tab-buffer-groups ()
;;   "`awesome-tab-buffer-groups' control buffers' group rules.
;; Group awesome-tab with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
;; All buffer name start with * will group to \"Emacs\".
;; Other buffer group by `awesome-tab-get-group-name' with project name."
;;   (list
;;    (cond
;;     ((or (string-equal "*" (substring (buffer-name) 0 1))
;;          (memq major-mode '(magit-process-mode
;;                             magit-status-mode
;;                             magit-diff-mode
;;                             magit-log-mode
;;                             magit-file-mode
;;                             magit-blob-mode
;;                             magit-blame-mode)))
;;      "Emacs")
;;     ((derived-mode-p 'eshell-mode)
;;      "EShell")
;;     ((derived-mode-p 'dired-mode)
;;      "Dired")
;;     ((memq major-mode '(org-mode org-agenda-mode diary-mode))
;;      "OrgMode")
;;     ((derived-mode-p 'eaf-mode)
;;      "EAF")
;;     (t
;;      (awesome-tab-get-group-name (current-buffer))))))

(use-package pyim
  :ensure t
  :defer t
  :config
  ;; 激活 basedict 拼音词库
  (use-package pyim-basedict
    :ensure t
    :config (pyim-basedict-enable))

  ;; 五笔用户使用 wbdict 词库
  ;; (use-package pyim-wbdict
  ;;   :ensure nil
  ;;   :config (pyim-wbdict-gbk-enable))

  (setq default-input-method "pyim")

  ;; 设置 pyim 默认使用的输入法策略，我使用全拼。
  (setq pyim-default-scheme 'quanpin)
  ;; (pyim-default-scheme 'wubi)
  ;; (pyim-default-scheme 'cangjie)

  ;; 设置 pyim 是否使用云拼音
  ;; (setq pyim-cloudim 'baidu)

  ;; 显示 5 个候选词
  (setq pyim-page-length 5)


  ;; 按 "C-<return>" 将光标前的 regexp 转换为可以搜索中文的 regexp.
  (define-key minibuffer-local-map (kbd "C-<return>") 'pyim-cregexp-convert-at-point)

  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-dynamic-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))

  ;; 开启拼音搜索功能
  (pyim-isearch-mode 1)

  ;; 如果使用 posframe page tooltip, 就需要加载 posframe 包。 绘制选词框
  (use-package posframe
    :ensure t)
  (setq pyim-page-tooltip 'posframe)

  ;; 选词框显示5个候选词
  (setq pyim-page-length 5)

  ;; 让 Emacs 启动时自动加载 pyim 词库
  (add-hook 'emacs-startup-hook
            #'(lambda () (pyim-restart-1 t)))
  :bind
  ;; 金手指设置，可以将光标处的编码（比如：拼音字符串）转换为中文。
  (("M-j" . pyim-convert-string-at-point) ;与 pyim-probe-dynamic-english 配合
   ;;("C-;" . pyim-delete-word-from-personal-buffer)
   ))

;; emacs 桌面配置保存
(use-package desktop
  :ensure t
  :commands restart-emacs-without-desktop
  :init (desktop-save-mode)
  :config
  ;; inhibit no-loaded prompt
  (setq desktop-file-modtime (file-attribute-modification-time
                              (file-attributes
                               (desktop-full-file-name)))
        desktop-lazy-verbose nil
        desktop-load-locked-desktop t
        desktop-restore-eager 1
        desktop-restore-frames 1
        desktop-save t)

  (defun restart-emacs-without-desktop (&optional args)
    "Restart emacs without desktop."
    (interactive)
    (restart-emacs (cons "--no-desktop" args))))

;; 设置字体
(use-package cnfonts
  :ensure t
  :defer t
  :init
  (cnfonts-mode 1))

;; 设置括号高亮匹配
(use-package highlight-parentheses
  :ensure t
  :init
  (global-highlight-parentheses-mode))

(use-package symbol-overlay
  :ensure t
  :init
  :config
  (symbol-overlay-mode)
  (keymap-unset symbol-overlay-map (kbd "h")) ;; 取消 h 快捷键 help 功能
  (global-set-key (kbd "<f8>") 'symbol-overlay-put)       ; 高亮当前符号
  (global-set-key (kbd "M-n") 'symbol-overlay-jump-next) ; 下一个匹配
  (global-set-key (kbd "M-p") 'symbol-overlay-jump-prev) ; 上一个匹配
  (global-set-key (kbd "<f9>") 'symbol-overlay-remove-all) ; 清除所有高亮
  )


(provide 'init-tools)
