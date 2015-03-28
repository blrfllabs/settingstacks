#
# Makefile for Setting Stacks
#

.POSIX:

# -----------------------------------------------------------------------------

# Configurables

NAME=Setting_Stacks
XML=$(NAME).prj.xml

# Where to fetch the exported XML from the device.  Note that this is
# specific to the author's network.
EXPORT_URL=http://mphone:8080/emulated/0/Tasker/projects/$(XML)

# -----------------------------------------------------------------------------

# File exported from Tasker, as stored here
EXPORTED=$(XML)-exported

default: build


# Force a copy of the exported project to be pulled from the
# developer's device.  See EXPORT_URL, above.
fetch:
	rm -f $(EXPORTED)
	$(MAKE) $(EXPORTED)


$(EXPORTED):
	wget --no-verbose "--output-document=$@" "$(EXPORT_URL)"


build: $(XML)


HEADER=header.xml
WORKING=$(XML)-working
OUTPUT=$(XML)-working-output
$(XML): $(EXPORTED) $(HEADER)
	cat $(HEADER) $(EXPORTED) > $(WORKING)
	@for XSLT in `ls prep-* | sort` ; \
	do \
		echo xsltproc $$XSLT $(WORKING) \> $(OUTPUT) ; \
		xsltproc $$XSLT $(WORKING) > $(OUTPUT) ; \
		mv $(OUTPUT) $(WORKING) ; \
	done
	mv -f $(WORKING) $@

TO_CLEAN += $(XML) $(WORKING) $(OUTPUT)


release: clean $(XML)


clean:
	rm -rf $(TO_CLEAN) *~
