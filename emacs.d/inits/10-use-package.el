(use-package el-patch
  :config
  (setq el-patch-use-aggressive-defvar t)
)

;;;; modeline
(use-package smart-mode-line
  :init
  (setq sml/theme 'light)
  (setq sml/no-confirm-load-theme t)
  (sml/setup)
)

;;;; theme
(use-package hc-zenburn-theme
  :config/el-patch
  (el-patch-defvar hc-zenburn-colors-alist
    '(("hc-zenburn-fg+1"     . "#FFFFEF")
       ("hc-zenburn-fg"       . "#DCDCCC")
       ("hc-zenburn-fg-1"     . "#70705E")
       ("hc-zenburn-bg-2"     . "#000000")
       ("hc-zenburn-bg-1"     . "#202020")
       ("hc-zenburn-bg-05"    . "#2D2D2D")
       ("hc-zenburn-bg"       . "#000000")
       ("hc-zenburn-bg+05"    . "#383838")
       ("hc-zenburn-bg+1"     . "#3E3E3E")
       ("hc-zenburn-bg+2"     . "#4E4E4E")
       ("hc-zenburn-bg+3"     . "#5E5E5E")
       ("hc-zenburn-red+1"    . "#E9B0B0")
       ("hc-zenburn-red"      . "#D9A0A0")
       ("hc-zenburn-red-1"    . "#C99090")
       ("hc-zenburn-red-2"    . "#B98080")
       ("hc-zenburn-red-3"    . "#A97070")
       ("hc-zenburn-red-4"    . "#996060")
       ("hc-zenburn-orange"   . "#ECBC9C")
       ("hc-zenburn-yellow"   . "#FDECBC")
       ("hc-zenburn-yellow-1" . "#EDDCAC")
       ("hc-zenburn-yellow-2" . "#DDCC9C")
       ("hc-zenburn-green-1"  . "#6C8C6C")
       ("hc-zenburn-green"    . "#8CAC8C")
       ("hc-zenburn-green+1"  . "#9CBF9C")
       ("hc-zenburn-green+2"  . "#ACD2AC")
       ("hc-zenburn-green+3"  . "#BCE5BC")
       ("hc-zenburn-green+4"  . "#CCF8CC")
       ("hc-zenburn-cyan"     . "#A0EDF0")
       ("hc-zenburn-blue+1"   . "#9CC7FB")
       ("hc-zenburn-blue"     . "#99DDE0")
       ("hc-zenburn-blue-1"   . "#89C5C8")
       ("hc-zenburn-blue-2"   . "#79ADB0")
       ("hc-zenburn-blue-3"   . "#699598")
       ("hc-zenburn-blue-4"   . "#597D80")
       ("hc-zenburn-blue-5"   . "#436D6D")
       ("hc-zenburn-magenta"  . "#E090C7")))
  :config
  (load-theme 'hc-zenburn t)
  (set-face-background 'region "#696969")
)

(use-package whitespace
  :commands whitespace-mode
  :config
  (setq whitespace-style '(face            ; faceで可視化
                            trailing       ; 行末
                            empty          ; 先頭/末尾の空行
                            tabs           ; タブ
                            tab-mark
                            spaces
                            space-mark     ; 表示のマッピング
                            ))

  (setq whitespace-display-mappings
    '((space-mark ?\u3000 [?\u25a1])
       (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
  (setq whitespace-space-regexp "\\(\u3000+\\)")
  (set-face-foreground 'whitespace-space "#7cfc00")
  (set-face-background 'whitespace-space 'nil)
  (set-face-bold 'whitespace-space t)
  (set-face-foreground 'whitespace-tab "#669125")
  (set-face-background 'whitespace-tab 'nil)
  (set-face-underline  'whitespace-tab t)
  )

(use-package paren
  :ensure nil
  :hook
  (after-init . show-paren-mode)
  (after-init . electric-pair-mode)
  :custom
  (show-paren-delay 0)
  (show-paren-style 'parenthesis)
)

(use-package ansi-color
  :config
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  :hook (compilation-filter . my-colorize-compilation-buffer))

;;;; keybind
(global-unset-key (kbd "C-x C-b"))
(global-unset-key (kbd "M-g g"))
(global-unset-key (kbd "C-h C-p")) ;view-emacs-problems
(global-unset-key (kbd "C-h n")) ;view-emacs-news
(global-unset-key (kbd "C-h C-n")) ;view-emacs-news
(global-unset-key (kbd "C-x ;"))

(define-key key-translation-map (kbd "C-h") (kbd "<DEL>")) ; C-h BackSpace
(global-set-key (kbd "M-k")(lambda () (interactive) (kill-line 0))) ; backward kill line
(global-set-key (kbd "C-c ;") 'comment-line)

;; C-w 単語削除
(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))
(global-set-key (kbd "C-w") 'kill-region-or-backward-kill-word)

;;;; packages
(use-package helm
  :bind (
  ("M-x" . helm-M-x)
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  ("C-x f" . helm-find-files)
  ("C-x C-b" . helm-for-files)
  ("C-x C-f" . helm-ls-git-ls)
  ("C-c i" . helm-imenu)
  ("C-x r l" . helm-bookmarks))
  :config
  (defun helm-buffers-truncate-lines-toggle ()
    (interactive)
    (if (eq helm-buffers-truncate-lines t)
      (setq helm-buffers-truncate-lines nil)
      (setq helm-buffers-truncate-lines t)))
  :custom
  (history-delete-duplicates t)
  (helm-buffer-max-length 50)
  (helm-split-window-default-side 'right)
  (helm-mini-default-sources
    '(helm-source-buffers-list
       helm-source-bookmarks
       helm-source-recentf
       helm-source-file-cache))
)

(use-package helm-ls-git
  :config
  (custom-set-variables
    '(helm-source-ls-git (helm-ls-git-build-ls-git-source))
  )
)

(use-package helm-xref
  :config
  (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
)

(use-package helm-tramp)
(use-package docker-tramp
  :custom
  (docker-tramp-use-names t)
)
(use-package helm-ghq)

(use-package undo-tree
  :diminish undo-tree-mode
  :init (global-undo-tree-mode)
)

(use-package undohist)

(use-package yasnippet
  :diminish yas-minor-mode
  :init (yas-global-mode)
)

(use-package editorconfig
  :init (editorconfig-mode)
)

(use-package indent-guide)

(use-package rg
  :config
  (rg-enable-menu)
  (setq rg-align-position-numbers t)
  (setq rg-align-position-content-separator "|")
)

(use-package google-translate
  :bind
  (("C-c t" . google-translate-enja-or-jaen))
  :config
  (setq google-translate-translation-directions-alist '(("en" . "ja") ("ja" . "en")))
  (defun google-translate-enja-or-jaen (&optional string)
    "Translate words in region or current position. Can also specify query with C-u"
    (interactive)
    (setq string
      (cond ((stringp string) string)
        (current-prefix-arg
          (read-string "Google Translate: "))
        ((use-region-p)
          (buffer-substring (region-beginning) (region-end)))
        (t
          (thing-at-point 'word))))
    (let* ((asciip (string-match
                     (format "\\`[%s]+\\'" "[:ascii:]’“”–")
                     string)))

      (run-at-time 0.1 nil 'deactivate-mark)
      (google-translate-translate
        (if asciip "en" "ja")
        (if asciip "ja" "en")
        string)))

  (defun remove-c-comment (args)
    (let ((text (nth 2 args)))
      (setf (nth 2 args) (replace-regexp-in-string "\n" " "
                           (replace-regexp-in-string "[ \t]*//[/*!]*[ \t]+" ""
                             (replace-regexp-in-string "[ \t]+\\(\\*[ \t]+\\)+" " " text))))
      args))

  (advice-add 'google-translate-request :filter-args #'remove-c-comment)

  :config/el-patch
  (el-patch-defun google-translate--search-tkk ()
    "Search TKK."
    (el-patch-swap
      (let ((start nil)
             (tkk nil)
             (nums '()))
        (setq start (search-forward ",tkk:'"))
        (search-forward "',")
        (backward-char 2)
        (setq tkk (buffer-substring start (point)))
        (setq nums (split-string tkk "\\."))
        (list (string-to-number (car nums))
          (string-to-number (car (cdr nums)))))
      (list 430675 2721866130)))
)

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
)

;;; vsc
(defun magit-display-buffer-status-same-window (buffer)
  "Display BUFFER the way this has traditionally been done."
  (display-buffer
    buffer (if (with-current-buffer buffer
                 (derived-mode-p 'magit-status-mode))
             '(display-buffer-same-window)
             nil))) ; display in another window
(use-package magit
  :bind
  (("C-x c g" . magit-status))
  :config
  (set-face-foreground 'magit-branch-local "brightgreen")
  (set-face-bold 'magit-branch-local t)
  (set-face-foreground 'magit-branch-remote "brightred")
  (set-face-bold 'magit-branch-remote t)
  :custom
  (magit-display-buffer-function 'magit-display-buffer-status-same-window)
)

(use-package git-gutter
  :init (global-git-gutter-mode)
)

;;; about frontend
(use-package company
  :bind
  (:map company-mode-map
    ("C-M-i" . company-complete))
  (:map company-active-map
    ("C-n" . company-select-next)
    ("C-p" . company-select-previous)
    ("TAB" . company-complete-selection))
  (:map company-search-map
    ("C-n" . company-select-next)
    ("C-p" . company-select-previous))
  :diminish company-mode
  :init
  (global-company-mode)
  (set-face-background 'company-preview "green")
  :custom
  (company-idle-delay nil)
  (company-dabbrev-downcase nil)
  (company-dabbrev-ignore-case t)
  (completion-ignore-case t)
  :config
  (delete 'company-clang company-backends)
)

(use-package quickrun
  :config
  (quickrun-add-command "c++/clang 1z"
    '((:command . "clang++")
       (:exec    . ("%c -std=c++17 -Wall -pedantic-errors %o -o %e %s"
                     "%e %a"))
       (:remove  . ("%e")))
    :default "c++")
)

(use-package lsp-mode
  :commands lsp
  :custom
  ;; debug
  (lsp-print-io nil)
  (lsp-trace nil)
  (lsp-print-performance nil)
  ;; general
  (lsp-auto-guess-root t)
  (lsp-document-sync-method 'incremental)
  (lsp-enable-completion-at-point nil)
)

(use-package lsp-ui :commands lsp-ui-mode)

(use-package company-lsp
  :after lsp-mode
)

;;; markup lang
(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :config
  (setq
    markdown-split-window-direction 'right
    markdown-command "github-markup"
    markdown-command-needs-filename t
    markdown-css-paths (list "https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css"))
)
(use-package markdown-toc)
(use-package plantuml-mode
  :mode
  (("\\.puml\\'" . plantuml-mode)
  ("\\.plantuml\\'" . plantuml-mode))
  :custom
  (plantuml-jar-path (concat (getenv "HOME") "/.emacs.d/straight/repos/plantuml-mode/bin/plantuml.jar"))
  (plantuml-default-exec-mode 'jar)
)

(use-package flycheck-plantuml
  :hook
  (plantuml-mode . flycheck-plantuml-setup)
  (plantuml-mode . flycheck-mode)
)
(use-package toml-mode)
(use-package dockerfile-mode)
(use-package yaml-mode)

;;; cpp lang
(use-package modern-cpp-font-lock
  :diminish
  :hook
  (c++-mode . modern-c++-font-lock-mode)
)

(use-package ccls
  :hook
  (c++-mode . (lambda () (lsp)))
  (c++-mode . (lambda () (c-set-offset 'innamespace 0)))
)

(use-package clang-format)
(use-package company-c-headers)

;;; rust lang
(use-package racer
  :after company-mode
  :hook
  ((racer-mode-hook . eldoc-mode)
  (racer-mode-hook . company-mode))
)

(use-package company-racer
  :init
  (add-to-list 'company-backends 'company-racer)
)

(use-package rust-mode
  :init
  (add-hook 'rust-mode-hook #'racer-mode)
)

(use-package cargo
  :hook
  (rust-mode-hook . cargo-minor-mode)
)

;;; swift lang
(use-package swift-mode)

;;; csharp
(use-package omnisharp
  :init
  (add-to-list 'company-backends 'company-omnisharp)
  :hook
  (csharp-mode-hook . omnisharp-mode)
  (csharp-mode-hook . company-mode)
  (csharp-mode-hook . flycheck-mode)
)

;;; web
(use-package web-mode
  :mode
  (
    ("\\.html\\'" . web-mode)
    ("\\.js\\'" . web-mode)
    ("\\.jsx\\'" . web-mode)
    ("\\.tsx\\'" . web-mode)
    ("\\.erb\\'" . web-mode)
    ("\\.twig\\'" . web-mode)
  )
  :custom
  (web-mode-content-types-alist '(("jsx"  . "\\.js[x]?\\'")))
)
(use-package emmet-mode)

;; typescript LSP
(use-package tide
  :init
  (add-hook 'web-mode-hook
    (lambda () (tide-setup))
    )
  :custom
  (tide-completion-ignore-case t)
)

;;; golang
(use-package go-mode)

;;; php
(use-package php-mode)
