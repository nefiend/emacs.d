;; {{
;; 调用 immersive-translate-curl--sentinel 的时候，返回的状态码是60, 说明 curl ssl 证书过期了
;; 使用下面的 shell 命令，让 curl 不再校验 ssl 证书了
;; echo insecure > ~/.curlrc
;; }}
(use-package immersive-translate
  :ensure t
  :config
  ;; use Baidu Translation
  (setq immersive-translate-backend 'baidu
        immersive-translate-baidu-appid "20250219002278112"))

(use-package fanyi
  :ensure t
  :custom
  (fanyi-set-providers '(;; 海词
			 fanyi-haici-provider
			 ;; 有道
			 fanyi-youdao-thesaurus-provider
			 )))


(provide 'init-translate)
