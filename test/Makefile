# test/Makefile

.PHONY: test
test: init format validate lint docs unit-test

.PHONY: init
init:
	cd ../tofu && $(TERRATEST_TERRAFORM_EXECUTABLE) init -backend=false

.PHONY: format
format:
	cd ../tofu && $(TERRATEST_TERRAFORM_EXECUTABLE) fmt -recursive

.PHONY: validate
validate:
	cd ../tofu && $(TERRATEST_TERRAFORM_EXECUTABLE) validate

.PHONY: lint
lint:
	cd ../tofu && tflint || true

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
	@echo "  init        : Initialize OpenTofu or Terraform"
	@echo "  format      : Format OpenTofu or Terraform files"
	@echo "  validate    : Validate OpenTofu or Terraform files"
	@echo "  lint        : Run tflint on OpenTofu or Terraform files"
	@echo "  docs        : Generate documentation using terraform-docs"
	@echo "  unit-test   : Run Go unit tests"
	@echo "  all         : Alias for 'test' target"
	@echo "  clean       : Remove OpenTofu or Terraform state files and lock file"
	@echo "  help        : Display this help message"
