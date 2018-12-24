;;; Commentary: Emacs Startup File --- initialization for Emacs
;;; init.el --- Initialization file for Emacs

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
;; https://stackoverflow.com/a/8989982/1257959
;; (setq ns-right-option-modifier 'super)
(setq ns-function-modifier 'super)



;; INSTALL PACKAGES

;; --------------------------------------

(require 'package)

;; Since emacs 24 there's a very neat package system.
(when (>= emacs-major-version 24)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("melpa" . "http://melpa.org/packages/")
                           ("melpa-stable" . "http://stable.melpa.org/packages/")
                           ;;; Old, and no longer maintained:
                           ;;("ELPA" . "http://tromey.com/elpa/")
                           ;;("marmalade" . "http://marmalade-repo.org/packages/")
                           )))
(package-initialize)

;;Auto-install missing packages ---------------

;; packages I use all the time, which _must_
;; be installed on all my emacs-machines:
(setq my-must-have-packages
      '(elpy
        flycheck
        material-theme
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        auctex                          ; a must for LaTeX
        avy                             ; awesome for jumping / navigating cursor on screen
        beacon                          ; show whre the cursor is when jumping between buffers & frames
        browse-kill-ring                ; a must! C-y (and M-y) on steroids!
        color-theme-sanityinc-tomorrow  ; blue version is nice (doesn't need the old color-theme package)
        command-log-mode                ; log pressed keys to buffer (e.g. useful for presentations)
        company                         ; for auto-compleate variables/functions (with drop down menu)
        company-auctex                  ; auto-complete for latex
        dtrt-indent                     ; awesome: automagically guess indentation style of file
        ;;emms                          ; emacs multimedia system, (for playlists etc.)
        geiser                          ; for writing Scheme lisp
        gnuplot                         ; gnuplot-mode
        goto-chg                        ; navigate in buffer by using undo-history
        graphviz-dot-mode               ; because syntax highlight in graphviz scripts is nice
        green-phosphor-theme            ; a color theme, as the name suggests
        htmlize                         ; render current buffer face and syntax highlight to html
        lua-mode                        ; at least gives syntax highlight for Lua-code
        magit                           ; powerful git-interface
        markdown-mode                   ; markdown-mode for github posts
        org                             ; use a more recent than default emacs
        paredit                         ; excellet for lisp, but steep lerning, for parenthesis manegement
        rainbow-mode                    ; Colour hex rgb values, e.q. "#00ff00" in it's colour
        ;;smex                            ; smarter "M-x"
        sml-modeline                    ; I use it to replaces scrollbar, show info in modeline instead
        volatile-highlights             ; slightly shade just pasted region
        which-key                       ; smarter when half finished key combo
        with-editor                     ; make emacs default $EDITOR
        yasnippet                       ; auto-complete templates (e.g. if, for, do ...)
        ))

;; install any packages in my-must-have-packages,
;; if they are not installed already
(let ((refreshed nil))
  (when (not package-archive-contents)
    (package-refresh-contents)
    (setq refreshed t))
  (dolist (pkg my-must-have-packages)
    (when (and (not (package-installed-p pkg))
               (assoc pkg package-archive-contents))
      (unless refreshed
        (package-refresh-contents)
        (setq refreshed t))
      (package-install pkg))))

(defun package-list-unaccounted-packages ()
  "Like `package-list-packages', but shows only the packages that
  are installed and are not in `my-must-have-packages'.  Useful for
  cleaning out unwanted packages."
  (interactive)
  (package-show-package-list
   (remove-if-not (lambda (x) (and (not (memq x my-must-have-packages))
                                   (not (package-built-in-p x))
                                   (package-installed-p x)))
                  (mapcar 'car package-archive-contents))))
;;---------------------------------------------


(when (not package-archive-contents)
  (package-refresh-contents))


;; Where to find Emacs24 themes for M-x load-theme
(when (>= emacs-major-version 24)
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
  ;;(load-theme 'zenburn t nil)
  ;;(load-theme 'sanityinc-tomorrow-blue t nil)
  )


;;--------------------------------------------
(tool-bar-mode -1)                        ;;never have a retarded tool-bar at top
(menu-bar-mode -1)                        ;;never have a retarded menu-bar at top
(scroll-bar-mode -1)                      ;;never have a retarded scrill-bar at side
(setq-default indicate-empty-lines t)     ;;show (in left margin) marker for empty lines

;; BASIC CUSTOMIZATION
;; --------------------------------------
(global-linum-mode t) ;; enable line numbers globally
;;Modline-------------------------------------
(line-number-mode t)                        ;; show line numbers
(column-number-mode t)                      ;; show column numbers
;;;;;;;;

(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files."))

;;One-Line commands---------------------------
(defalias 'yes-or-no-p 'y-or-n-p)     ;;answer "y/n" rather than "yes/no"
;(delete-selection-mode t)            ;;delete region at key press, not needed due to cua-mode nil (in rectangle)
(setq visible-bell t)                 ;;blink instead of beep
(setq inhibit-startup-message t)      ;;Don't show start up message/buffer
(file-name-shadow-mode t)             ;;be smart about file names in mini buffer
(global-font-lock-mode t)             ;;syntax highlighting on...
(setq font-lock-maximum-decoration t) ;;...as much as possible
(setq frame-title-format '(buffer-file-name "%f" ("%b"))) ;;titlebar=buffer unless filename

(setq-default indent-tabs-mode nil)   ;;use spaces instead of evil tabs

;; Instead of C-u C-SPC C-u C-SPC to pop mark twice, do: C-u C-SPC C-SPC
(setq set-mark-command-repeat-pop t)
;;--------------------------------------------

;;Emacs is a text editor, make sure your text files end in a newline
(setq require-final-newline 'query)

;;no extra whitespace after lines
;; http://emacsredux.com/blog/2013/05/16/whitespace-cleanup/
;;'whitespace-cleanup is better than delete-trailing-whitespace
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)

;;
;; CONFIG DOC http://home.thep.lu.se/~karlf/emacs.html#sec-7-6
;;

;; MY hooks
(setq python-python-command "/usr/local/bin/python3")
;; https://realpython.com/blog/python/emacs-the-best-python-editor/
(elpy-enable)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;;(setq venv-location "/Users/cagil/virtuals/")
(setenv "WORKON_HOME" "/Users/cagil/virtuals/")
;;

; flycheck
;(use-package flycheck
;  :ensure t
;  :init (global-flycheck-mode))
;; (add-hook 'after-init-hook #'global-flycheck-mode)
;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (zenburn-theme which-key volatile-highlights sml-modeline rainbow-mode paredit markdown-mode magit lua-mode htmlize green-phosphor-theme graphviz-dot-mode goto-chg gnuplot geiser dtrt-indent company-auctex command-log-mode color-theme-sanityinc-tomorrow browse-kill-ring beacon avy material-theme web-mode elpy popup-kill-ring rjsx-mode better-defaults flycheck auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:$PATH" t)
(setq exec-path (append exec-path '("/Library/TeX/texbin")))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Backups
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(message "Delting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files temporary-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (nth 5 (file-attributes file))))
                  week))
      (message "%s" file)
      (delete-file file))))
;;;;;;;;;;;

;;; popup-kill-ring.el --- interactively insert item from kill-ring
;;; Setting:
;;
;; 1. Download the `popup.el', `pos-tip.el' and this file.
;; 2. Put your `load-path' directory to the `popup.el', `pos-tip.el'
;;    and this file.
;; 3. Add following settings to your .emacs.
;;
(require 'popup)
(require 'pos-tip)
(require 'popup-kill-ring)

(global-set-key "\M-y" 'popup-kill-ring) ; For example.
;;
;; * If you insert a selected item interactively, add following line to
;;   your .emacs.
;;
;;   (setq popup-kill-ring-interactive-insert t)

;; Web mode

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;
