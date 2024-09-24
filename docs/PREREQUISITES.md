# Prerequisites

Before deploying Harbor on EKS using this project, ensure you have the following tools and configurations in place:

- [OpenTofu](https://opentofu.org/docs/intro/install/) >= 1.8.0 or [Terraform](https://www.terraform.io/downloads) >= 1.0 (as an alternative)
- [AWS CLI](https://aws.amazon.com/cli/) (configured with appropriate permissions)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [helm](https://helm.sh/docs/intro/install/)
- [Go](https://golang.org/doc/install) (for running tests)
- [tflint](https://github.com/terraform-linters/tflint) (for linting)
- [terraform-docs](https://terraform-docs.io/user-guide/installation/) (optional, for documentation generation)

## Note

You can use **Terraform** as an alternative to **OpenTofu** for deployment if you encounter issues with OpenTofu’s ongoing development.

## Installation Commands

### macOS (using Homebrew)

```bash
brew install opentofu terraform awscli kubectl helm go tflint terraform-docs
```

### Linux (Ubuntu/Debian)

```bash
# OpenTofu
curl -Lo ./tofu.tar.gz https://github.com/opentofu/opentofu/releases/latest/download/tofu_*_linux_amd64.tar.gz
tar -xzf tofu.tar.gz
chmod +x tofu
sudo mv tofu /usr/local/bin/

# Terraform (alternative to OpenTofu)
sudo apt-get update && sudo apt-get install -y terraform

# AWS CLI
sudo apt-get update && sudo apt-get install -y awscli

# kubectl
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Go
sudo apt-get install -y golang-go

# tflint
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# terraform-docs
curl -Lo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-$(uname)-amd64.tar.gz
tar -xzf terraform-docs.tar.gz
chmod +x terraform-docs
sudo mv terraform-docs /usr/local/bin/
```

*Remember to configure your AWS CLI with the appropriate permissions after installation.*
