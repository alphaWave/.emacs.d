;; HELPFUL STUFF
;; to re-evaluate this file (or any buffer), type: "M-x eval-buffer" or C-x C-e



;; the following was added automatically each time I re-eval'd the buffer, so I put it at the start of the file for now
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-tab-line-mode nil)
 '(package-selected-packages
   '(moe-theme ample-theme monokai-theme spacemacs-theme doom-modeline ivy command-log-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; LOOK

(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; fill up whole screen on startup

(global-hl-line-mode 1) ;; highlight whole line the cursor is on

;;(load-theme 'tango-dark)
;;(load-theme 'wombat)
;; (load-theme 'deeper-blue)

;; (use-package spacemacs-theme	       
;;   :ensure t
;;   :init
;;   (load-theme 'spacemacs-dark t)
;;   (setq spacemacs-theme-org-agenda-height nil)
;;   (setq spacemacs-theme-org-height nil))

;; (load-theme 'monokai t)

;; (load-theme 'ample t t)
;; (enable-theme 'ample)

(add-to-list 'custom-theme-load-path "~/.emacs.d/PATH/TO/moe-theme/")
(load-theme 'moe-dark t)


 
;; FONT SETTINGS
					; (set-face-attribute 'default nil :font "Fira Code Retina" :height 280)
(set-face-attribute 'default nil :height 125)



;; THANKS BUT NO THANKS

(set-fringe-mode 10) ;; "give some breathing room"

(scroll-bar-mode -1) ;; disable visible scrollbar

;; (tooltip-mode -10) ;; disable tooltips
;; (tool-bar-mode -1) ;; disable toolbar
;; (setq inhibit-startup-message t) ;; does what it says


;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
; this might lead to strange behavior, e.g. closing of windows etc., so in case this happepns, try turning it off


;; BELL: enable visible bell (instead of sound):
(setq visible-bell nil
      ring-bell-function 'double-flash-mode-line)
(defun double-flash-mode-line ()
  (let ((flash-sec (/ 1.0 20)))
    (invert-face 'mode-line)
    (run-with-timer flash-sec nil #'invert-face 'mode-line)
    (run-with-timer (* 2 flash-sec) nil #'invert-face 'mode-line)
    (run-with-timer (* 3 flash-sec) nil #'invert-face 'mode-line)))


;; Initialize package sources
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
(setq use-package-always-ensure t) ;; makes sure all packages will be ensured

(use-package command-log-mode)
;; (global-command-log-mode) ;; show command log in every buffer
;; (clm/toggle-command-log-buffer) ;; logs all commands in a new window on the right

(use-package swiper)

(use-package counsel) ; install and use package counsel

(use-package ivy
  :diminish ; don't show package mode name in minor mode list (e.g. in this case, "ivy" won't be displayed in the minor mode list)
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
	 ("TAB" . ivy-partial-or-done)
         ("C-l" . ivy-alt-done)
         ("C-k" . ivy-next-line)
         ("C-j" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-next-line)
         ("C-j" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-next-line)
         ("C-j" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package doom-modeline
  :ensure
  :init (doom-modeline-mode 1)
  :custom ((Doom-modeline-height 15)))
;(setq all-the-icons-color-icons nil)
(setq find-file-visit-truename t)



(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
