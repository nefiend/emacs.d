;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)

(server-mode 1)

;; 补全
(icomplete-mode -1)

;; 关闭自动生成备份
(setq make-backup-files nil)

;; 关闭自动产生的保存文件
(setq auto-save-default nil)

;; 显示行号
(global-display-line-numbers-mode 1)

;; 设置自动配对操作
;;(global-


(provide 'init-basic)
