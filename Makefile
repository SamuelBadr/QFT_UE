TYPST ?= typst
ROOT := $(CURDIR)
PDF_STANDARD := 2.0

EXERCISE_SOURCES := $(shell find $(ROOT)/Ex* -maxdepth 1 -type f -name 'ex*.typ' ! -name '*-figures.typ' 2>/dev/null | sort)
EXERCISES := $(basename $(notdir $(EXERCISE_SOURCES)))
EX2_FIGURE_SOURCES := $(shell find $(ROOT)/Ex2/figures-src -maxdepth 1 -type f -name '*.typ' ! -name 'contour-common.typ' 2>/dev/null | sort)
EX2_FIGURES := $(patsubst $(ROOT)/Ex2/figures-src/%.typ,$(ROOT)/Ex2/figures/%.pdf,$(EX2_FIGURE_SOURCES))

.PHONY: all clean list ex2-figures $(EXERCISES)

all: $(EXERCISES)

list:
	@printf '%s\n' $(EXERCISES)

define BUILD_EXERCISE
$(1):
	$(TYPST) compile Ex$(patsubst ex%,%,$(1))/$(1).typ Ex$(patsubst ex%,%,$(1))/$(1).pdf --root $(ROOT) --pdf-standard $(PDF_STANDARD)
endef

$(foreach exercise,$(EXERCISES),$(eval $(call BUILD_EXERCISE,$(exercise))))

$(ROOT)/Ex2/figures/%.pdf: $(ROOT)/Ex2/figures-src/%.typ
	@mkdir -p $(ROOT)/Ex2/figures
	$(TYPST) compile $< $@ --root $(ROOT) --pdf-standard $(PDF_STANDARD)

ex2-figures: $(EX2_FIGURES)

clean:
	@for exercise in $(EXERCISES); do rm -f Ex$${exercise#ex}/$$exercise.pdf; done
	@rm -f $(EX2_FIGURES)
