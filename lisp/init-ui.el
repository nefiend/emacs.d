;; 显示行号
(global-display-line-numbers-mode 1)

;; 更改光标的样式
(setq-default cursor-type 'bar)

;; 设置括号配对高亮
(show-paren-mode t)

;;modeline上显示我的所有的按键和执行的命令
(use-package keycast
  :ensure t
  :bind ("C-c t k" . nefiend/toggle-keycast)
  :init
  ;; (add-to-list 'global-mode-string '("" keycast-mode-line " "))
  ;; (keycast-mode-line-mode t)
  (keycast-tab-bar-mode t)
  :config
  )

;; 设置空格的形式，会导致自己前景和背景色对不上
;; (progn
;;   (global-whitespace-mode -1)
;;   ;; Make whitespace-mode with very basic background coloring for whitespaces.
;;   ;; http://xahlee.info/emacs/emacs/whitespace-mode.html
;;   (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark)))
;;   ;; 设置空格无背景色
;;   (custom-set-faces
;;    '(whitespace-space ((t (:inherit (default markdown-code-face) :background nil :foreground "gray50")))))

;;   ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
;;   (setq whitespace-display-mappings
;;         ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
;;         '((space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
;;           ;; (newline-mark 10 [182 10]) ; LINE FEED,
;;           (tab-mark 9 [9655 9] [92 9]) ; tab
;;           )))

(global-hl-line-mode 1);; 设置当前行高亮
(menu-bar-mode 0);; 关闭菜单栏（File/Edit/Options 等）
(tool-bar-mode -1);; 关闭工具栏
(scroll-bar-mode -1);; 关闭滚动条

;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
;;(set-face-attribute 'default nil :height 160);;

;;让鼠标滚动更好用，会让鼠标滚动变慢
;; (setq mouse-wheel-scroll-amount '(1 ((shift) . 3) ((control) . nil)))
;; (setq mouse-wheel-progressive-speed nil)

;; 安装主题并加载
;;(use-package monokai-theme)
;;(load-theme 'monokai 1)

(use-package doom-themes
  :config
  (load-theme 'doom-solarized-light 1)
  ;; (load-theme 'doom-monokai-machine 1)
  )

;; doom-modelie依赖nerd-icons图标，使用M-x nerd-icons-install-fonts下载字体NFM.ttf，然后双击进行安装
(use-package nerd-icons
  :ensure t
  :defer t)

;; 这里的执行顺序非常重要，doom-modeline-mode 的激活时机一定要在设置global-mode-string 之后
(use-package doom-modeline
  :ensure t
  ;; {{ 这样配置会导致在切换 emacs 程序焦点的时候， mode-line 会变换大小
  ;; :custom-face
  ;; (mode-line ((t (:height 1.1))))
  ;; (mode-line-inactive ((t (:height 1.1))))
  ;; }}
  :init
  (doom-modeline-mode t))

(provide 'init-ui)
