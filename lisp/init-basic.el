;; 打开服务模式，配合client完成右键文件用emacs编辑器打开
;; windows打开server文件夹没有权限，需要手动更改server文件夹的所有者，参考https://stackoverflow.com/questions/885793/emacs-error-when-calling-server-start
(server-mode 1)

;; 补全
(icomplete-mode -1)

;; 关闭自动生成备份文件
(setq make-backup-files nil)

;; 设置选中模式直接更改
(delete-selection-mode t)

;; 设置单行自动换行
(menu-bar--wrap-long-lines-window-edge)

;; emacs内置的记录已打开文件的功能
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

;; 设置emax的执行路径
(progn
  (defvar emax-root (concat (expand-file-name "~") "/emax"))
  (defvar emax-bin (concat emax-root "/bin"))
  (defvar emax-bin64 (concat emax-root "/bin64"))

  (setq exec-path (cons emax-bin exec-path))
  (setenv "PATH" (concat emax-bin ";" (getenv "PATH")))

  (setq exec-path (cons emax-bin64 exec-path))
  (setenv "PATH" (concat emax-bin64 ";" (getenv "PATH")))

  (setq emacsd-bin (concat user-emacs-directory "bin"))
  (setq exec-path (cons  emacsd-bin exec-path))
  (setenv "PATH" (concat emacsd-bin  ";" (getenv "PATH")))

  ;;可选安装msys64
  ;;下载地址: http://repo.msys2.org/mingw/sources/
  (setq msys-bin "c:/msys64/usr/bin")
  (setq exec-path (cons msys-bin exec-path))
  (setq msys-mingw64-bin "c:/msys64/mingw64/bin")
  (setq exec-path (cons msys-mingw64-bin exec-path))
  (setenv "PATH" (concat "C:\\msys64\\usr\\bin;C:\\msys64\\mingw64\\bin;" (getenv "PATH")))

  (dolist (dir '("~/emax/" "~/emax/bin/" "~/emax/bin64/" "~/emax/lisp/" "~/emax/elpa/"))
    (add-to-list 'load-path dir))
  )

(when (eq system-type 'windows-nt)
  (add-to-list 'process-coding-system-alist '("curl" utf-8-unix)))
;;ivy
;; Encoding
;; UTF-8 as the default coding system
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))

(set-language-environment 'chinese-gbk)
(prefer-coding-system 'utf-8)
;; (set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
;; (set-clipboard-coding-system 'utf-8)
;; (set-file-name-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-next-selection-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (setq locale-coding-system 'utf-8)

(when (eq system-type 'windows-nt)
  (setq locale-coding-system 'gb18030)
  ;; (setq locale-coding-system 'utf-8)
  (setq w32-unicode-filenames 'nil)
  (setq file-name-coding-system 'gb18030))
;; (setq file-name-coding-system 'utf-8))

(unless (eq system-type 'windows-nt)
  (set-clipboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8))

;; 自动加载外部修改过的文件
(global-auto-revert-mode 1)

;; 关闭自动产生的保存文件
(setq auto-save-default nil)

;; 关闭“哔哔”的告警提示音
(setq ring-bell-function 'ignore)

;; 设置yes/no的简写
(fset 'yes-or-no-p 'y-or-n-p)

(setq scroll-preserve-screen-position t) ;; 来回滚动屏幕时，保持光标在同一个位置，而不是移动到最顶端或低端
(setq scroll-conservatively 100) ;; 设置滚动屏幕时，当光标超出边缘时，光标不会重新回到屏幕中间
(setq scroll-margin 1) ;; 设置光标滚动时，保持距离屏幕边缘多少行

;; 设置自动配对操作
(electric-pair-mode 1)
(setq electric-pair-pairs
      '(
	(?\" . ?\")
	(?\[ . ?\])
	(?\{ . ?\})))

;; 保存历史命令
(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :init (setq enable-recursive-minibuffers t ; Allow commands in minibuffers
              history-length 1000
              savehist-additional-variables '(mark-ring
                                              global-mark-ring
                                              search-ring
                                              regexp-search-ring
                                              extended-command-history)
              savehist-autosave-interval 300)
  )

;; 记录文件光标所在的位置
(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))

(use-package simple
  :ensure nil
  :hook (after-init . size-indication-mode)
  :init
  (progn
    (setq column-number-mode t)
    ))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;; 自动保存 使用的是懒猫的插件，无法从官方仓库下载，手动从github 上下载了 auto-save.el 文件进行配置
;;(require 'auto-save)
;;(auto-save-enable)
;;(setq auto-save-silent t)
;;(setq auto-save-delete-trailing-whitespace t)

;; (add-to-list 'process-coding-system-alist '("git" utf-8))

(provide 'init-basic)
