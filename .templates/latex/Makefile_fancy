#!/usr/bin/make -f
LATEX  = pdflatex
BIBTEX = bibtex
DVIPDF = dvipdf

#DVIPDF_OPTS=-dPDFSETTINGS=/printer

source = document


# fonction qui build le texte au complet
# avec les indexes et tout.
#
define build-pdf
	$(LATEX) $(source).tex
#	$(BIBTEX) $(source)
	$(LATEX) $(source).tex
endef



# Cycle a travers tous les targets
#
all:    $(source).tex
	$(call build-pdf)

checkindex:

	@cut -b 13- < $(source).idx \
	| sed s/}{[0-9]*}//g \
	| cut -d\| -f 1 \
	| sort --ignore-case --unique \
	> $(source).unique.idx


clean:
	find . \
		\( -name '*.aux' \
		-o -name '*.bbl' \
		-o -name '*.blg' \
		-o -name '*.lof' \
		-o -name '*.log' \
		-o -name '*.lot' \
		-o -name '*.toc' \
		-o -name '*.glo' \
		-o -name '*.fls' \
		-o -name '*.nav' \
		-o -name '*.out' \
		-o -name '*.snm' \
		-o -name '*.fdb_latexmk' \
		-o -name '*.synctex.gz' \
		-o -name '*.dvi' \) -delete
