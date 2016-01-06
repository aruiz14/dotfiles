;;; packages.el --- groovy Layer packages File for Spacemacs
;;
;; URL: https://github.com/syl20bnr/spacemacs/pull/3206
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq groovy-packages
      '(
        company
        groovy-mode
        flycheck
        ))

(defun groovy/post-init-company ()
    (add-hook 'groovy-mode-hook 'company-mode))

(defun groovy/init-groovy-mode ()
  (use-package groovy-mode
    :defer t
    :mode ("\\.groovy\\'" . groovy-mode)
    :init
    (progn
      (setq c-basic-offset 4))))

(defun groovy/post-init-flycheck ()
    (add-hook 'groovy-mode-hook 'flycheck-mode))
