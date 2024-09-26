# Harbor on EKS: Streamlined Deployment for Vulnerability Scanning

> **Coming Soon**: We're excited to announce that our next major update will focus on modularizing the OpenTofu configuration. This will make it even easier to customize and use different components of the code independently, allowing for more flexible and tailored deployments. Stay tuned for a more adaptable and scalable Harbor on EKS solution!

Easily deploy Harbor, an open-source container registry and vulnerability scanning platform, on Amazon EKS using OpenTofu or Terraform.

## Features and Benefits

- **Effortless Deployment**: Get a production-ready Harbor up and running on Amazon EKS with just a few commands.
- **Scalable Architecture**: Uses EFS (Elastic File System) for persistent storage, allowing easy growth.
- **Secure Configuration**: Utilizes RDS for a robust and secure database backend.
- **Smart Load Balancing**: Implements AWS Load Balancer Controller for smooth traffic management.
- **Comprehensive Testing**: Includes a test suite and CI/CD integration for reliability.
- **Budget-Friendly**: Efficiently uses AWS services to optimize costs.
- **Customizable**: Easily adaptable to fit your organization's unique needs.
- **Best Practices Baked In**: Implements AWS and Kubernetes best practices right out of the box.

## Quick Start

### Prerequisites

Before you begin, ensure you have the following installed:

- [OpenTofu](https://opentofu.org/docs/intro/install/) >= 1.8.0 or [Terraform](https://www.terraform.io/downloads) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) (configured with appropriate permissions)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [helm](https://helm.sh/docs/intro/install/)

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

# Terraform
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

### Configuration

Create a `terraform.tfvars` file in the `tofu` directory:

```hcl
region       = "us-west-2"
cluster_name = "my-harbor-cluster"
cert_arn     = "arn:aws:acm:us-west-2:123456789012:certificate/12345678-1234-1234-1234-123456789012"
domain_name  = "harbor.example.com"
vpc_cidr     = "10.0.0.0/16"
```

Key variables:

- `region`: AWS region for deployment
- `cluster_name`: Name for your EKS cluster
- `cert_arn`: ARN of the ACM certificate for HTTPS
- `domain_name`: Domain name for Harbor
- `vpc_cidr`: Your VPC CIDR block

### Deployment

1. Clone the repository:

   ```bash
   git clone https://github.com/devsecflow/deploy-harbor-eks.git
   cd deploy-harbor-eks/tofu
   ```

2. Initialize and apply:

   ```bash
   # Using OpenTofu
   tofu init
   tofu apply

   # Alternatively, using Terraform
   terraform init
   terraform apply
   ```

   *Note: Since OpenTofu is still under development, some future updates may introduce breaking changes. If you encounter issues, using Terraform as an alternative is recommended for a more stable experience.*

## Documentation

For detailed information about setup, configuration, and usage, please visit our [full documentation](https://devsecflow.github.io/deploy-harbor-eks/).

## Support

Need help? [Open an issue](https://github.com/devsecflow/deploy-harbor-eks/issues) or contact us at [devsecflow.com](https://devsecflow.com).

## About DevSecFlow

DevSecFlow is a leading cybersecurity consulting firm specializing in innovative solutions for secure software development and deployment. This project is maintained by our team of experts committed to enhancing organizations' security postures through open-source tools and best practices. Visit us at [devsecflow.com](https://devsecflow.com) to learn more.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
