(require 'tab-line)
(require 'tab-manage)

(global-tab-line-mode)

(setq tab-line-tabs-function #'tab-manage/mru-buffers)

(provide 'init-tab)
