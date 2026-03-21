;; 使用 magit
(use-package magit
  :ensure t
  :defer t)

;; (use-package git-gutter
;;   :ensure t
;;   :defer t
;;   :config
;;   (global-git-gutter-mode t)
;;   (global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
;;   (global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
;;   ;; Stage current hunk
;;   (global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)
;;   ;; Revert current hunk
;;   (global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk))

;; Highlight uncommitted changes using VC
(use-package diff-hl
  :custom (diff-hl-draw-borders nil)
;;   :custom-face
;;   (diff-hl-change ((t (:inherit custom-changed :foreground unspecified :background unspecified))))
;;   (diff-hl-insert ((t (:inherit diff-added :background unspecified))))
;;   (diff-hl-delete ((t (:inherit diff-removed :background unspecified))))
;;   :bind (:map diff-hl-command-map
;;          ("SPC" . diff-hl-mark-hunk))
;;   :hook ((after-init . global-diff-hl-mode)
;;          (after-init . global-diff-hl-show-hunk-mouse-mode)
;;          (dired-mode . diff-hl-dired-mode))
  :config
  (global-diff-hl-mode))
;;   ;; Highlight on-the-fly
;;   (diff-hl-flydiff-mode 1)
;; 
;;   ;; Set fringe style
;;   (setq-default fringes-outside-margins t)
;; 
;;   (with-no-warnings
;;     (defun my-diff-hl-fringe-bmp-function (_type _pos)
;;       "Fringe bitmap function for use as `diff-hl-fringe-bmp-function'."
;;       (define-fringe-bitmap 'my-diff-hl-bmp
;;         (vector (if sys/linuxp #b11111100 #b11100000))
;;         1 8
;;         '(center t)))
;;     (setq diff-hl-fringe-bmp-function #'my-diff-hl-fringe-bmp-function)
;; 
;;     (unless (display-graphic-p)
;;       ;; Fall back to the display margin since the fringe is unavailable in tty
;;       (diff-hl-margin-mode 1)
;;       ;; Avoid restoring `diff-hl-margin-mode'
;;       (with-eval-after-load 'desktop
;;         (add-to-list 'desktop-minor-mode-table
;;                      '(diff-hl-margin-mode nil))))
;; 
;;     ;; Integration with magit
;;     (with-eval-after-load 'magit
;;       (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
;;       (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))))

(provide 'init-git)
