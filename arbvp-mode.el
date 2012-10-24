;;; arbvp-mode-el -- Major mode for editing !!ARBvp1.0 files

;; Author: hacklberry <hacklberry@hacklberry.net>
;; Created: 26 Sep 2005
;; Keywords: !!ARBvp1.0 major-mode

;; Copyright (C) 2005 hacklberry <hacklberry@hacklberry.net>

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

(defvar arbvp-mode-hook nil)

(add-to-list 'auto-mode-alist '("\\.arbvp\\'" . arbvp-mode))

(defconst arbvp-font-lock-keywords ;;-1
  (list
   ; "!!ARBvp1.0" "ABS" "ADD" "ADDRESS" "ALIAS" "ARL" "ATTRIB" "DP3" "DP4" "DPH"
   ; "DST" "END" "EX2" "EXP" "FLR" "FRC" "LG2" "LIT" "LOG" "MAD" "MAX" "MIN" "MOV" "MUL" 
   ; "OPTION" "OUTPUT" "PARAM" "POW" "RCP" "RSQ" "SGE" "SLT" "SUB" "SWZ" "TEMP" "XPD"
   ; "program" "result" "state" "vertex"
   
   '("\\(!!ARBvp1\\.0\\|A\\(?:BS\\|DD\\(?:RESS\\)?\\|LIAS\\|RL\\|TTRIB\\)\\|D\\(?:P[34H]\\|ST\\)\\|E\\(?:ND\\|X[2P]\\)\\|F\\(?:LR\\|RC\\)\\|L\\(?:G2\\|IT\\|OG\\)\\|M\\(?:A[DX]\\|IN\\|OV\\|UL\\)\\|O\\(?:PTION\\|UTPUT\\)\\|P\\(?:ARAM\\|OW\\)\\|R\\(?:CP\\|SQ\\)\\|S\\(?:GE\\|LT\\|UB\\|WZ\\)\\|TEMP\\|XPD\\|program\\|result\\|state\\|vertex\\)" . font-lock-builtin-face)
   ;'("\\('\\w*'\\)" . font-lock-variable-name-face)
   )
  "Minimal highlighting expressions for !!ARBvp1.0 mode.")

(defvar arbvp-mode-syntax-table
  (let ((arbvp-mode-syntax-table (make-syntax-table)))
					; Comment styles are same as bash or python
    (modify-syntax-entry ?# "<" arbvp-mode-syntax-table)
    (modify-syntax-entry ?\n ">" arbvp-mode-syntax-table)
    arbvp-mode-syntax-table)
  "Syntax table for arbvp-mode")

(defun arbvp-mode ()
  (interactive)
  (kill-all-local-variables)
  ;;(use-local-map arbvp-mode-map)
  (set-syntax-table arbvp-mode-syntax-table)
  ;; Set up font-lock
  (set (make-local-variable 'font-lock-defaults) '(arbvp-font-lock-keywords))
  ;; Register our indentation function
  ;;(set (make-local-variable 'indent-line-function) 'arbvp-indent-line)  
  (setq major-mode 'arbvp-mode)
  (setq mode-name "!!ARBvp1.0")
  (run-hooks 'arbvp-mode-hook))

(provide 'arbvp-mode)

