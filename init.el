
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

 ;; cl - Common Lisp Extension
 (require 'cl)

 ;; Add Packages
 (defvar stephen/packages '(
                ;; --- Auto-completion ---
                company
                ;; --- Better Editor ---
                hungry-delete
                swiper
                counsel
                smartparens
                ;; --- Major Mode ---
                js2-mode
                ;; --- Minor Mode ---
                nodejs-repl
                exec-path-from-shell
                ;; --- Themes ---
                monokai-theme
                ;; solarized-theme
                ) "Default packages")

 (setq package-selected-packages stephen/packages)

 (defun stephen/packages-installed-p ()
     (loop for pkg in stephen/packages
           when (not (package-installed-p pkg)) do (return nil)
           finally (return t)))

 (unless (stephen/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg stephen/packages)
       (when (not (package-installed-p pkg))
         (package-install pkg))))

;;configure for hungry-delete
(require 'hungry-delete)
(global-hungry-delete-mode)
(add-hook 'python-mode-hook 'hungry-delete-mode-hook)

;;configure for smartparens
(require 'smartparens-config)
;; Always start smartparens mode in emacs-lisp-mode.
(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
;;start smartparens mode in python-mode
(add-hook 'python-mode-hook 'smartparens-mode)

;;configure for company
(setq company-transformers '(company-sort-by-occurrence))


;;config(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

(global-set-key (kbd "C-x b") 'counsel-recentf)


;;base configure
(tool-bar-mode -1)
(scroll-bar-mode -1)
(electric-indent-mode t)
(global-linum-mode t)
(global-company-mode t)
(setq-default cursor-type 'bar)
(setq make-backup-files nil)
(require 'org)
(setq org-src-fontify-natively t)
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(global-hl-line-mode t)
(load-theme 'monokai t)

;;configure for recentfile
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(delete-selection-mode t)
(setq initial-frame-alist (quote ((fullscreen . maximized))))



(setq inhibit-splash-screen t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 1)
 '(custom-safe-themes
   (quote
	("8ed752276957903a270c797c4ab52931199806ccd9f0c3bb77f6f4b9e71b9272" default)))
 '(whitespace-trailing-regexp "\\([	  ]+\\)"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-trailing ((t (:foreground "dim gray" :inverse-video nil)))))


;;自定义python-mode

(defun my-python-mode-config ()
  (setq python-indent-offset 4
        python-indent 4
        indent-tabs-mode nil
        default-tab-width 4

        ;; 设置 run-python 的参数
        python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i"
        python-shell-prompt-regexp "In \\[[0-9]+\\]: "
        python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
        python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
        python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n")

  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (hs-minor-mode t)                     ;开启 hs-minor-mode 以支持代码折叠
  (auto-fill-mode 0)                    ;关闭 auto-fill-mode，拒绝自动折行
  (whitespace-mode t)                   ;开启 whitespace-mode 对制表符和行为空格高亮
  (hl-line-mode t)                      ;开启 hl-line-mode 对当前行进行高亮
  (pretty-symbols-mode t)               ;开启 pretty-symbols-mode 将 lambda 显示成希腊字符 λ
  (set (make-local-variable 'electric-indent-mode) nil)) ;关闭自动缩进

(add-hook 'python-mode-hook 'my-python-mode-config)


