;;; arbfp-mode-el -- Major mode for editing !!Arbfp1.0 files

;; Author: hacklberry <hacklberry@hacklberry.net>
;; Created: 26 Sep 2005
;; Keywords: !!ARBfp1.0 major-mode

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

(defvar arbfp-mode-hook nil)

(add-to-list 'auto-mode-alist '("\\.arbfp\\'" . arbfp-mode))

(defconst arbfp-font-lock-keywords
  (list
   ;"!!ARBfp1.0" "ABS" "ABS_SAT" "ADD" "ADD_SAT" "ALIAS" "ATTRIB" "CMP" "CMP_SAT" "COS"
   ;"COS_SAT" "DP3" "DP3_SAT" "DP4" "DP4_SAT" "DPH" "DPH_SAT" "DST" "DST_SAT" 
   ;"END" "EX2" "EX2_SAT" "FLR" "FLR_SAT" "FRC" "FRC_SAT" "KIL" "LG2" 
   ;"LG2_SAT" "LIT" "LIT_SAT" "LRP" "LRP_SAT" "MAD" "MAD_SAT" "MAX" "MAX_SAT" 
   ;"MIN" "MIN_SAT" "MOV" "MOV_SAT" "MUL" "MUL_SAT" "OPTION" "OUTPUT" "PARAM" 
   ;"POW" "POW_SAT" "RCP" "RCP_SAT" "RSQ" "RSQ_SAT" "SIN" "SIN_SAT" "SCS" 
   ;"SCS_SAT" "SGE" "SGE_SAT" "SLT" "SLT_SAT" "SUB" "SUB_SAT" "SWZ" "SWZ_SAT" 
   ;"TEMP" "TEX" "TEX_SAT" "TXB" "TXB_SAT" "TXP" "TXP_SAT" "XPD" "XPD_SAT" 
   ;"fragment" "program" "result" "state" "texture"

   '("\\(!!ARBfp1\\.0\\|1D\\|2D\\|A\\(?:BS\\(?:_SAT\\)?\\|DD\\(?:_SAT\\)?\\|LIAS\\|TTRIB\\)\\|BRK\\|C\\(?:AL\\|MP\\(?:_SAT\\)?\\|OS\\(?:_SAT\\)?\\|UBE\\)\\|D\\(?:IV\\|P\\(?:2A\\|[34H]_SAT\\|[234H]\\)\\|ST\\(?:_SAT\\)?\\)\\|E\\(?:LSE\\|ND\\(?:IF\\|\\(?:LOO\\|RE\\)P\\)?\\|X2\\(?:_SAT\\)?\\)\\|F\\(?:LR\\(?:_SAT\\)?\\|RC\\(?:_SAT\\)?\\)\\|IF\\|KIL\\|L\\(?:G2\\(?:_SAT\\)?\\|IT\\(?:_SAT\\)?\\|OOP\\|RP\\(?:_SAT\\)?\\)\\|M\\(?:A\\(?:[DX]_SAT\\|[DX]\\)\\|IN\\(?:_SAT\\)?\\|OV\\(?:_SAT\\)?\\|UL\\(?:_SAT\\)?\\)\\|N\\(?:RM\\|V_fragment_program2\\)\\|O\\(?:PTION\\|UTPUT\\)\\|P\\(?:ARAM\\|OW\\(?:_SAT\\)?\\)\\|R\\(?:CP\\(?:_SAT\\)?\\|E[PT]\\|SQ\\(?:_SAT\\)?\\)\\|S\\(?:CS\\(?:_SAT\\)?\\|GE\\(?:_SAT\\)?\\|IN\\(?:_SAT\\)?\\|LT\\(?:_SAT\\)?\\|UB\\(?:_SAT\\)?\\|WZ\\(?:_SAT\\)?\\)\\|T\\(?:E\\(?:MP\\|X\\(?:_SAT\\)?\\)\\|X\\(?:[BP]_SAT\\|[BLP]\\)\\)\\|XPD\\(?:_SAT\\)?\\|fragment\\|program\\|result\\|\\(?:stat\\|textur\\)e\\)" . font-lock-builtin-face)

   )
  "Minimal highlighting expressions for !!ARBfp1.0 mode.")

(defconst arbfp-font-lock-keywords-nvidia
  (append arbfp-font-lock-keywords
	  (list
	   ; "BRK" "CAL" "DIV" "DP2" "DP2A" "ELSE" "ENDIF" "ENDLOOP" 
	   ; "ENDREP" "IF" "LOOP" "NRM" "REP" "RET" "TXL"
	   '("\\(BRK\\|CAL\\|D\\(?:IV\\|P2A?\\)\\|E\\(?:LSE\\|ND\\(?:IF\\|\\(?:LOO\\|RE\\)P\\)\\)\\|IF\\|LOOP\\|N\\(?:RM\\|V_fragment_program2\\)\\|RE[PT]\\|TXL\\)" . font-lock-builtin-face) ;font-lock-keyword-face)
        ))
  "NV_fragment_program2")

(defvar arbfp-mode-syntax-table
  (let ((arbfp-mode-syntax-table (make-syntax-table)))
					; Comment styles are same as bash or python
    (modify-syntax-entry ?# "<" arbfp-mode-syntax-table)
    (modify-syntax-entry ?\n ">" arbfp-mode-syntax-table)
    arbfp-mode-syntax-table)
  "Syntax table for arbfp-mode")

(defun arbfp-mode ()
  (interactive)
  (kill-all-local-variables)
  ;;(use-local-map arbfp-mode-map)
  (set-syntax-table arbfp-mode-syntax-table)
  ;; Set up font-lock
  (set (make-local-variable 'font-lock-defaults) '(arbfp-font-lock-keywords)) ;arbfp-font-lock-keywords
  (setq major-mode 'arbfp-mode)
  (setq mode-name "!!ARBfp1.0")
  (run-hooks 'arbfp-mode-hook))

(provide 'arbfp-mode)
