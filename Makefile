SRC=xv6-riscv-src/

T=latex.out

TEX=$(patsubst %,$(T)/%,$(wildcard *.tex))
SPELLTEX=$(wildcard *.tex)

all: book.pdf
.PHONY: all src clean

$(T)/%.tex: %.tex | src
	mkdir -p latex.out
	./lineref $(notdir $@) $(SRC)  xv6-riscv-src-booklet/fmt > $@

src:
	if [ ! -d $(SRC) ]; then \
		git clone https://github.com/mit-pdos/xv6-riscv.git $(SRC) ; \
		git -C $(SRC) checkout xv6-riscv-rev5 ; \
	else \
		git -C $(SRC) fetch --tags ; \
		git -C $(SRC) checkout xv6-riscv-rev5 ; \
	fi; \
	true

booklet: src
	(cd xv6-riscv-src-booklet; make)
	mv xv6-riscv-src-booklet/xv6-src-booklet.pdf .

book.pdf: booklet book.tex $(TEX)
	xelatex book.tex
	bibtex book
	xelatex book.tex
	xelatex book.tex


lineref: $(TEX) booklet
	echo done

clean:
	rm -f book.aux book.idx book.ilg book.ind book.log\
	 	book.toc book.bbl book.blg book.out
	rm -rf latex.out
	rm -rf $(SRC)

spell:
	@ for i in $(SPELLTEX); do aspell --mode=tex -p ./aspell.words -c $$i; done
	@ for i in $(SPELLTEX); do perl bin/double.pl $$i; done
	@ for i in $(SPELLTEX); do perl bin/capital.py $$i; done
	@ ( head -1 aspell.words ; tail -n +2 aspell.words | sort ) > aspell.words~
	@ mv aspell.words~ aspell.words
