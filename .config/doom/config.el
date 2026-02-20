;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-



;; About me
(setq user-full-name "Wojciech Sadowski"
      user-mail-address "wojciech1sadowski@gmail.com")

;; Theme
(setq doom-theme 'catppuccin)

;; Fonts
(setq chosen-font "JetBrainsMono Nerd Font Mono")
(setq doom-modeline-height 1)
(setq doom-font (font-spec :family chosen-font :size 20 )
      ;; doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font Propo" :size 20)
      )

(set-face-attribute 'mode-line nil :family chosen-font :height 150)
(set-face-attribute 'mode-line-inactive nil :family chosen-font :height 150)

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  )

;; Code: line numebring
(setq display-line-numbers-type 'relative)


;; Code: Odin
(use-package! odin-ts-mode
  :mode "\\.odin\\'")

(after! treesit
  (add-to-list 'treesit-language-source-alist
               '(odin "https://github.com/tree-sitter-grammars/tree-sitter-odin")))

;; (add-hook 'odin-ts-mode-hook #'eglot-ensure)
(add-hook 'odin-ts-mode-hook #'lsp-deferred) ;; If you're using the TS mode
(add-hook 'odin-ts-mode-hook (lambda ()
                               (setq js-indent-level 2
                                     indent-bars-spacing-override 2
                                     indent-bars-treesit-support t)
                               )
          )

(setq lsp-odin-ols-binary-path "~/Programs/ols/ols")

(with-eval-after-load 'odin-ts-mode
  (set-formatter! 'odinfmt '("odinfmt" filepath) :modes '(odin-ts-mode))
  )


;; Org mode
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Keymap
(map! :leader "e" #'dired)

(setq +latex-viewers '(pdf-tools))
(setq +latex-viewers '(zathura))
;; (setq lsp-tex-server 'digestif)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
