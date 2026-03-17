TYPST ?= typst
ROOT := $(CURDIR)
PDF_STANDARD := 2.0

EXERCISE_SOURCES := $(shell find $(ROOT)/Ex* -maxdepth 1 -type f -name 'ex*.typ' ! -name '*-figures.typ' 2>/dev/null | sort)
EXERCISES := $(basename $(notdir $(EXERCISE_SOURCES)))

.PHONY: all clean list $(EXERCISES)

all: $(EXERCISES)

list:
	@printf '%s\n' $(EXERCISES)

define BUILD_EXERCISE
$(1):
	$(TYPST) compile Ex$(patsubst ex%,%,$(1))/$(1).typ Ex$(patsubst ex%,%,$(1))/$(1).pdf --root $(ROOT) --pdf-standard $(PDF_STANDARD)
endef

$(foreach exercise,$(EXERCISES),$(eval $(call BUILD_EXERCISE,$(exercise))))

clean:
	@for exercise in $(EXERCISES); do rm -f Ex$${exercise#ex}/$$exercise.pdf; done
