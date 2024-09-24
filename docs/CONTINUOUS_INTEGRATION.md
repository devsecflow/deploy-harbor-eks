# Continuous Integration

This project uses GitHub Actions for continuous integration. Our CI pipeline runs on every push and pull request, performing the following checks:

- Runs Go tests
- Checks OpenTofu formatting
- Validates OpenTofu configurations
- Runs tflint for additional OpenTofu linting
- Ensures documentation is up-to-date
- Performs IAC security scans using Snyk and tfsec
- Lints Go code using golangci-lint
- Checks Markdown files for consistent styling

For more details, see the `.github/workflows/ci.yml` file in the repository.
