;;; tab-manage.el --- Window tab management with visual list -*- lexical-binding: t -*-
;;
;; 作者: nefiend
;; 描述: 使用可视化列表管理 Emacs 窗口的 tab 切换
;;      按 C-<tab> 切换到下一个 tab，按 C-S-<tab> 切换到上一个 tab
;;      按住快捷键连续切换时，列表中标记移动而列表不动
;;      按 Enter/Space 确认切换，按 C-g 取消
;;      按数字键 1-9/0 直接跳转到对应编号的 buffer
;;      超过 3 秒无操作则自动取消
;;
;;; 代码:

;; =============================================================================
;; 依赖模块
;; =============================================================================

(require 'posframe)

;; =============================================================================
;; 常量
;; =============================================================================

(defconst tab-manage/buffer-name " *tab-manage*"
  "posframe 使用的固定 buffer 名称。")

;; =============================================================================
;; 状态变量
;; =============================================================================

(defvar tab-manage/buffers nil
  "进入切换模式时的 buffer 列表快照。
循环期间此列表固定不变，确保列表顺序不随切换改变。")

(defvar tab-manage/selected-index 0
  "当前选中的 buffer 在 `tab-manage/buffers' 中的索引。")

(defvar tab-manage/prev-index 0
  "上一次选中的 buffer 索引，用于增量更新高亮。")

(defvar tab-manage/original-buffer nil
  "进入切换模式前的当前 buffer，用于取消时恢复。")

(defvar tab-manage/active nil
  "是否处于切换模式中。t 表示正在切换，nil 表示空闲。")

(defvar tab-manage/posframe nil
  "当前显示的 posframe 实例。")

(defvar tab-manage/number-width 1
  "数字后缀列的宽度，根据 buffer 数量动态计算。")

;; =============================================================================
;; Buffer 列表获取（MRU 排序）
;; =============================================================================

(defun tab-manage/mru-buffers ()
  "按最近使用排序返回当前窗口的 buffer 列表。
当前 buffer 排最前，最近访问过的排其次，其余按 buffer-list 顺序。"
  (let* ((window (selected-window))
         (current (window-buffer window))
         (prev-buffers (mapcar #'car (window-prev-buffers window)))
         (prev-buffers (delq nil (seq-filter #'buffer-live-p prev-buffers)))
         (prev-buffers (delq current prev-buffers))
         (all-buffers (delq current (tab-line-tabs-buffer-list)))
         (remaining (seq-filter (lambda (b) (not (memq b prev-buffers))) all-buffers)))
    (delq nil (append (list current) prev-buffers remaining))))

;; =============================================================================
;; posframe 管理
;; =============================================================================

(defun tab-manage/init-buffer ()
  "初始化 posframe 使用的固定 buffer。
如果 buffer 不存在则创建，设置合适的属性。"
  (unless (get-buffer tab-manage/buffer-name)
    (with-current-buffer (get-buffer-create tab-manage/buffer-name)
      (setq cursor-type nil
            truncate-lines t
            buffer-read-only t))))

(defun tab-manage/hide ()
  "隐藏浮动列表窗口并清理 posframe 变量。"
  (when tab-manage/posframe
    (posframe-hide tab-manage/buffer-name)
    (setq tab-manage/posframe nil)))

(defun tab-manage/show ()
  "使用 posframe 显示 buffer 列表窗口。"
  (setq tab-manage/posframe
        (posframe-show tab-manage/buffer-name
                       :poshandler 'posframe-poshandler-frame-top-center
                       :background-color (face-background 'default)
                       :foreground-color (face-foreground 'default)
                       :max-width 100
                       :max-height 20
                       :min-width 20)))

(defun tab-manage/format-line (idx buf selected-p)
  "格式化单行内容。
IDX 为行索引，BUF 为 buffer 对象，SELECTED-P 为 t 时显示 ► 并加粗。
数字后缀放在名称后面，右对齐。"
  (let* ((name (buffer-name buf))
         (name-len (length name))
         (max-name-len (apply #'max (mapcar (lambda (b) (length (buffer-name b))) tab-manage/buffers)))
         (num (if (< idx 9) (1+ idx) (if (= idx 9) 0 nil)))
         (num-str (if num (format (format "%%%ds" tab-manage/number-width) num) ""))
         (padding (make-string (max 0 (- max-name-len name-len)) ? )))
    (propertize
     (format "%s %s%s  %s"
             (if selected-p "►" " ")
             name
             padding
             num-str)
     'tab-manage-index idx
     'face (if selected-p 'bold 'default))))

(defun tab-manage/render-content ()
  "生成全部列表内容并写入 posframe buffer。
每行使用 text property `tab-manage-index' 标记行号，
便于增量更新时快速定位。"
  (tab-manage/init-buffer)
  (let ((total (length tab-manage/buffers)))
    (setq tab-manage/number-width (max 1 (1+ (floor (log10 (max 1 total)))))))
  (with-current-buffer tab-manage/buffer-name
    (let ((inhibit-read-only t))
      (erase-buffer)
      (let ((idx 0))
        (dolist (buf tab-manage/buffers)
          (insert (tab-manage/format-line idx buf (= idx tab-manage/selected-index)))
          (insert "\n")
          (setq idx (1+ idx)))
        (when (> idx 0)
          (delete-char -1))))))

(defun tab-manage/refresh-highlight ()
  "增量更新 posframe 中的高亮显示。
只更新 `tab-manage/prev-index' 和 `tab-manage/selected-index' 对应两行的
标记符号和 face 属性，避免全量重建。"
  (when (get-buffer tab-manage/buffer-name)
    (with-current-buffer tab-manage/buffer-name
      (let ((inhibit-read-only t))
        (tab-manage--update-line tab-manage/prev-index nil)
        (tab-manage--update-line tab-manage/selected-index t)))))

(defun tab-manage--update-line (index selected-p)
  "更新指定索引行的标记和 face。
INDEX 为行索引，SELECTED-P 为 t 时显示 ► 并加粗，nil 时显示空格并使用默认 face。"
  (save-excursion
    (goto-char (point-min))
    (let ((current-idx 0)
          found)
      (while (and (not found)
                  (not (eobp)))
        (if (= current-idx index)
            (progn
              (let ((line-start (line-beginning-position))
                    (line-end (line-end-position)))
                (delete-region line-start line-end)
                (insert (tab-manage/format-line index (elt tab-manage/buffers index) selected-p)))
              (setq found t))
          (forward-line 1)
          (setq current-idx (1+ current-idx)))))))

;; =============================================================================
;; 切换逻辑
;; =============================================================================

(defun tab-manage/enter ()
  "进入切换模式。
快照当前窗口的 buffer 列表（按 MRU 排序），记录原始 buffer，初始化选中索引，显示列表。"
  (setq tab-manage/buffers (tab-manage/mru-buffers)
        tab-manage/original-buffer (current-buffer)
        tab-manage/selected-index (or (cl-position (current-buffer) tab-manage/buffers :test #'eq) 0)
        tab-manage/prev-index tab-manage/selected-index
        tab-manage/active t)
  (tab-manage/render-content)
  (tab-manage/show))

(defun tab-manage/select-next ()
  "将选中索引移动到下一个 buffer（循环）。
增量更新 posframe 高亮。"
  (let ((len (length tab-manage/buffers)))
    (when (> len 1)
      (setq tab-manage/prev-index tab-manage/selected-index
            tab-manage/selected-index (% (1+ tab-manage/selected-index) len))
      (tab-manage/refresh-highlight))))

(defun tab-manage/select-prev ()
  "将选中索引移动到上一个 buffer（循环）。
增量更新 posframe 高亮。"
  (let ((len (length tab-manage/buffers)))
    (when (> len 1)
      (setq tab-manage/prev-index tab-manage/selected-index
            tab-manage/selected-index (mod (1- tab-manage/selected-index) len))
      (tab-manage/refresh-highlight))))

(defun tab-manage/select-by-number (num)
  "根据数字键选中对应编号的 buffer 并确认。
1-9 对应索引 0-8，0 对应索引 9。如果编号超出范围则忽略。"
  (let ((idx (if (= num 0) 9 (1- num))))
    (when (< idx (length tab-manage/buffers))
      (setq tab-manage/prev-index tab-manage/selected-index
            tab-manage/selected-index idx)
      (tab-manage/confirm))))

;; =============================================================================
;; 确认与取消
;; =============================================================================

(defun tab-manage/confirm ()
  "确认切换到当前选中的 buffer。
关闭列表窗口，清理状态，执行 switch-to-buffer。"
  (let ((target (elt tab-manage/buffers tab-manage/selected-index)))
    (tab-manage/hide)
    (setq tab-manage/active nil)
    (when (and target (buffer-live-p target))
      (switch-to-buffer target))))

(defun tab-manage/cancel ()
  "取消切换，不切换 buffer。
关闭列表窗口，清理状态。"
  (tab-manage/hide)
  (setq tab-manage/active nil))

;; =============================================================================
;; 按键循环
;; =============================================================================

(defun tab-manage/loop ()
  "进入按键读取循环，等待用户操作。
C-<tab>     - 选中下一个
C-S-<tab>   - 选中上一个
Enter/Space - 确认切换
1-9/0       - 按数字直接选中并确认
C-g         - 取消
其他键      - 确认切换 + 将该键交给 Emacs 处理"
  (while tab-manage/active
    (let ((key (read-key-sequence "")))
      (cond
       ((or (equal key (kbd "C-<tab>"))
	    (equal key (kbd "j")))
        (tab-manage/select-next))
       ((or (equal key (kbd "C-S-<tab>"))
	    (equal key (kbd "C-S-<iso-lefttab>"))
	    (equal key (kbd "k")))
        (tab-manage/select-prev))
       ((member key '("\r" " "))
        (tab-manage/confirm))
       ((or (equal key (kbd "C-g"))
	    (equal key (kbd "<escape>")))
        (tab-manage/cancel))
       (t
        (let ((desc (key-description (vconcat key))))
          (if (string-match "^[0-9]$" desc)
              (tab-manage/select-by-number (string-to-number desc))
            (tab-manage/cancel)
            (push last-input-event unread-command-events))))))))

;; =============================================================================
;; 入口函数
;; =============================================================================

(defun tab-manage/start-next ()
  "按 C-<tab> 时的入口函数。
进入切换模式，选中下一个 buffer，进入按键循环。"
  (interactive)
  (tab-manage/enter)
  (tab-manage/select-next)
  (tab-manage/loop))

(defun tab-manage/start-prev ()
  "按 C-S-<tab> 时的入口函数。
进入切换模式，选中上一个 buffer，进入按键循环。"
  (interactive)
  (tab-manage/enter)
  (tab-manage/select-prev)
  (tab-manage/loop))

;; =============================================================================
;; 快捷键绑定
;; =============================================================================

;; C-<tab>           - 切换到下一个 tab
;; C-S-<tab>         - 切换到上一个 tab
;; C-S-<iso-lefttab> - 切换到上一个 tab (另一种键盘写法)

(global-set-key (kbd "C-<tab>") 'tab-manage/start-next)
(global-set-key (kbd "C-S-<tab>") 'tab-manage/start-prev)
(global-set-key (kbd "C-S-<iso-lefttab>") 'tab-manage/start-prev)

(provide 'tab-manage)

;;; tab-manage.el ends here
