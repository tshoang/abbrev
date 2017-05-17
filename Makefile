default: abbrev.pdf sample-abbrev.pdf

abbrev.pdf: abbrev.sty
	pdflatex abbrev.dtx
	makeindex -s gglo.ist -o abbrev.gls abbrev.glo
	makeindex -s gind.ist -o abbrev.ind abbrev.idx
	pdflatex abbrev.dtx

abbrev.sty: abbrev.ins abbrev.dtx
	pdflatex abbrev.ins

sample-abbrev.pdf: sample-abbrev.tex sample-main.tex abbrev.sty
	pdflatex sample-abbrev.tex
	makeindex sample-abbrev.nlo  -s nomencl.ist -o sample-abbrev.nls
	pdflatex sample-abbrev.tex
	pdflatex sample-abbrev.tex

clean:
	rm -f *.aux abbrev.glo abbrev.gls abbrev.idx abbrev.ilg abbrev.ind sample-abbrev.ilg *.log sample-abbrev.nlo sample-abbrev.nls abbrev.toc

cleanall: clean
	rm -f abbrev.pdf abbrev.sty sample-abbrev.pdf

