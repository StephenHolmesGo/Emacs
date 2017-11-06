(provide 'init-better-defaults)


(global-linum-mode t)
(global-company-mode t)

(setq make-backup-files nil)


(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(delete-selection-mode t)


(global-auto-revert-mode t)
(setq auto-save-default nil)


;;configure for recentfile
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

