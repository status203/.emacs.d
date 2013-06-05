;;(Setenv "ERGOEMACS_KEYBOARD_LAYOUT" "gb")

; some tricks from the emacs-starter-kit v2
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; starter-kit-eshell starter-kit-js starter-kit-ruby)
;; Add in your own as you wish:
(defvar my-packages '(starter-kit
                      starter-kit-bindings
                      clojure-mode
                      nrepl
                      nrepl-ritz
                      ac-nrepl
                      magit
                      ido
                      popup
                      window-number

                      molokai-theme
                      reverse-theme
                      twilight-theme
                      zen-and-art-theme)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (progn 
    (when (not (package-installed-p p))
        (package-install p))
    (require p)))

(load-theme 'molokai t)

(desktop-save-mode 1)

;; hack
;;(load-file "~/.emacs.d/ergoemacs-keybindings-5.3.9/ergoemacs-mode.el")
;;(ergoemacs-mode 1)

;; =============================================================================
;; Ido
;; =============================================================================
;; Thanks be to http://www.masteringemacs.org/articles/2010/10/10/introduction-to-dio-mode/
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-filename-at-point 'guess)
(setq ido-file-extensions-order '(".clj" ".project" ".txt" ".el"))
(ido-mode 1)


;; =============================================================================
;; Clojure config
;; =============================================================================

;;(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))


;; =============================================================================
;; Clojurescript config
;; =============================================================================

(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))


;; =============================================================================
;; Autocomplete config
;; =============================================================================

(require 'auto-complete-config)
(ac-config-default)
(define-key ac-completing-map "\M-/" 'ac-stop) ; use M-/ to stop completion

;; =============================================================================
;; nrepl config
;; =============================================================================

;; ac-nrepl
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))

;;(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
;;(setq nrepl-hide-special-buffers t)
;;(setq nrepl-popup-stacktraces nil)
;;(setq nrepl-popup-stacktraces-in-repl t)
(add-hook 'nrepl-mode-hook 'subword-mode)
;;(add-to-list 'same-window-buffer-names "*nrepl*")
(add-hook 'nrepl-mode-hook (lambda () (paredit-mode +1)))
(eval-after-load 'nrepl
  '(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))


(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

(add-hook 'nrepl-mode-hook
          'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-interaction-mode-hook
          'set-auto-complete-as-completion-at-point-function)

(setq ac-auto-show-menu t)
(setq ac-dwim t)
(setq ac-use-menu-map t)
(setq ac-quick-help-delay 1)
(setq ac-quick-help-height 60)
(setq ac-disable-inline t)
(setq ac-show-menu-immediately-on-auto-complete t)
(setq ac-auto-start 2)
(setq ac-candidate-menu-min 0)

(define-key ac-completing-map (kbd "C-M-n") 'ac-next)
(define-key ac-completing-map (kbd "C-M-p") 'ac-previous)
(define-key ac-completing-map "\t" 'ac-complete)
(define-key ac-completing-map (kbd "M-RET") 'ac-help)
(define-key ac-completing-map "\r" 'nil)
