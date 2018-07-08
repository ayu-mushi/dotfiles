(add-to-list 'default-frame-alist '(font . "ricty-20"))

;;(savehist-mode 1)
;;; 永続化する変数を新たに追加する
;;(push 'compile-command savehist-additional-variables)
;;; 永続化しないミニバッファ履歴の変数を追加する
;;(push 'command-history savehist-ignored-variables)


(require 'mozc)
(prefer-coding-system 'utf-8)
(global-set-key [zenkaku-hankaku] #'toggle-input-method)

(global-unset-key "\C-\\")
(add-to-list  'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
    "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
    (lambda (s)
      (end-of-buffer)
      (eval-print-last-sexp))))


;;(setq desktop-globals-to-save '(extended-command-history))
;;(setq desktop-files-not-to-save "")
;;(desktop-save-mode 1)



;; Package Manegement
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; auto install

(require 'cl)
(defvar installing-package-list
    '(
    ;; package list
    evil
    evil-leader
    evil-numbers
    evil-nerd-commenter
    xclip))

(let ((not-installed (loop for x in installing-package-list
                                                       when (not (package-installed-p x))
                                                                                   collect x)))
    (when not-installed
          (package-refresh-contents)
              (dolist (pkg not-installed)
                        (package-install pkg))))

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(add-to-list 'load-path "~/.emacs.d/xclip")
(require 'xclip)
(xclip-mode 1)

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
;;(load-file "~/program/ProofGeneral/generic/proof-site.el")

(el-get-bundle auto-complete)
(global-auto-complete-mode t)
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'fundamental-mode)
(add-to-list 'ac-modes 'takt-mode)
(add-to-list 'ac-modes 'agda-mode)

;(add-to-list 'load-path "~/.emacs.d/nipposi")
;(require 'niposi)
;(setq auto-mode-alist (append '((".*.txt$" . niposi-mode)) auto-mode-alist))
;(setq auto-mode-alist (append '((".*.takt$" . takt-mode)) auto-mode-alist))

(add-to-list 'load-path "~/.emacs.d/el-get/dash")

;(add-to-list 'custom-theme-load-path "~/.emacs.d/el-get/solarized-emacs")
;(add-to-list 'load-path "~/.emacs.d/el-get/solarized-emacs")
;(load-theme 'solarized-dark)

(setq require-final-newline t)

(cond (window-system
(setq x-select-enable-clipboard t)
))

; ref: http://qiita.com/takaxp/items/4dfa11a81e18b29143ec
(setq org-agenda-files
      '("~/Memo/Reading_List.org" "~/Memo/todo.org"))

(org-defkey org-agenda-mode-map [(tab)]
  '(lambda () (interactive)
    (org-agenda-goto)
    (with-current-buffer "*Org Agenda*"
      (org-agenda-quit))))

(defvar my-doing-tag "Doing")
;; Doingタグをトグルする
(defun my-toggle-doing-tag ()
  (interactive)
  (when (eq major-mode 'org-mode)
    (save-excursion
      (save-restriction
        (unless (org-at-heading-p)
          (outline-previous-heading))
        (if (string-match (concat ":" my-doing-tag ":") (org-get-tags-string))
            (org-toggle-tag my-doing-tag 'off)
          (org-toggle-tag my-doing-tag 'on))
        (org-reveal)))))
(global-set-key (kbd "<f11>") 'my-toggle-doing-tag)

(setq org-capture-templates
  `(("d" "Doingタグ付きのタスクをInboxに投げる" entry
    (file+headline nil "INBOX")
     "** TODO %? :Doing:\n")))

(setq org-tag-faces
      '(("Doing" :foreground "#FF0000")))

(defun my-sparse-doing-tree ()
  (interactive)
  (org-tags-view nil "Doing"))
(define-key org-mode-map (kbd "C-c 3") 'my-sparse-doing-tree)

(cond (window-system
  (setq x-select-enable-clipboard t)
  ))

(set org-agenda-log-mode-items (quote(closed clock state)))

