(use-package org
  :pin melpa
 :ensure t)
(defun nefiend/org-emphasis-hide-toggle ()
  (interactive)
  (if (equal org-hide-emphasis-markers t)
      (progn
	(setq org-hide-emphasis-markers nil)
	(message "org hide emphasis off!"))
    (setq org-hide-emphasis-markers t)
    (message "org hide emphasis on!"))
  (org-mode-restart))
(global-set-key (kbd "C-c o r") 'nefiend/org-emphasis-hide-toggle)

(setq org-hide-emphasis-markers t) ;; 隐藏符号

(use-package org-contrib
  :pin nongnu
  )

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
	      (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)" "MEETING(m)" "PHONE(p)"))))

(require 'org-checklist)

(setq org-log-done 'time) ;; 在org todo 变成 done 状态时，标题下方会插入一行 CLOSED:[时间缀]
(setq org-log-done 'note) ;; 在org todo 变成 done 状态时，系统会提示输入备注
(setq org-log-into-drawer t)

(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files '("~/.emacs.d/gtd.org"))
(setq org-agenda-span 'day)

;; {{ 配置 org-capture 内容
(global-set-key (kbd "C-c r") 'org-capture)
(setq org-default-notes-file "~/.emacs.d/default.org")
;; 设置 org 的笔记模板
;; 格式 (key description type target template property) 详细参考 org-capture-templates 介绍
(setq org-capture-templates
      '(("t" "Todo" )
	("tt" "Todo" entry (file+headline "~/.emacs.d/gtd.org" "Workspace")
	 "* TODO [#B] %?\n  %i\n %U" ;; 光标位于 %? 处，输入标题 换行输入设置的初始化文本，然后时非激活的时间
	 :empty-lines 1)
	))
;;  }}


(setq org-agenda-custom-commands
      '(("c" "重要且紧急的事"
	 ((tags-todo "+PRIORITY=\"A\"")))
	;; ...other commands here
	))

;; 设置在 orgmode 下进行自动换行
(add-hook 'org-mode-hook
  (lambda()
  (setq truncate-lines nil)))

;; 设置 orgmode html 预览
(use-package org-preview-html
  :ensure t)

;; 启用 orgmod 的模板功能，参考 org-structure-template-alist 和 org-tempo-keywords-alist
(require 'org-tempo)

;; 更好看的项目符号
(use-package org-superstar
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

;; {{
;; https://github.com/tumashu/cnfonts?tab=readme-ov-file#cnfonts-%E4%B8%8E-org-mode-%E9%85%8D%E5%90%88%E4%BD%BF%E7%94%A8
;; 注：这个功能不能在 window 系统下使用，它会让对齐功能失效，Linux 下 这个功能 一般 可以使用，Mac 系统未测试，同学可以亲自试一试。
(eval-after-load 'cnfonts
  (setq cnfonts-use-face-font-rescale t))
;; }}
;; 设置org标题1-8级的字体大小和颜色，颜色摘抄自monokai。;希望org-mode标题的字体大小和正文一致，设成1.0， 如果希望标题字体大一点可以设成1.2
(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 2.0 ))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.5 ))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.2 ))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.2 ))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.2 ))))
  '(org-level-6 ((t (:inherit outline-6 :height 1.2 ))))
  '(org-level-7 ((t (:inherit outline-7 :height 1.2 ))))
  '(org-level-8 ((t (:inherit outline-8 :height 1.2 ))))
) ;; end custom-set-faces

;; 配置 plantuml 画流程图的工具
;; 使用 M-x plantuml-download-jar 下载
;; (use-package plantuml-mode
;;   :ensure t
;;   :init
;;   (setq plantuml-jar-path "~/.emacs.d/tools/plantuml.jar")
;;   (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
;;   )
(setq org-plantuml-jar-path (expand-file-name "~/.emacs.d/tools/plantuml.jar"))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

(use-package org-download
  :ensure t
  )
(defun nefiend/org-download-wsl-clipboard()
  "use powershell to catch the clipboard,
  to simplify the logic, use c:/Users/Public as temporary directoy, and move it into current directoy"
  (interactive)
  (let* ((powershell "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
         (file-name (format-time-string "screenshot_%Y%m%d_%H%M%S.png"))
         ;; (file-path-powershell (concat "c:/Users/\$env:USERNAME/" file-name))
         (file-path-wsl (concat "./images/" file-name))
         )
    ;; (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save(\\\"C:/Users/\\$env:USERNAME/" file-name "\\\")\""))
    (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save(\\\"C:/Users/Public/" file-name "\\\")\""))
    (rename-file (concat "/mnt/c/Users/Public/" file-name) file-path-wsl)
    (insert (concat "[[file:" file-path-wsl "]]"))
    (message "insert DONE.")))
(setq org-display-inline-images t)  ; 自动显示图片
(setq org-redisplay-inline-images t) ; 动态更新（如缩放后）

;; (use-package valign
;;   :ensure t
;;   :init
;;   (add-hook 'org-mode-hook #'valign-mode))

(provide 'init-org)
