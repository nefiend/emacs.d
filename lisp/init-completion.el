;; 补全五件套 vertico orderless marginalia embark consult

;;  增强minibuffer补全：vertico和orderless
;; (1) Vertico 垂直补全框架
(use-package vertico
  :init
  (vertico-mode 1) ; 全局启用
  :custom
  (vertico-count 15)     ; 显示条目数
  (vertico-resize nil)   ; 不自动调整窗口大小
  (vertico-cycle t))    ; 允许循环滚动
;;(keymap-set vertico-map "TAB" #'minibuffer-complete) ;; 将TAB快捷键设置成补全公共前缀的形式


;; (2) Orderless 模糊匹配
(use-package orderless
  :init
  (setq completion-styles '(orderless basic) ; 优先使用 orderless
      completion-category-defaults nil
      completion-category-overrides '((file (style use-package embark s partial-completion)))))

;; (3) Marginalia - 显示元信息
(use-package marginalia
  :init
  (marginalia-mode 1)
  (setq marginalia-annotators '(marginalia-annotators-heavy)))

;; (setq completion-styles '(orderless))cl--generic-find-defgeneric-regexp;; 配置 Marginalia 增强 minubuffer 的 annotation

;; (4) Consult - 搜索命令
(use-package consult
  :bind (("C-s" . consult-line)          ; 即时行搜索
         ("C-M-l" . consult-imenu)       ; 跳转到符号
         ("C-M-j" . consult-bookmark)    ; 书签
         ("M-y" . consult-yank-pop)      ; 增强版粘贴历史
         ("M-g g" . consult-goto-line))
  :config
  ;; (setq consult-ripgrep-args (concat consult-ripgrep-args " --no-ignore"))
  ) ; 跳转到行号

(with-eval-after-load 'embark
  (define-key embark-file-map (kbd "E")  #'consult-directory-externally))

;; 使用consult-buffer替换emacs自己本身的buffer，可以打开之前的文件
(global-set-key (kbd "C-x b") 'consult-buffer)

;; (5) Embark - 动作执行
(use-package embark
  :bind (("C-;" . embark-act)         ; 执行动作
         ("C-." . embark-collect))    ; 收集结果到新缓冲区
  :init
  (setq embark-indicators '(embark-mixed-indicator ;; 混合提示，经过0.5s 之后显示详细提示信息
                embark-highlight-indicator  ;; 高亮提示
                embark-isearch-highlight-indicator  ;; 搜索时高亮
                )))

(setq prefix-help-command 'embark-prefix-help-command)

;; (6) corfu - buffer 补全
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-auto-prefix 3)
  (corfu-auto-delay 0.0)
  (corfu-quit-at-boundary nil)
  (corfu-echo-documentation 0.25)
  (corfu-preview-current 'insert)
  (corfu-preselect-first nil)
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode)  ;; 在候选者停留一段时间时，会弹出 posframe 提示 info 信息
  :bind
  (:map corfu-map
    ("<return>" . corfu-complete)
    ("TAB" . corfu-next)
    ("<tab>" . corfu-next)
    ("<backtab>" . corfu-previous)
    ("C-<return>" . corfu-quit)
    ("C-n" . corfu-next)
    ("C-p" . corfu-previous)))

;; windows 上无法使用
(when (eq 1 1)
;; (when (not (eq system-type 'windows-nt))
  ;; SPC as separator
  (setq corfu-separator 32)

  ;; {{ https://github.com/minad/corfu/wiki#same-key-used-for-both-the-separator-and-the-insertion
  ;;      使用
  ;; highly recommanded to use corfu-separator with "32" (space)
  ;; 需要配合 (corfu-quit-at-boundary 'nil), 当输入第一个空格时，作为分割符，当输入第二个空格时，退出补全
  (define-key corfu-map (kbd "SPC")
         (lambda ()
        (interactive)
        (if current-prefix-arg
            ;;we suppose that we want leave the word like that, so do a space
            (progn
              (corfu-quit)
              (insert " "))
          (if (and (= (char-before) corfu-separator)
               (or
                ;; check if space, return or nothing after
                (not (char-after))
                (= (char-after) ?\s)
                (= (char-after) ?\n)))
              (corfu-quit)
            (corfu-insert-separator)))))
)

;; 补全的后端
(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c C-p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
)

;; 设置快捷键 把minibuffer的内容放到另外的buffer中
(define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export-write)

;; Embark-Consult 集成（可选）
;; 增强embark 和 consult 的使用，比如embark 可以方便的把consult-line, consult-mark 等工具中，把查询到的内容，同过 embark-export 导出，并可以就地编辑他们
(use-package embark-consult
  :after (embark consult)
  :demand t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode)) ;; 设置hook,启动Consult 预览模式

(use-package wgrep)

;; 配置everything
(add-to-list 'process-coding-system-alist '("es" gbk))
(add-to-list 'process-coding-system-alist '("git" utf-8))
(setq consult-locate-args (encode-coding-string "es.exe -i -p -r" 'gbk))
;; (when (eq system-type 'windows-nt)
;;   (add-to-list 'process-coding-system-alist '("curl" utf-8-unix)))

(eval-after-load 'consult
  (progn
    (setq
     consult-narrow-key "<"
     consult-line-numbers-widen t     consult-async-min-input 2
     consult-async-refresh-delay  0.15
     consult-async-input-throttle 0.2
     consult-async-input-debounce 0.1)))

(provide 'init-completion)
