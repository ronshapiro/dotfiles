(add-to-list 'load-path "~/.emacs.d/")

(setq c-basic-offset 2)
;(setq standard-indent 2)
;(setq default-tab-width 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
;(setq indent-line-function 'insert-tab)
(setq js-indent-level 2)
(setq java-indent-level 2)
(setq java-indent-offset 2)
(add-hook 'java-mode-hook
          (lambda () (setq c-basic-offset 2)))
(add-hook 'c-mode-hook
          (lambda () (setq c-basic-offset 2)))
  
;(global-set-key (kbd "TAB") 'indent-according-to-mode)
;(global-set-key (kbd "TAB") 'indent-for-tab-command)
;(global-set-key (kbd "C-i") 'indent-relative)

; When you reach the end of the screen and then go to the next line, only move
; the page down one line instead of several
(setq scroll-step 1) 

(setq temp-directory "~/.emacs_tmps/")
;;Save all file backups to a special location.
(setq backup-directory-alist  '((".*" . "~/.emacs_tmps/")))

;;Column and line numbers
(line-number-mode 1)
(column-number-mode 1)

;Set max line length
;(setq-default fill-column 79)
;(setq auto-fill-mode 1)

;;Have emacs save your location in a file and return there when you reopen it
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/saved-places")

(require 'fill-column-indicator) ;80 char bar
; (setq fci-rule-column 80) isn't working, so i updated the value in
; .emacs.d/fill-column-indicator.el from nil to 80
(setq fci-rule-column 80) 
(setq fci-rule-width 1)
(setq fci-rule-color "blue")

(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

; have comment lines extend all of coloring
(set-face-foreground 'font-lock-comment-face "Red")
(set-variable font-lock-comment-face 'font-lock-comment-face)

;; Set region background color
(set-face-background 'region "blue")

;; Set emacs background color
;;(set-background-color "black")

;; Overwrite C-x C-b to also switch buffers (the default functionality is useless/annoying
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

;;Default to regexp search
(global-set-key (kbd "C-s") 'isearch-forward)
(global-set-key (kbd "C-r") 'isearch-backward)

(global-set-key (kbd "M-r") 'replace-string)
(global-set-key (kbd "C-x C-r") 'query-replace)

(global-set-key (kbd "RET") 'newline-and-indent) ;return always indents
(global-set-key (kbd "C-/") 'dabbrev-expand) ;mimic M-/ for simplicity. C-_ is more convenient for undo anyways

;make manuevering keybindings vim-like.

;use M-x help to get to help instead of C-h
(defun vim ()
  (interactive)
  (global-set-key (kbd "C-j") 'next-line)
  (global-set-key (kbd "C-k") 'previous-line)
  (global-set-key (kbd "M-k") 'kill-line) ;presserve ability to kill line within vim-mode
  (global-set-key (kbd "C-h") 'backward-char)
  (global-set-key (kbd "C-l") 'forward-char)

  (global-unset-key (kbd "M-h")) ;unset from highlight-pargraph to allow for M-h to be an extension for later calls
  (global-set-key (kbd "M-h k") 'describe-key)
  (global-set-key (kbd "M-h t") 'help-with-tutorial)
  (global-set-key (kbd "M-h M-h") 'help-for-help)
  (global-set-key (kbd "M-h b") 'describe-bindings)
  (global-set-key (kbd "M-h f") 'describe-function)
  ;(global-set-key (kbd "M-h ") )
  
  (global-unset-key (kbd "C-p"))
  (global-unset-key (kbd "C-n"))
  (global-unset-key (kbd "C-f"))
  (global-unset-key (kbd "C-b"))
)
;(vim) ;enable vim-like manuevering

(defun lisp-repl ()
  (interactive)
  (ielm)
  )

(global-set-key (kbd "M-a") 'beginning-of-line-text)
(global-set-key (kbd "M-e") 'end-of-line-text)
(global-set-key (kbd "C-M-a") 'beginning-of-line)
(global-set-key (kbd "M-_") 'undo)
(global-set-key (kbd "M-k") (lambda () (interactive) (kill-line 0)))



(global-set-key (kbd "M-l") 'goto-line) ;;just use M-g M-g
;this doesn't actually work as it should
(defun redo ()
    (interactive)
    (forward-char)
    (undo)
    (backward-char)
      ;;; place your code below this line, but inside the bracket.
      )


(global-set-key (kbd "M-_") 'redo)

(transient-mark-mode "orange") ;Always use highlight mode for selecting a region

(show-paren-mode 1) ;Show closed paren when near open and vice versa

(setq gtk_selection_bg_color 'orange)

(set-face-foreground 'modeline "orange")
(set-face-background 'region "yellow")

;Set Ido mode on (autocompletion and other things
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(kill-buffer "*scratch*") ;remove *scratch* buffer by default

;; Enable mouse support in terminal
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                               (interactive)
                               (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                               (interactive)
                               (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
  )

;; mouse support in osx terminal
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))
(setq mouse-sel-mode t)


;; follow symlinks to version controlled files without confirmation
(setq vc-follow-symlinks t)

;; enable kill ring to interact with osx clipboard. get pb copy from:
;; git clone git://gist.github.com/1023272.git gist-1023272
;; then copy pbcopy to .emacs.d
(add-to-list 'load-path "~/.emacs.d/pbcopy/")
(require 'pbcopy)
(turn-on-pbcopy)

(menu-bar-mode -1)
