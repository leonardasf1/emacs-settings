;;; package --- Summary
;;; Commentary:
;;; Code:
(defvar efs/default-font-size 180)
(defvar efs/default-variable-font-size 180)
;;; Package
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ;;("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))
;;; Use-package:
  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
;;; Basic
(setq inhibit-startup-message t)
(setq cursor-in-non-selected-windows nil) ;; No cursor in inactive windows
(setq make-backup-files         nil)
(setq auto-save-list-file-name  nil)
(setq auto-save-default         nil)

(menu-bar-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode)
;; (global-display-line-numbers-mode t)
(set-fringe-mode 10)  ;; Give some breathing room
(fset 'yes-or-no-p 'y-or-n-p)
(ido-mode)  ;; подсказки для find file
;;; Theme
(load-theme 'atom-one-dark)
(set-face-attribute 'font-lock-type-face nil :weight 'bold)
;;; Set-key
(recentf-mode 1)  ;; список последних открытых файлов
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(global-set-key (kbd "s-x") 'kill-region) ;; Вырезание
(global-set-key (kbd "s-c") 'kill-ring-save) ;; Копирование
(global-set-key (kbd "s-v") 'yank) ;; Вставка
(global-set-key (kbd "s-s") 'save-buffer) ;; Сохранение
(global-set-key (kbd "M-o") 'find-file) ;; Открытие
(global-set-key (kbd "s-z") 'undo) ;; Отмена

(global-set-key (kbd "s-i") 'previous-line) ;; Вверх
(global-set-key (kbd "s-k") 'next-line) ;; Вниз
(global-set-key (kbd "s-j") 'backward-char) ;; Влево
(global-set-key (kbd "s-l") 'forward-char) ;; Вправо

(global-set-key (kbd "s-I") 'scroll-down-command) ;; Page Up
(global-set-key (kbd "s-K") 'scroll-up-command) ;; Page Down
(global-set-key (kbd "s-o") 'forward-word)
(global-set-key (kbd "s-u") 'backward-word)
(global-set-key (kbd "s-;") 'move-end-of-line)
(global-set-key (kbd "s-h") 'move-beginning-of-line)
(global-set-key (kbd "s-L") 'end-of-buffer)
(global-set-key (kbd "s-J") 'beginning-of-buffer)

(global-set-key (kbd "s-f") 'delete-forward-char)
(global-set-key (kbd "s-d") 'delete-backward-char)
(global-set-key (kbd "s-n") 'reindent-then-newline-and-indent) ;; Новая строка
(global-set-key (kbd "M-SPC") 'set-mark-command) ;; Выделение

(global-set-key (kbd "M-q") 'other-window)
;;; Other
(use-package lsp-mode
  :commands lsp)

(use-package web-mode
  :mode "\\.vue\\'"
  :hook (web-mode . lsp))
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp)
  :config
  (setq typescript-indent-level 2))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))
