(provide 'init-org)

(setq org-src-fontify-natively t)
(require 'org)

(setq org-agenda-files '("~/org"))
(global-set-key (kbd "C-c a") 'org-agenda)
