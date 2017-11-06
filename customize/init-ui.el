(provide 'init-ui)

(setq ring-bell-function 'ignore)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(electric-indent-mode t)
(setq inhibit-splash-screen t)
(load-theme 'monokai t)
(setq-default cursor-type 'bar)
(global-hl-line-mode t)
(setq initial-frame-alist (quote ((fullscreen . maximized))))

