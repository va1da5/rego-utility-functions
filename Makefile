.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo "Available targets:"
	@echo " help						this help"
	@echo " clean						clean up"


.PHONY: test
test:
	@opa test ./utils -v 