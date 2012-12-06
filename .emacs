;; -*- mode: emacs-lisp; -*-

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-modes (quote (emacs-lisp-mode lisp-interaction-mode c-mode cc-mode c++-mode java-mode scheme-mode python-mode ruby-mode js2-mode ecmascript-mode javascript-mode js-mode css-mode makefile-mode xml-mode sgml-mode)))
 '(blink-cursor-mode nil)
 '(case-fold-search nil)
 '(codepad-autoset-mode nil)
 '(codepad-run (quote ask))
 '(codepad-view nil)
 '(column-number-mode t)
 '(compilation-auto-jump-to-first-error t)
 '(compilation-scroll-output t)
 '(compilation-start-hook (quote nil))
 '(debug-on-error t)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(erc-generate-log-file-name-function (quote erc-generate-log-file-name-long))
 '(erc-hide-list (quote ("JOIN" "NICK" "PART" "QUIT" "MODE")))
 '(erc-log-channels-directory "~/.erc/logs")
 '(erc-log-insert-log-on-open nil)
 '(erc-log-mode t)
 '(erc-smiley-mode t)
 '(erc-speedbar-sort-users-type (quote alphabetical))
 '(erc-user-full-name "Martin Bohun")
 '(global-auto-revert-mode t)
 '(graphviz-dot-auto-indent-on-semi nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(ispell-program-name "aspell")
 '(jabber-display-menu nil)
 '(jabber-history-enabled t)
 '(js2-bounce-indent-p t)
 '(js2-cleanup-whitespace t)
 '(menu-bar-mode nil)
 '(next-error-highlight t)
 '(next-error-highlight-no-select t)
 '(next-error-recenter (quote (4)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(special-display-buffer-names (quote ("*compilation*")))
 '(tool-bar-mode nil))

;;
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "M-g")     'goto-line)

(load-library "time-stamp") ;TODO: load only when required?  

(setq frame-title-format "%F: %f")

;; custom packages
(setq pack-root "~/emacs_packages")
(add-to-list 'load-path (expand-file-name pack-root))

(defun load-path-append-subdir (dir)
  (add-to-list 'load-path 
	       (expand-file-name dir pack-root)))

(require 'whitespace)
;(require 'tabbar-ruler)

;; color theme
(load-path-append-subdir "color-theme")
(require 'color-theme)
(color-theme-initialize)
(color-theme-arjen)

;; auto-complete
(load-path-append-subdir "auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
	     "~/emacs_packages/auto-complete/dict")

;; (ac-config-default)
;; (add-hook 'emacs-lisp-mode-hook
;; 	  (lambda ()
;; 	    (setq ac-sources '(ac-source-words-in-buffer ac-source-symbols))))

;; erc - this needs proper setup
(erc-spelling-mode 1)
(erc-track-mode t)
(setq erc-track-exclude-types
      '("JOIN" "NICK" "PART" "QUIT" "MODE"
	"324"  "329"  "332"  "333"  "353"  "477"))

;; (add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)

(setq erc-prompt-for-nickserv-password nil)

(add-hook 'erc-after-connect
	  '(lambda (SERVER NICK)
	     (if (string-match "freenode\\.net" SERVER)
		 (progn (load "~/.erc/ercpass") ;freenode username/pass
			(let ((priv-msg (concat "NickServ identify " freenode-pass))
			      (roomz '("##chemistry"
				       "#erc"
				       "#muse")))
			  (erc-message "PRIVMSG" priv-msg)
			  ;;wait here before joining chatrooms
			  (sit-for 6 t)
			  (mapcar 'erc-cmd-JOIN roomz))))

	     (if (string-match "oz\\.org" SERVER)
		 (erc-cmd-JOIN "#autoverse"))))

(setq erc-autojoin-channels-alist
      '(;("au.oz.org" "#autoverse")
	;(cons "freenode.net" irc-channels-freenode)
	("undernet.org" "#autoverse")))

;;(erc :server "irc.freenode.net" :port 6667 :nick "mbohun")
;;(erc :server "irc.oz.org"       :port 6667 :nick "mbohun")
;;
;;(require 'erc-auto)

;; compile customisation + extensions
(require 'compile-bookmarks)
(compile-bookmarks-mode)

;; RCS git, bzr, hg, even svn & cvs - the choice of Neanderthal

;; latex, markups, dot, etc.

;; (add-to-list
;;  'auto-mode-alist
;;  (cons (concat "\\."
;; 	       (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss") t)
;; 	       "\\'") 'nxml-mode))

;; (setq magic-mode-alist 
;;       (cons '("<\\?xml " . nxml-mode)
;; 	    magic-mode-alist))

;; ;; alias - use nxml-mode instead of builtit? html-mode
;; (fset 'html-mode 'nxml-mode)
;; (fset 'xml-mode  'nxml-mode)

;; conf files ssh_conf, .muttrc, etc.

;; Set for mutt
;; .muttrc
;; (add-hook 'mail-mode-hook
;; 	  '(lambda mutt-mail-mode-hook ()
;; 	     (flush-lines "^\\(> \n\\)*> -- \n\\(\n?> .*\\)*") ; kill quoted sigs
;; 	     (not-modified)
;; 	     (mail-text)
;; 	     ;;(color-theme-xyz)
;; 	     (setq make-backup-files nil)))

;; (or (assoc "mutt-" auto-mode-alist)
;;     (setq auto-mode-alist (cons '("/tmp/mutt.*" . mail-mode) auto-mode-alist)))

;; .ssh/config

;; TAGS - project dependent
;; (setq tags-table-list '("~/src")) ; TODO: find or roll a nice dynamic version

(require 'etags-select)
(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)

;; programming languages modes

;; COMMON for all C- like langs - C, C++, java
(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (flyspell-prog-mode)
	     (font-lock-add-keywords
	      nil '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))

;; js
(load-path-append-subdir "js2-mode")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;(require 'js-comint)
;;(setq inferior-js-program-command "/usr/local/jdk/bin/java -jar /usr/local/rhino/js.jar")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
