all: clean
	markdown2impress.pl index.md
	perl -i -pe 's{google-code-prettify}{../../google-code-prettify}' index.html
	cat black.css >> css/impress.css

clean:
	rm -rf css/ js/ *.js index.html
