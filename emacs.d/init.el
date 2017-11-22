(package-initialize)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))
(load (concat user-emacs-directory "init-el-get.el"))

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load (concat user-emacs-directory "inits"))

(setq-default message-log-max nil)
(kill-buffer "*Messages*")
(kill-buffer "*scratch*")
