(require 'tab-line)

(global-tab-line-mode)

(defun nefiend/tab-line-next-buffer ()
  "switch to tab line next buffer"
  (interactive)
  (let ((buffers (tab-line-tabs-fixed-window-buffers))
	(len (length (tab-line-tabs-fixed-window-buffers))))
    (switch-to-buffer (elt buffers (% (+ (cl-position (current-buffer) buffers) 1) len)))))

(defun nefiend/tab-line-prev-buffer ()
  "switch to tab line prev buffer"
  (interactive)
  (let ((buffers (tab-line-tabs-fixed-window-buffers))
	(len (length (tab-line-tabs-fixed-window-buffers))))
    (switch-to-buffer (elt buffers (% (+ (cl-position (current-buffer) buffers) (- len 1)) len)))))

(global-set-key (kbd "C-<tab>") 'nefiend/tab-line-next-buffer)
;; (global-set-key (kbd  "C-<iso-lefttab>") 'nefiend/tab-line-prev-buffer)
(global-set-key (kbd  "C-S-<tab>") 'nefiend/tab-line-prev-buffer)

;; (global-set-key (kbd "C-<tab>") 'next-buffer) ;; 设置 ctrl + tab 切换下一个 tab
;; (global-set-key (kbd "C-<iso-lefttab>") 'previous-buffer) ;; 设置 ctrl + shift + tab 切换上一个 tab

(provide 'init-tab)
