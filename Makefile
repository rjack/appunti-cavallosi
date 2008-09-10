UTILS_DIR=utils

XHTML_XSL=$(UTILS_DIR)/docbook-xsl/xhtml-1_1/docbook.xsl
FO_XSL=$(UTILS_DIR)/docbook-xsl/fo/docbook.xsl

#SCHEMA_OPT=--relaxng $(UTILS_DIR)/docbook-rng/docbook.rng
SCHEMA_OPT=--schema $(UTILS_DIR)/docbook-xsd/docbook.xsd

XML_FILE=appunti_cavallo.xml
XHTML_FILE=appunti_cavallo.xhtml
CSS_FILE=appunti_cavallo.css
FO_FILE=appunti_cavallo.fo
PDF_FILE=appunti_cavallo.pdf


.PHONY		: all bootstrap $(UTILS_DIR) valid html pdf clean distclean


all		: valid html pdf


bootstrap	: $(UTILS_DIR)


valid		: $(XML_FILE)
	xmllint --noout $(SCHEMA_OPT) $(XML_FILE)


html		: $(XHTML_FILE)


pdf		: $(FO_FILE)


$(UTILS_DIR)	:
	$(MAKE) -C $(UTILS_DIR)


$(XHTML_FILE)	: valid $(XML_FILE)
	xsltproc --stringparam html.stylesheet $(CSS_FILE)  $(XHTML_XSL) $(XML_FILE) > $(XHTML_FILE)


$(FO_FILE)	: valid $(XML_FILE)
	xsltproc $(FO_XSL) $(XML_FILE) > $(FO_FILE)
	fop $(FO_FILE) $(PDF_FILE)


clean		:
	rm -f $(XHTML_FILE) $(FO_FILE) $(PDF_FILE)

distclean	: clean
	$(MAKE) -C $(UTILS_DIR) clean
