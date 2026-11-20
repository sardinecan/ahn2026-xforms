.PHONY: build clean help

SAXON := java -jar ~/programs/saxon12/saxon-he-12.10.jar
SRC_DIR := src
BUILD_DIR := build
XSLTFORMS_DIR := assets/xsltforms

SOURCE_XML := $(SRC_DIR)/xforms.xml
TEI2SLIDE_XSL := $(SRC_DIR)/tei2slide.xsl
XSLTFORMS_XSL := $(XSLTFORMS_DIR)/xsltforms.xsl

help:
	@echo "Usage:"
	@echo "  make <target>"
	@echo "Makefile targets:"
	@echo "  tei2slide		- Apply tei2slide stylesheet to source file"
	@echo "  xsltforms		- Apply xsltforms stylesheet to xhtml files produced with tei2slide"
	@echo "  clean			- Remove all .xhtml temporary files"
	@echo "  build			- tei2slide + xsltforms + clean"

tei2slide:
	@echo "tei2slide: Transform $(SOURCE_XML) with $(TEI2SLIDE_XSL)..."
	$(SAXON) -xsl:$(TEI2SLIDE_XSL) -s:$(SOURCE_XML)
	@echo "tei2slide done!"

xsltforms: 
	@echo "xsltforms: Transform .xhtml files into .html"
	@for xhtml_file in $(BUILD_DIR)/*.xhtml; do \
		if [ -f "$$xhtml_file" ]; then \
			html_file="$$(echo "$$xhtml_file" | sed 's/\.xhtml$$/\.html/')"; \
			echo "  Transforming: $$xhtml_file → $$html_file"; \
			$(SAXON) -xsl:$(XSLTFORMS_XSL) -s:"$$xhtml_file" -o:"$$html_file"; \
		fi \
	done
	@echo "xsltforms done!"

build: tei2slide xsltforms clean
	@echo "Build done!"

clean:
	@echo "Removing .xhtml files in $(BUILD_DIR)"
	@rm -f $(BUILD_DIR)/*.xhtml
	@echo "clean done!"
