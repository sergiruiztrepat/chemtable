;;; chemtable.el --- Periodic table of the elements -*- lexical-binding: t -*-
;; -*- coding: utf-8 -*-
;;
;; Copyright 2021 by Sergi Ruiz Trepat
;;
;; Author: Sergi Ruiz Trepat
;; Created: 2021
;; Version: 1.0
;; Keywords: convenience, chemistry
;; Homepage: https://github.com/sergiruiztrepat/chemtable
;; Package-Requires: ((emacs "24.1"))
;;
;; Chemtable is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3 of the License, or
;; (at your option) any later version.
;;
;;; Commentary:
;;
;; Periodic table of the elements
;;
;; Installation:
;;
;; After installing the package (or copying it to your load-path), add this
;; to your init file:
;;
;; (require 'chemtable)
;;
;; Use it with: M-x chemtable
;;
;; Please, email me your comments, bugs, improvements or opinions on
;; this package to sergi.ruiz.trepat@gmail.com
;;
;;; Code:

(require 'widget)

(defconst chemtable-data
'(
  ("H " 1 "Hydrogen" 1 1 1.008 0.00008988 14.01 20.28 14.304 2.20 1400 )
  ("He" 2 "Helium" 18 1 4.002602 0.0001785 "—" 4.22 5.193 "–" 0.008 )
  ("Li" 3 "Lithium" 1 2 6.94 0.534 453.69 1560 3.582 0.98 20 )
  ("Be" 4 "Beryllium" 2 2 9.0121831 1.85 1560 2742 1.825 1.57 2.8 )
  ("B " 5 "Boron" 13 2 10.81 2.34 2349 4200 1.026 2.04 10 )
  ("C " 6 "Carbon" 14 2 12.011 2.267 ">4000" 4300 0.709 2.55 200 )
  ("N " 7 "Nitrogen" 15 2 14.007 0.0012506 63.15 77.36 1.04 3.04 19 )
  ("O " 8 "Oxygen" 16 2 15.999 0.001429 54.36 90.20 0.918 3.44 461000 )
  ("F " 9 "Fluorine" 17 2 18.998403163 0.001696 53.53 85.03 0.824 3.98 585 )
  ("Ne" 10 "Neon" 18 2 20.1797 0.0008999 24.56 27.07 1.03 "–" 0.005 )
  ("Na" 11 "Sodium" 1 3 22.98976928 0.971 370.87 1156 1.228 0.93 23600 )
  ("Mg" 12 "Magnesium" 2 3 24.305 1.738 923 1363 1.023 1.31 23300 )
  ("Al" 13 "Aluminium" 13 3 26.9815384 2.698 933.47 2792 0.897 1.61 82300 )
  ("Si" 14 "Silicon" 14 3 28.085 2.3296 1687 3538 0.705 1.90 282000 )
  ("P " 15 "Phosphorus" 15 3 30.973761998 1.82 317.30 550 0.769 2.19 1050 )
  ("S " 16 "Sulfur" 16 3 32.06 2.067 388.36 717.87 0.71 2.58 350 )
  ("Cl" 17 "Chlorine" 17 3 35.45 0.003214 171.6 239.11 0.479 3.16 145 )
  ("Ar" 18 "Argon" 18 3 39.95 0.0017837 83.80 87.30 0.52 "–" 3.5 )
  ("K " 19 "Potassium" 1 4 39.0983 0.862 336.53 1032 0.757 0.82 20900 )
  ("Ca" 20 "Calcium" 2 4 40.078 1.54 1115 1757 0.647 1.00 41500 )
  ("Sc" 21 "Scandium" 3 4 44.955908 2.989 1814 3109 0.568 1.36 22 )
  ("Ti" 22 "Titanium" 4 4 47.867 4.54 1941 3560 0.523 1.54 5650 )
  ("V " 23 "Vanadium" 5 4 50.9415 6.11 2183 3680 0.489 1.63 120 )
  ("Cr" 24 "Chromium" 6 4 51.9961 7.15 2180 2944 0.449 1.66 102 )
  ("Mn" 25 "Manganese" 7 4 54.938043 7.44 1519 2334 0.479 1.55 950 )
  ("Fe" 26 "Iron" 8 4 55.845 7.874 1811 3134 0.449 1.83 56300 )
  ("Co" 27 "Cobalt" 9 4 58.933194 8.86 1768 3200 0.421 1.88 25 )
  ("Ni" 28 "Nickel" 10 4 58.6934 8.912 1728 3186 0.444 1.91 84 )
  ("Cu" 29 "Copper" 11 4 63.546 8.96 1357.77 2835 0.385 1.90 60 )
  ("Zn" 30 "Zinc" 12 4 65.38 7.134 692.88 1180 0.388 1.65 70 )
  ("Ga" 31 "Gallium" 13 4 69.723 5.907 302.9146 2673 0.371 1.81 19 )
  ("Ge" 32 "Germanium" 14 4 72.630 5.323 1211.40 3106 0.32 2.01 1.5 )
  ("As" 33 "Arsenic" 15 4 74.921595 5.776 1090 887 0.329 2.18 1.8 )
  ("Se" 34 "Selenium" 16 4 78.971 4.809 453 958 0.321 2.55 0.05 )
  ("Br" 35 "Bromine" 17 4 79.904 3.122 265.8 332.0 0.474 2.96 2.4 )
  ("Kr" 36 "Krypton" 18 4 83.798 0.003733 115.79 119.93 0.248 3.00 "1×10−4" )
  ("Rb" 37 "Rubidium" 1 5 85.4678 1.532 312.46 961 0.363 0.82 90 )
  ("Sr" 38 "Strontium" 2 5 87.62 2.64 1050 1655 0.301 0.95 370 )
  ("Y " 39 "Yttrium" 3 5 88.90584 4.469 1799 3609 0.298 1.22 33 )
  ("Zr" 40 "Zirconium" 4 5 91.224 6.506 2128 4682 0.278 1.33 165 )
  ("Nb" 41 "Niobium" 5 5 92.90637 8.57 2750 5017 0.265 1.6 20 )
  ("Mo" 42 "Molybdenum" 6 5 95.95 10.22 2896 4912 0.251 2.16 1.2 )
  ("Tc" 43 "Technetium" 7 5 "[98]" 11.5 2430 4538 "–" 1.9 "~3×10−9" )
  ("Ru" 44 "Ruthenium" 8 5 101.07 12.37 2607 4423 0.238 2.2 0.001 )
  ("Rh" 45 "Rhodium" 9 5 102.90549 12.41 2237 3968 0.243 2.28 0.001 )
  ("Pd" 46 "Palladium" 10 5 106.42 12.02 1828.05 3236 0.244 2.20 0.015 )
  ("Ag" 47 "Silver" 11 5 107.8682 10.501 1234.93 2435 0.235 1.93 0.075 )
  ("Cd" 48 "Cadmium" 12 5 112.414 8.69 594.22 1040 0.232 1.69 0.159 )
  ("In" 49 "Indium" 13 5 114.818 7.31 429.75 2345 0.233 1.78 0.25 )
  ("Sn" 50 "Tin" 14 5 118.710 7.287 505.08 2875 0.228 1.96 2.3 )
  ("Sb" 51 "Antimony" 15 5 121.760 6.685 903.78 1860 0.207 2.05 0.2 )
  ("Te" 52 "Tellurium" 16 5 127.60 6.232 722.66 1261 0.202 2.1 0.001 )
  ("I " 53 "Iodine" 17 5 126.90447 4.93 386.85 457.4 0.214 2.66 0.45 )
  ("Xe" 54 "Xenon" 18 5 131.293 0.005887 161.4 165.03 0.158 2.60 "3×10−5" )
  ("Cs" 55 "Caesium" 1 6 132.90545196 1.873 301.59 944 0.242 0.79 3 )
  ("Ba" 56 "Barium" 2 6 137.327 3.594 1000 2170 0.204 0.89 425 )
  ("La" 57 "Lanthanum"  6 138.90547 6.145 1193 3737 0.195 1.1 39 )
  ("Ce" 58 "Cerium"  6 140.116 6.77 1068 3716 0.192 1.12 66.5 )
  ("Pr" 59 "Praseodymium"  6 140.90766 6.773 1208 3793 0.193 1.13 9.2 )
  ("Nd" 60 "Neodymium"  6 144.242 7.007 1297 3347 0.19 1.14 41.5 )
  ("Pm" 61 "Promethium"  6 "[145]" 7.26 1315 3273 "–" 1.13 "2×10−19" )
  ("Sm" 62 "Samarium"  6 150.36 7.52 1345 2067 0.197 1.17 7.05 )
  ("Eu" 63 "Europium"  6 151.964 5.243 1099 1802 0.182 1.2 2 )
  ("Gd" 64 "Gadolinium"  6 157.25 7.895 1585 3546 0.236 1.2 6.2 )
  ("Tb" 65 "Terbium"  6 158.925354 8.229 1629 3503 0.182 1.2 1.2 )
  ("Dy" 66 "Dysprosium"  6 162.500 8.55 1680 2840 0.17 1.22 5.2 )
  ("Ho" 67 "Holmium"  6 164.930328 8.795 1734 2993 0.165 1.23 1.3 )
  ("Er" 68 "Erbium"  6 167.259 9.066 1802 3141 0.168 1.24 3.5 )
  ("Tm" 69 "Thulium"  6 168.934218 9.321 1818 2223 0.16 1.25 0.52 )
  ("Yb" 70 "Ytterbium"  6 173.045 6.965 1097 1469 0.155 1.1 3.2 )
  ("Lu" 71 "Lutetium" 3 6 174.9668 9.84 1925 3675 0.154 1.27 0.8 )
  ("Hf" 72 "Hafnium" 4 6 178.49 13.31 2506 4876 0.144 1.3 3 )
  ("Ta" 73 "Tantalum" 5 6 180.94788 16.654 3290 5731 0.14 1.5 2 )
  ("W" 74 "Tungsten" 6 6 183.84 19.25 3695 5828 0.132 2.36 1.3 )
  ("Re" 75 "Rhenium" 7 6 186.207 21.02 3459 5869 0.137 1.9 "7×10−4" )
  ("Os" 76 "Osmium" 8 6 190.23 22.59 3306 5285 0.13 2.2 0.002 )
  ("Ir" 77 "Iridium" 9 6 192.217 22.56 2719 4701 0.131 2.20 0.001 )
  ("Pt" 78 "Platinum" 10 6 195.084 21.46 2041.4 4098 0.133 2.28 0.005 )
  ("Au" 79 "Gold" 11 6 196.966570 19.282 1337.33 3129 0.129 2.54 0.004 )
  ("Hg" 80 "Mercury" 12 6 200.592 13.5336 234.43 629.88 0.14 2.00 0.085 )
  ("Tl" 81 "Thallium" 13 6 204.38 11.85 577 1746 0.129 1.62 0.85 )
  ("Pb" 82 "Lead" 14 6 207.2 11.342 600.61 2022 0.129 "1.87(2+)" "2.33(4+)" 14 )
  ("Bi" 83 "Bismuth" 15 6 208.98040 9.807 544.7 1837 0.122 2.02 0.009 )
  ("Po" 84 "Polonium" 16 6 "[209]" 9.32 527 1235 "–" 2.0 "2×10−10" )
  ("At" 85 "Astatine" 17 6 "[210]" 7 575 610 "–" 2.2 "3×10−20" )
  ("Rn" 86 "Radon" 18 6 "[222]" 0.00973 202 211.3 0.094 2.2 "4×10−13" )
  ("Fr" 87 "Francium" 1 7 "[223]" 1.87 281 890 "–" >0.79 "~1×10−18" )
  ("Ra" 88 "Radium" 2 7 "[226]" 5.5 973 2010 0.094 0.9 "9×10−7" )
  ("Ac" 89 "Actinium"  7 "[227]" 10.07 1323 3471 0.12 1.1 "5.5×10−10" )
  ("Th" 90 "Thorium"  7 232.0377 11.72 2115 5061 0.113 1.3 9.6 )
  ("Pa" 91 "Protactinium"  7 231.03588 15.37 1841 4300 "–" 1.5 "1.4×10−6" )
  ("U " 92 "Uranium"  7 238.02891 18.95 1405.3 4404 0.116 1.38 2.7 )
  ("Np" 93 "Neptunium"  7 "[237]" 20.45 917 4273 "–" 1.36 "≤3×10−12" )
  ("Pu" 94 "Plutonium"  7 "[244]" 19.85 912.5 3501 "–" 1.28 "≤3×10−11" )
  ("Am" 95 "Americium"  7 "[243]" 13.69 1449 2880 "–" 1.13 0 )
  ("Cm" 96 "Curium"  7 "[247]" 13.51 1613 3383 "–" 1.28 0 )
  ("Bk" 97 "Berkelium"  7 "[247]" 14.79 1259 2900 "–" 1.3 0 )
  ("Cf" 98 "Californium"  7 "[251]" 15.1 1173 (1743) "–" 1.3 0 )
  ("Es" 99 "Einsteinium"  7 "[252]" 8.84 1133 (1269) "–" 1.3 0 )
  ("Fm" 100 "Fermium"  7 "[257]" "(9.7)" "(1125)" "–" "–" 1.3 0 )
  ("Md" 101 "Mendelevium"  7 "[258]" "(10.3)" "(1100)" "–" "–" 1.3 0 )
  ("No" 102 "Nobelium"  7 "[259]" "(9.9)" "(1100)" "–" "–" 1.3 0 )
  ("Lr" 103 "Lawrencium" 3 7 "[266]" "(15.6)" "(1900)" "–" "–" 1.3 0 )
  ("Rf" 104 "Rutherfordium" 4 7 "[267]" "(23.2)" "(2400)" "(5800)" "–" "–" 0 )
  ("Db" 105 "Dubnium" 5 7 "[268]" "(29.3)" "–" "–" "–" "–" 0 )
  ("Sg" 106 "Seaborgium" 6 7 "[269]" "(35.0)" "–" "–" "–" "–" 0 )
  ("Bh" 107 "Bohrium" 7 7 "[270]" "(37.1)" "–" "–" "–" "–" 0 )
  ("Hs" 108 "Hassium" 8 7 "[270]" "(40.7)" "–" "–" "–" "–" 0 )
  ("Mt" 109 "Meitnerium" 9 7 "[278]" "(37.4)" "–" "–" "–" "–" 0 )
  ("Ds" 110 "Darmstadtium" 10 7 "[281]" "(34.8)" "–" "–" "–" "–" 0 )
  ("Rg" 111 "Roentgenium" 11 7 "[282]" "(28.7)" "–" "–" "–" "–" 0 )
  ("Cn" 112 "Copernicium" 12 7 "[285]" "(14.0)" "(283)" "(340)" "–" "–" 0 )
  ("Nh" 113 "Nihonium" 13 7 "[286]" "(16)" "(700)" "(1400)" "–" "–" 0 )
  ("Fl" 114 "Flerovium" 14 7 "[289]" "(9.928)" "(200)" "(380)" "–" "–" 0 )
  ("Mc" 115 "Moscovium" 15 7 "[290]" "(13.5)" "(700)" "(1400)" "–" "–" 0 )
  ("Lv" 116 "Livermorium" 16 7 "[293]" "(12.9)" "(700)" "(1100)" "–" "–" 0 )
  ("Ts" 117 "Tennessine" 17 7 "[294]" "(7.2)" "(700)" "(883)" "–" "–" 0 )
  ("Og" 118 "Oganesson" 18 7 "[294]" "(7)" "(325)" "(450)" "–" "–" 0 )
  
  "List of elements and their data.

Symbol, atomic number, name, group, period, atomic weight, density,
melting point, boiling point, specific heat capacity,
electronegativity, abundance in Earth's crust.

All data from: https://en.wikipedia.org/wiki/List_of_chemical_elements"))

(defface chemtable-face
    '((t :family "Monospace"))
    "Buffer-local face created by `chemtable'."
    :group 'chemtable)
  
(defface chemtable-button-face-red
  ;; Copied from definition of `custom-button' in cus-edit.el
  '((((type x w32 ns) (class color))
     :box (:line-width 2 :style released-button)
     :background "indian red" :foreground "black"))
  "Face for s-block button created by `chemtable'."
  :group 'chemtable)

(defface chemtable-button-face-lightblue
  ;; Copied from definition of `custom-button' in cus-edit.el
  '((((type x w32 ns) (class color))
     :box (:line-width 2 :style released-button)
     :background "cyan" :foreground "black"))
  "Face for d-block button created by `chemtable'."
  :group 'chemtable)

(defface chemtable-button-face-yellow
  ;; Copied from definition of `custom-button' in cus-edit.el
  '((((type x w32 ns) (class color))
     :box (:line-width 2 :style released-button)
     :background "gold" :foreground "black"))
  "Face for p-block button created by `chemtable'."
  :group 'chemtable)

(defface chemtable-button-face-green
  ;; Copied from definition of `custom-button' in cus-edit.el
  '((((type x w32 ns) (class color))
     :box (:line-width 2 :style released-button)
     :background "spring green" :foreground "black"))
  "Face for f-block button created by `chemtable'."
  :group 'chemtable)

(defvar chemtable-default-background (face-attribute 'default :background)
  "Variable to take default background color.")

(defface chemtable-button-face-nil
  ;; Copied from definition of `custom-button' in cus-edit.el
  '((((type x w32 ns) (class color))
     :box (:line-width 2 :style released-button)
     :background chemtable-default-background))
  "Face for nil button created by `chemtable'.
Only to ensure alignment of table."
  :group 'chemtable)

(defun chemtable-show-data (element)
  "Show data of selected ELEMENT."
  (when element
    (message
     "%s\t Symbol: %s\t Atomic number: %s
Group: %s \t Period:%s\t Atomic weight: %s Da
Density: %s g/cm³\t Melting point: %s K\t Boiling point: %s K
Specific heat capacity: %s J/g·K\t\t Electronegativity: %s
Abundance in Earth's crust: %s mg/Kg"
     
     (nth 2 (assoc element chemtable-data))
     (nth 0 (assoc element chemtable-data))
     (nth 1 (assoc element chemtable-data))
     (nth 3 (assoc element chemtable-data))
     (nth 4 (assoc element chemtable-data))
     (nth 5 (assoc element chemtable-data))
     (nth 6 (assoc element chemtable-data))
     (nth 7 (assoc element chemtable-data))
     (nth 8 (assoc element chemtable-data))
     (nth 9 (assoc element chemtable-data))
     (nth 10 (assoc element chemtable-data))
     (nth 11 (assoc element chemtable-data)))))
     
(defun chemtable ()
  "Show chemtable buffer."
  (interactive)
  (let ((widget-push-button-prefix "")
	(widget-push-button-suffix "")
	(window-min-height 12)
	(window-min-width 60))
		
    (kill-buffer (get-buffer-create "*chemtable*"))
    (switch-to-buffer (get-buffer-create "*chemtable*"))
    (kill-all-local-variables)
    (buffer-face-set 'chemtable-face)
;;;
;; Buttons
;;;
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "H "))
		   :button-face 'chemtable-button-face-red "H ")
    (insert " ")
    
    (dotimes (_ 16)
      (widget-create 'push-button :notify (lambda (&rest _ignore)
					    (chemtable-show-data nil))
		     :button-face 'chemtable-button-face-nil "  ")
      (insert " "))

    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "He"))
		   :button-face 'chemtable-button-face-red "He")
    
    (insert "\n" )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Li"))
		   :button-face 'chemtable-button-face-red "Li")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Be"))
		   :button-face 'chemtable-button-face-red "Be")
    
    (insert " " )
    (dotimes (_ 10)
      (widget-create 'push-button :notify (lambda (&rest _ignore)
					    (chemtable-show-data nil))
		     :button-face 'chemtable-button-face-nil "  ")
      (insert " "))
    
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "B "))
		   :button-face 'chemtable-button-face-yellow "B ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "C "))
		   :button-face 'chemtable-button-face-yellow "C ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "N "))
		   :button-face 'chemtable-button-face-yellow "N ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "O "))
		   :button-face 'chemtable-button-face-yellow "O ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "F "))
		   :button-face 'chemtable-button-face-yellow "F ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ne"))
		   :button-face 'chemtable-button-face-yellow "Ne")
    
    (insert "\n" )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Na"))
		   :button-face 'chemtable-button-face-red "Na")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Mg"))
		   :button-face 'chemtable-button-face-red "Mg")

    (insert " " )
    (dotimes (_ 10)
      (widget-create 'push-button :notify (lambda (&rest _ignore)
					    (chemtable-show-data nil))
		     :button-face 'chemtable-button-face-nil "  ")
      (insert " "))
    
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Al"))
		   :button-face 'chemtable-button-face-yellow "Al")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Si"))
		   :button-face 'chemtable-button-face-yellow "Si")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "P "))
		   :button-face 'chemtable-button-face-yellow "P ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "S "))
		   :button-face 'chemtable-button-face-yellow "S ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Cl"))
		   :button-face 'chemtable-button-face-yellow "Cl")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ar"))
		   :button-face 'chemtable-button-face-yellow "Ar")
    
    (insert "\n" )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "K "))
		   :button-face 'chemtable-button-face-red "K ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ca"))
		   :button-face 'chemtable-button-face-red "Ca")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Sc"))
		   :button-face 'chemtable-button-face-lightblue "Sc")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ti"))
		   :button-face 'chemtable-button-face-lightblue "Ti")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "V "))
		   :button-face 'chemtable-button-face-lightblue "V ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Cr"))
		   :button-face 'chemtable-button-face-lightblue "Cr")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Mn"))
		   :button-face 'chemtable-button-face-lightblue "Mn")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Fe"))
		   :button-face 'chemtable-button-face-lightblue "Fe")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Co"))
		   :button-face 'chemtable-button-face-lightblue "Co")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ni"))
		   :button-face 'chemtable-button-face-lightblue "Ni")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Cu"))
		   :button-face 'chemtable-button-face-lightblue "Cu")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Zn"))
		   :button-face 'chemtable-button-face-lightblue "Zn")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ga"))
		   :button-face 'chemtable-button-face-yellow "Ga")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ge"))
		   :button-face 'chemtable-button-face-yellow "Ge")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "As"))
		   :button-face 'chemtable-button-face-yellow "As")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Se"))
		   :button-face 'chemtable-button-face-yellow "Se")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Br"))
		   :button-face 'chemtable-button-face-yellow "Br")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Kr"))
		   :button-face 'chemtable-button-face-yellow "Kr")
    
    (insert "\n" )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Rb"))
		   :button-face 'chemtable-button-face-red "Rb")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Sr"))
		   :button-face 'chemtable-button-face-red "Sr")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Y "))
		   :button-face 'chemtable-button-face-lightblue "Y ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Zr"))
		   :button-face 'chemtable-button-face-lightblue "Zr")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Nb"))
		   :button-face 'chemtable-button-face-lightblue "Nb")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Mo"))
		   :button-face 'chemtable-button-face-lightblue "Mo")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Tc"))
		   :button-face 'chemtable-button-face-lightblue "Tc")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ru"))
		   :button-face 'chemtable-button-face-lightblue "Ru")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Rh"))
		   :button-face 'chemtable-button-face-lightblue "Rh")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Pd"))
		   :button-face 'chemtable-button-face-lightblue "Pd")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ag"))
		   :button-face 'chemtable-button-face-lightblue "Ag")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Cd"))
		   :button-face 'chemtable-button-face-lightblue "Cd")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "In"))
		   :button-face 'chemtable-button-face-yellow "In")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Sn"))
		   :button-face 'chemtable-button-face-yellow "Sn")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Sb"))
		   :button-face 'chemtable-button-face-yellow "Sb")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Te"))
		   :button-face 'chemtable-button-face-yellow "Te")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "I "))
		   :button-face 'chemtable-button-face-yellow "I ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Xe"))
		   :button-face 'chemtable-button-face-yellow "Xe")
    
    (insert "\n" )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Cs"))
		   :button-face 'chemtable-button-face-red "Cs")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ba"))
		   :button-face 'chemtable-button-face-red "Ba")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Lu"))
		   :button-face 'chemtable-button-face-lightblue "Lu")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Hf"))
		   :button-face 'chemtable-button-face-lightblue "Hf")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ta"))
		   :button-face 'chemtable-button-face-lightblue "Ta")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "W "))
		   :button-face 'chemtable-button-face-lightblue "W ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Re"))
		   :button-face 'chemtable-button-face-lightblue "Re")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Os"))
		   :button-face 'chemtable-button-face-lightblue "Os")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ir"))
		   :button-face 'chemtable-button-face-lightblue "Ir")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Pt"))
		   :button-face 'chemtable-button-face-lightblue "Pt")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Au"))
		   :button-face 'chemtable-button-face-lightblue "Au")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Hg"))
		   :button-face 'chemtable-button-face-lightblue "Hg")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Tl"))
		   :button-face 'chemtable-button-face-yellow "Tl")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Pb"))
		   :button-face 'chemtable-button-face-yellow "Pb")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Bi"))
		   :button-face 'chemtable-button-face-yellow "Bi")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Po"))
		   :button-face 'chemtable-button-face-yellow "Po")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "At"))
		   :button-face 'chemtable-button-face-yellow "At")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Rn"))
		   :button-face 'chemtable-button-face-yellow "Rn")
    
    (insert "\n" )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Fr"))
		   :button-face 'chemtable-button-face-red "Fr")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ra"))
		   :button-face 'chemtable-button-face-red "Ra")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Lr"))
		   :button-face 'chemtable-button-face-lightblue "Lr")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Rf"))
		   :button-face 'chemtable-button-face-lightblue "Rf")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Db"))
		   :button-face 'chemtable-button-face-lightblue "Db")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Sg"))
		   :button-face 'chemtable-button-face-lightblue "Sg")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Bh"))
		   :button-face 'chemtable-button-face-lightblue "Bh")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Hs"))
		   :button-face 'chemtable-button-face-lightblue "Hs")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Mt"))
		   :button-face 'chemtable-button-face-lightblue "Mt")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ds"))
		   :button-face 'chemtable-button-face-lightblue "Ds")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Rg"))
		   :button-face 'chemtable-button-face-lightblue "Rg")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Cn"))
		   :button-face 'chemtable-button-face-lightblue "Cn")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Nh"))
		   :button-face 'chemtable-button-face-yellow "Nh")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Fl"))
		   :button-face 'chemtable-button-face-yellow "Fl")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Mc"))
		   :button-face 'chemtable-button-face-yellow "Mc")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Lv"))
		   :button-face 'chemtable-button-face-yellow "Lv")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ts"))
		   :button-face 'chemtable-button-face-yellow "Ts")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Og"))
		   :button-face 'chemtable-button-face-yellow "Og")
    (insert "\n" )
    (dotimes (_ 2)
      (widget-create 'push-button :notify (lambda (&rest _ignore)
					    (chemtable-show-data nil))
		     :button-face 'chemtable-button-face-nil "  ")
      (insert " "))
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "La"))
		   :button-face 'chemtable-button-face-green "La")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ce"))
		   :button-face 'chemtable-button-face-green "Ce")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Pr"))
		   :button-face 'chemtable-button-face-green "Pr")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Nd"))
		   :button-face 'chemtable-button-face-green "Nd")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Pm"))
		   :button-face 'chemtable-button-face-green "Pm")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Sm"))
		   :button-face 'chemtable-button-face-green "Sm")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Eu"))
		   :button-face 'chemtable-button-face-green "Eu")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Gd"))
		   :button-face 'chemtable-button-face-green "Gd")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Tb"))
		   :button-face 'chemtable-button-face-green "Tb")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Dy"))
		   :button-face 'chemtable-button-face-green "Dy")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ho"))
		   :button-face 'chemtable-button-face-green "Ho")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Er"))
		   :button-face 'chemtable-button-face-green "Er")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Tm"))
		   :button-face 'chemtable-button-face-green "Tm")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Yb"))
		   :button-face 'chemtable-button-face-green "Yb")
    (insert " " )
    (dotimes (_ 2)
      (widget-create 'push-button :notify (lambda (&rest _ignore)
					    (chemtable-show-data nil))
		     :button-face 'chemtable-button-face-nil "  ")
      (insert " "))
    (insert "\n" )
    (dotimes (_ 2)
      (widget-create 'push-button :notify (lambda (&rest _ignore)
					    (chemtable-show-data nil))
		     :button-face 'chemtable-button-face-nil "  ")
      (insert " "))
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Ac"))
		   :button-face 'chemtable-button-face-green "Ac")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Th"))
		   :button-face 'chemtable-button-face-green "Th")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Pa"))
		   :button-face 'chemtable-button-face-green "Pa")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "U "))
		   :button-face 'chemtable-button-face-green "U ")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Np"))
		   :button-face 'chemtable-button-face-green "Np")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Pu"))
		   :button-face 'chemtable-button-face-green "Pu")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Am"))
		   :button-face 'chemtable-button-face-green "Am")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Cm"))
		   :button-face 'chemtable-button-face-green "Cm")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Bk"))
		   :button-face 'chemtable-button-face-green "Bk")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Cf"))
		   :button-face 'chemtable-button-face-green "Cf")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Es"))
		   :button-face 'chemtable-button-face-green "Es")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Fm"))
		   :button-face 'chemtable-button-face-green "Fm")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "Md"))
		   :button-face 'chemtable-button-face-green "Md")
    
    (insert " " )
    (widget-create 'push-button :notify (lambda (&rest _ignore)
					  (chemtable-show-data "No"))
		   :button-face 'chemtable-button-face-green "No")
    
    (insert " " )
        
    (dotimes (_ 2)
      (widget-create 'push-button :notify (lambda (&rest _ignore)
					    (chemtable-show-data nil))
		     :button-face 'chemtable-button-face-nil "  ")
      (insert " "))

    (use-local-map widget-keymap)
    (widget-setup)
    (goto-char (point-min))))


(provide 'chemtable)

;;; chemtable.el ends here