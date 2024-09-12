# Testing

We've included a comprehensive test suite to keep everything ship-shape. Here's how to run it:

1. Navigate to the `test` directory:

   ```bash
   cd test
   ```

2. Run the test suite:

   ```bash
   make test
   ```

This will run through a series of checks:

- Format checking with `tofu fmt`
- Configuration validation with `tofu validate`
- Static code analysis with `tflint`
- Documentation generation with `terraform-docs` (if you have it installed)
- Unit tests with Go

## Continuous Integration

We've implemented a comprehensive CI pipeline using GitHub Actions. On every push and pull request, our workflow:

- Runs Go tests
- Checks OpenTofu formatting
- Validates OpenTofu configurations
- Runs tflint for additional OpenTofu linting
- Ensures documentation is up-to-date
- Performs security scans using Snyk and tfsec
- Lints Go code using golangci-lint
- Checks Markdown files for consistent styling

You can find the workflow configuration in the `.github/workflows/ci.yml` file.

## Adding New Tests

When adding new features or modifying existing ones, please ensure that appropriate tests are added or updated. This helps maintain the quality and reliability of the project.

If you're unsure about how to test a particular component, feel free to open an issue or discuss it in your pull request.

## Running Individual Tests

If you need to run specific tests or checks, you can use the following commands:

### Format Checking

To check the formatting of your OpenTofu files:

```bash
tofu fmt -check -recursive ../tofu
```

### Configuration Validation

To validate your OpenTofu configuration:

```bash
cd ../tofu
tofu init -backend=false
tofu validate
```

### Static Code Analysis

To run tflint on your OpenTofu files:

```bash
cd ../tofu
tflint
```

### Documentation Generation

To generate documentation using terraform-docs:

```bash
terraform-docs markdown table --output-file ../README.md --output-mode inject ../tofu
```

### Go Unit Tests

To run the Go unit tests:

```bash
go test -v ./...
```

## Test Coverage

We strive to maintain high test coverage for our codebase. While 100% coverage isn't always practical or necessary, we aim for comprehensive coverage of critical paths and edge cases.

To view the current test coverage, you can run:

```bash
go test -cover ./...
```

For a more detailed coverage report, you can use:

```bash
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out
```

This will generate an HTML report of your test coverage, which you can view in your browser.

## Reporting Test Issues

If you encounter any issues with the tests or believe a test is incorrectly implemented, please open an issue on our GitHub repository. Provide as much detail as possible, including:

- The specific test that failed
- The expected behavior
- The actual behavior
- Any error messages or logs

Your feedback helps us improve the reliability and effectiveness of our test suite.
