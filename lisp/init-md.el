(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  ;; :mode ("README\\.md\\'" . markdown-mode)
  :init
  ;; (setq markdown-command "markdown")
  (setq markdown-command "pandoc")
  (setenv "PATH" (concat "C:\\Users\\x00665129\\AppData\\Local\\Pandoc;" (getenv "PATH")))
  :config
  (setq markdown-fontify-code-blocks-natively t)  ; 使用原生语法高亮
  ;; 设置预览窗口位置
  (setq markdown-live-preview-window 'right)
  ;; 自定义 CSS 样式
  (setq markdown-live-preview-default-css
        "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.1.0/github-markdown.min.css"))


(use-package markdown-preview-mode
  :ensure t
  :commands (markdown-preview-mode)
  :init
  ;; ;; 设置 GitHub 风格的 CSS
  ;; (setq markdown-preview-stylesheets
  ;;       (list
  ;;        ;; GitHub 主样式
  ;;        ;; "https://cdn.jsdelivr.net/npm/github-markdown-css@5.8.1/github-markdown.min.css"

  ;;        ;; 代码高亮样式（可选）
  ;;        "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/github.min.css"

  ;;        ;; 数学公式支持（可选）
  ;;        "https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.16.9/katex.min.css"))
  ;; 设置预览样式（可选）

  ;; (setq markdown-preview-stylesheets
  ;;       '("https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.1.0/github-markdown-light.min.css"))
  (setq markdown-preview-stylesheets
        '("https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.8.1/github-markdown.css"))

  :config
  ;; 自定义预览命令（使用 Chrome）
  (setq markdown-preview-browser-command "google-chrome-stable")
  ;; 自动开启预览
  (add-hook 'markdown-mode-hook 'markdown-preview-mode))

;; (use-package markdown-live-preview-mode
;;   :ensure t
;;   :init
;;   ;; 设置预览窗口位置
;;   (setq markdown-live-preview-window 'right)
;;   :config
;;   ;; 自定义 CSS 样式
;;   (setq markdown-live-preview-default-css
;;         "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.1.0/github-markdown.min.css"))

(provide 'init-md)
