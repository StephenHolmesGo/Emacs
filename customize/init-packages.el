(provide 'init-package)
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
				popwin
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

;;configure for popwin
(require 'popwin)
(popwin-mode t)

;;config(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(provide 'init-packages)
