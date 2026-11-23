.PHONY: build clean help tei2slide xsltforms

SAXON := java -jar ~/programs/saxon12/saxon-he-12.10.jar
SRC_DIR := src
TEMP_DIR := temp
OUTPUT_DIR := public
ASSETS_DIR := assets
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
	@echo "  clean			- Remove the temporary directory"
	@echo "  build			- tei2slide + xsltforms + clean + copy assets to public"

tei2slide:
	@echo "tei2slide: Transform $(SOURCE_XML) with $(TEI2SLIDE_XSL)..."
	@mkdir -p $(TEMP_DIR)
	$(SAXON) -xsl:$(TEI2SLIDE_XSL) -s:$(SOURCE_XML) outputDir=$(TEMP_DIR)
	@echo "tei2slide done!"

xsltforms: 
	@echo "xsltforms: Transform .xhtml files into .html"
	@mkdir -p $(OUTPUT_DIR)
	@set -e; found=0; \
	for xhtml_file in $(TEMP_DIR)/*.xhtml; do \
		[ -f "$$xhtml_file" ] || continue; \
		found=1; \
		html_file="$${xhtml_file##*/}"; \
		html_file="$(OUTPUT_DIR)/$${html_file%.xhtml}.html"; \
		echo "  Transforming: $$xhtml_file → $$html_file"; \
		$(SAXON) -xsl:$(XSLTFORMS_XSL) -s:"$$xhtml_file" -o:"$$html_file"; \
	done; \
	if [ "$$found" -eq 0 ]; then \
		echo "No XHTML files found in $(TEMP_DIR); run make tei2slide first." >&2; \
		exit 1; \
	fi
	@echo "xsltforms done!"

build: tei2slide xsltforms clean
	@mkdir -p $(OUTPUT_DIR)/assets
	cp -R $(ASSETS_DIR)/. $(OUTPUT_DIR)/assets/
	@echo "Build done!"

clean:
	@echo "Removing temp"
	@rm -rf temp
	@echo "clean done!"
