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
   '(forge vdiff-magit counsel-projectile evil-magit magit projectile general doom-themes helpful which-key rainbow-delimiters moe-theme ample-theme monokai-theme spacemacs-theme doom-modeline ivy command-log-mode use-package))
 '(show-paren-mode t))
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

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/PATH/TO/moe-theme/")
;; (load-theme 'moe-dark t)



;; FONT SETTINGS
					; (set-face-attribute 'default nil :font "Fira Code Retina" :height 280)
(set-face-attribute 'default nil :height 125)



;; THANKS BUT NO THANKS


(tool-bar-mode -1) ;; disable toolbar
(set-fringe-mode 10) ;; "give some breathing room"
;; (scroll-bar-mode -1) ;; disable visible scrollbar
;; (tooltip-mode -10) ;; disable tooltips
(setq inhibit-startup-message t) ;; does what it says


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


;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts

(use-package all-the-icons)


(use-package doom-modeline
  :ensure
  :init (doom-modeline-mode 1)
  :custom ((Doom-modeline-height 15)))
					;(setq all-the-icons-color-icons nil)
(setq find-file-visit-truename t)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;;  (load-theme 'doom-one t)
  ;;  (load-theme 'doom-vibrant t)
  (load-theme 'doom-city-lights t)
  ;;  (load-theme 'doom-nord t)
  
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


;; START LINE NUMBERS
(column-number-mode)
(global-display-line-numbers-mode t)
;;(display-line-numbers-mode 0) ;; turn line numbers off

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
		shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
;; END LINE NUMBERS


;; BEGIN RAINBOW DELIMITERS
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
;; END RAINBOW DELIMITERS


;; BEGIN WHICH-KEY
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))
;; END WHICH-KEY


(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; supplements ivy with a custom tailored UI for each specific situation
(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))


(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


					
;; the following package allows to define keybindings in a more concise way
(use-package general
  :config
  (general-create-definer alphaWave/leader-keys ; define a pseudo-namespace called 'alphaWave'
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (alphaWave/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))		        


;; Set the padding between lines
(defvar line-padding 2)
(defun add-line-padding ()
  "Add extra padding between lines"

  ; remove padding overlays if they already exist
  (let ((overlays (overlays-at (point-min))))
    (while overlays
      (let ((overlay (car overlays)))
        (if (overlay-get overlay 'is-padding-overlay)
            (delete-overlay overlay)))
      (setq overlays (cdr overlays))))

  ; add a new padding overlay
  (let ((padding-overlay (make-overlay (point-min) (point-max))))
    (overlay-put padding-overlay 'is-padding-overlay t)
    (overlay-put padding-overlay 'line-spacing (* .1 line-padding))
    (overlay-put padding-overlay 'line-height (+ 1 (* .1 line-padding))))
  (setq mark-active nil))

(add-hook 'buffer-list-update-hook 'add-line-padding)
;; end of line-padding function


;; projectile is for managing projects (especially for coding n'stuff)
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
;  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map) ;; shows all projectile commands
  :init
  ;; when I'm in my /CodingProjects-folder, sets the projectile search path to that same folder, so I'll see all the things that are in there immediately
  (when (file-directory-p "~/CodingProjects")
    (setq projectile-project-search-path '("~/CodingProjects")))
  ;; whenever I switch between projects, it loads up dired so I see a listing of all the files in that project
  (setq projectile-switch-project-action #'projectile-dired))


(use-package counsel-projectile
 :after projectile
 :config
 (counsel-projectile-mode 1))


;; "A Git Porcelain inside Emacs. Magit is a complete text-based user interface to Git. It fills the glaring gap between the Git command-line interface and various GUIs, letting you perform trivial as well as elaborate version control tasks with just a couple of mnemonic key presses."
(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  ;; :commands (magit-status magit-get-current-branch)
  ;; :custom
  ;; (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  )

;; (use-package evil-magit
;;   :after magit)


;; enable scrolling left and right with the trackpad
(global-set-key [wheel-right] 'scroll-left)
(global-set-key [wheel-left] 'scroll-right)
(put 'scroll-left 'disabled nil)


(use-package forge)



