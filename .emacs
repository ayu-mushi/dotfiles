(add-to-list  'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
    "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
    (lambda (s)
      (end-of-buffer)
      (eval-print-last-sexp))))

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(add-to-list 'load-path "~/.emacs.d/takt-mode")
(require 'takt-mode)

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "~/.local/bin/agda-mode locate")))

(show-paren-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(agda2-include-dirs (quote ("/home/ayu-mushi/program/agda-stdlib/src" ".")))
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(load-file "~/program/ProofGeneral/generic/proof-site.el")

(el-get-bundle auto-complete)
(global-auto-complete-mode t)
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'fundamental-mode)
(add-to-list 'ac-modes 'takt-mode)
(add-to-list 'ac-modes 'agda-mode)

(add-to-list 'load-path "~/.emacs.d/nipposi")
(require 'niposi)
(setq auto-mode-alist (append '((".*.txt$" . niposi-mode)) auto-mode-alist))

(add-to-list 'load-path "~/.emacs.d/el-get/dash")

(add-to-list 'custom-theme-load-path "~/.emacs.d/el-get/solarized-emacs")
(add-to-list 'load-path "~/.emacs.d/el-get/solarized-emacs")
(load-theme 'solarized-dark)

(setq require-final-newline t)

(cond (window-system
(setq x-select-enable-clipboard t)
))
