(load-theme 'atom-one-dark)
(menu-bar-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-default 'cursor-type 'hbar)
(column-number-mode)
(fset 'yes-or-no-p 'y-or-n-p)
(ido-mode 1) ;; подсказки для find file

(recentf-mode 1) ;; список последних открытых файлов
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(setq inhibit-startup-message t) ;; No startup  screen
(setq make-backup-files         nil)
(setq auto-save-list-file-name  nil)
(setq auto-save-default         nil)

(add-to-list 'load-path
              "~/.emacs.d/plugins/god-mode")
(require 'god-mode)
(god-mode)
(global-set-key (kbd "<escape>") #'god-local-mode)
(custom-set-faces
 '(god-mode-lighter ((t (:inherit error)))))
(defun my-god-mode-update-cursor-type ()
  (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))

(add-hook 'post-command-hook #'my-god-mode-update-cursor-type)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

 ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package lsp-mode
       :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package treemacs
  :ensure t
  :defer t
  :init)
(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package web-mode
  :mode "\\.vue\\'"
  :hook (web-mode . lsp))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp)
  :config
  (setq typescript-indent-level 2))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("" . company-complete-selection))

        (:map lsp-mode-map
         ("" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(provide 'init)
