# test/Makefile

.PHONY: test
test: init format validate lint docs unit-test

.PHONY: init
init:
	cd ../tofu && tofu init -backend=false

.PHONY: format
format:
	cd ../tofu && tofu fmt -recursive

.PHONY: validate
validate:
	cd ../tofu && tofu validate

.PHONY: lint
lint:
	cd ../tofu && tflint

.PHONY: docs
docs:
	@if command -v terraform-docs >/dev/null 2>&1; then \
		cd .. && terraform-docs markdown table --output-file README.md --output-mode inject ./tofu; \
	else \
		echo "terraform-docs is not installed. Skipping documentation generation."; \
		echo "To install, visit: https://terraform-docs.io/user-guide/installation/"; \
	fi

.PHONY: unit-test
unit-test:
	go test -v .

.PHONY: all
all: test

.PHONY: clean
clean:
	cd ../tofu && rm -rf .terraform .terraform.lock.hcl

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  test        : Run all tests (init, format, validate, lint, docs, unit-test)"
	@echo "  init        : Initialize OpenTofu"
	@echo "  format      : Format OpenTofu files"
	@echo "  validate    : Validate OpenTofu files"
	@echo "  lint        : Run tflint on OpenTofu files"
	@echo "  docs        : Generate documentation using terraform-docs"
	@echo "  unit-test   : Run Go unit tests"
	@echo "  all         : Alias for 'test' target"
	@echo "  clean       : Remove OpenTofu state files and lock file"
	@echo "  help        : Display this help message"