(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(kill-buffer "*Messages*")
;(kill-buffer "*scratch*")
(setq-default message-log-max nil)

(setq make-backup-files nil)
(setq auto-save-default nil)

(savehist-mode 1) ; Save mini-buffer history
(setq history-length 3000) ; Up history num
(setq recentf-max-saved-itemds 3000)

(prefer-coding-system 'utf-8-unix)

(setq-default indent-tabs-mode nil)

;;; view
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq frame-title-format "%f") ; titilebar file full name

;;; Always split window horizontal
;; 整数の場合は、元のウィンドウが最低でもその行数なければ分割しないことを意味する。
;; nilの場合は、この方法では分割しないことを意味する。
(setq split-width-threshold 9999999)
(setq split-height-threshold nil)

(if (display-graphic-p)
  (menu-bar-mode t))

;; 1行ずつスクロール
(setq scroll-conservatively 35
  scroll-margin 0
  scroll-step 1)
(setq comint-scroll-show-maximum-output t) ; shell-mode

(setq isearch-wrap-function '(lambda nil)) ; disable wrapping in isearch
