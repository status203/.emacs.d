;;(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "gb")

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
                      midje-mode
                      rainbow-delimiters)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; hack
;;(load-file "~/.emacs.d/ergoemacs-keybindings-5.3.9/ergoemacs-mode.el")
;;(ergoemacs-mode 1)


;; =============================================================================
;; Autocomplete setup
;; =============================================================================

'(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4.20110207/dict")
'(require 'auto-complete-config)
'(ac-config-default)

;; =============================================================================
;; Clojure config
;; =============================================================================

(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(require 'midje-mode)
(add-hook 'clojure-mode-hook 'midje-mode)
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))

; add color into the repl via clojure-jack-in
;;(add-hook 'slime-repl-mode-hook
;;         (defun clojure-mode-slime-font-lock ()
;;           (let (font-lock-mode)
;;             (clojure-mode-font-lock-setup))))

;; paredit mode in the repl
;;(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))

;; =============================================================================
;; Clojurescript config
;; =============================================================================

(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))
