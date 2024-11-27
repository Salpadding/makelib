-include lib.mk

objs := $(call submake,.)

define def_submake
$(1)/%: FORCE
	$$(MAKE) obj=$(1) -f $(1)/Makefile
endef

$(foreach x,$(objs),$(eval $(call def_submake,$(x))))

.PHONY: FORCE