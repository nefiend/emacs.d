(use-package avy
  :ensure t
  :config
  (set-face-attribute 'avy-lead-face-0 nil :foreground "black")
  (set-face-attribute 'avy-lead-face-0 nil :background "#f86bf3")
  :bind
  (("M-g f" . 'avy-goto-line)
   ("M-g w" . 'avy-goto-word-or-subword-1)
   ("M-g a" . 'avy-goto-char-timer)
   ("M-g c" . 'avy-goto-char)))

;; 安装 ace-pinyin
(use-package ace-pinyin
  :ensure t
  :after avy
  :config
  ;; 启用全局模式（所有 avy 命令自动支持中文）
  (ace-pinyin-global-mode +1)

  ;; 可选：支持繁体中文
  (setq ace-pinyin-simplified-chinese-only-p nil)

  ;; 可选：禁用标点翻译（如果不需要）
  ;; (setq ace-pinyin-enable-punctuation-translation nil)

  ;; 可选：只对字符跳转启用中文支持，不对单词跳转启用
  ;; (setq ace-pinyin-treat-word-as-char nil)
)

(provide 'init-avy)
