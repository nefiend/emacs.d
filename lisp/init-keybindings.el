;; 把app键设置成super键
(setq w32-apps-modifier 'super)

;; 将 open-init-file 绑定到<f2>上
(global-set-key (kbd "<f2>") 'open-init-file)

;; 设置 Meta 键位，但是很少用，需要键盘上有对应的功能按键才行。
(global-set-key (kbd "s-a") 'mark-whole-buffer) ;;对应Windows上面的Ctrl-a 全选
(global-set-key (kbd "s-c") 'kill-ring-save) ;;对应Windows上面的Ctrl-c 复制
(global-set-key (kbd "s-s") 'save-buffer) ;; 对应Windows上面的Ctrl-s 保存
(global-set-key (kbd "s-v") 'yank) ;对应Windows上面的Ctrl-v 粘贴
(global-set-key (kbd "s-z") 'undo) ;对应Windows上面的Ctrol-z 撤销
(global-set-key (kbd "s-x") 'kill-region) ;对应Windows上面的Ctrol-x 剪切

;; 设置查找函数、变量、快捷键的快捷键
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(global-set-key (kbd "s-p") 'toggle-chinese-search)

;; 这个快捷键绑定可以用之后的插件 counsel 代替
;; (global-set-key (kbd "C-x C-r") 'recentf-open-filest

;; 设置 Alt-a 为移动到行首，Alt-e 为移动到行尾
(global-set-key (kbd "M-a") 'move-beginning-of-line)
(global-set-key (kbd "M-e") 'move-end-of-line)

(global-set-key (kbd "C-c p f") 'project-find-file)
(global-set-key (kbd "C-c p s") 'consult-ripgrep)
(global-set-key (kbd "C-c p l") 'consult-locate)

;; 设置鼠标侧键前进和后退
(global-set-key (kbd "<mouse-4>") 'evil-jump-backward)
(global-set-key (kbd "<mouse-5>") 'evil-jump-forward)

;; 使用 general 进行自定义快捷键管理
(use-package general
  :ensure t)

;; {{ use `,` as leader key
(general-create-definer my-comma-leader-def
  :prefix ","
  :states '(normal visual))
;; }}

(my-comma-leader-def
  "," 'evilnc-comment-operator ;; comment choose line
  "0" 'winum-select-window-0-or-10
  "1" 'winum-select-window-1
  "2" 'winum-select-window-2
  "3" 'winum-select-window-3
  "4" 'winum-select-window-4
  "5" 'winum-select-window-5
  "6" 'winum-select-window-6
  "7" 'winum-select-window-7
  "8" 'winum-select-window-8
  "9" 'winum-select-window-9
  "?" 'which-key-show-top-level
  "tp" 'immersive-translate-paragraph
  "tb" 'immersive-translate-buffer
  "tc" 'immersive-translate-clear
  "tw" 'fanyi-dwim2
)

;; {{ use `SPC` as leader key
(general-create-definer my-space-leader-def
  :prefix "SPC"
  :states '(normal visual))
;; }}

(defun nefiend/scroll-other-window-by-line ()
  (interactive)
  (scroll-other-window 1))

(defun nefiend/scroll-other-window-down-by-line ()
  (interactive)
  (scroll-other-window-down 1))
(my-space-leader-def
 "tt" 'treemacs
 "gf" 'avy-goto-line
 "gw" 'avy-goto-word-or-subword-1
 "ga" 'avy-goto-char-timer
 "gc" 'avy-goto-char
 "dw" 'delete-other-windows
 ;; "tn" 'sort-tab-select-next-tab
 ;; "tp" 'sort-tab-select-prev-tab
 "kb" 'kill-current-buffer
 "oj" 'nefiend/scroll-other-window-by-line
 "ok" 'nefiend/scroll-other-window-down-by-line
 )

(provide 'init-keybindings)
