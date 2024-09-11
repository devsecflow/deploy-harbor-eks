# Harbor on EKS: Streamlined Deployment of Open Source Vulnerability Scanning

> **Note**: We're excited to announce that our next major update will focus on modularizing this configuration, making it even easier to customize and use different components of the code independently.

## Table of Contents

- [Overview](#overview)
- [Features and Benefits](#features-and-benefits)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Post-Deployment Steps](#post-deployment-steps)
- [Directory Structure](#directory-structure)
- [Testing](#testing)
- [Continuous Integration](#continuous-integration)
- [Contributing](#contributing)
- [License](#license)
- [Support](#support)
- [About DevSecFlow](#about-devsecflow)

## Overview

Welcome to our OpenTofu configuration for deploying [Harbor](https://github.com/goharbor/harbor), an fantastic open source container image registry and vulnerability scanning platform, on Amazon EKS (Elastic Kubernetes Service). Our goal is to make your life easier by simplifying the process of setting up a robust, production-ready vulnerability scanning solution that's suitable for organizations of all sizes.

With this configuration, you can have a fully functional Harbor instance up and running in your AWS environment in no time, with minimal manual work required. It's perfect for teams looking to enhance their security practices with powerful open source vulnerability scanning capabilities.

## Features and Benefits

- **Effortless Deployment**: Get Harbor up and running on Amazon EKS with just a few commands
- **Built to Scale**: Uses EFS (Elastic File System) for persistent storage, so you can grow with ease
- **Rock-Solid Security**: Configures RDS (Relational Database Service) for a robust and secure database backend
- **Networking Made Easy**: Takes care of all the necessary networking components and security groups
- **Smart Load Balancing**: Implements AWS Load Balancer Controller for smooth traffic management
- **Peace of Mind**: Includes a comprehensive test suite to ensure everything's working as it should
- **Time is Money**: Dramatically reduces the time it takes to deploy a production-ready Harbor instance
- **Budget-Friendly**: Efficiently uses AWS services to keep your costs in check
- **Your Harbor, Your Way**: Easily customizable to fit your organization's unique needs
- **Best Practices Baked In**: Implements AWS and Kubernetes best practices right out of the box

By using this project, your team can quickly implement a crucial security tool without needing to be cloud or Kubernetes experts. This means your security heroes can focus on what really matters - finding and fixing vulnerabilities - rather than getting bogged down in complex infrastructure setup.

## Prerequisites

Before we dive in, make sure you have these tools in your toolkit:

- [OpenTofu](https://opentofu.org/docs/intro/install/) >= 1.8.0
- [AWS CLI](https://aws.amazon.com/cli/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [helm](https://helm.sh/docs/intro/install/)
- [Go](https://golang.org/doc/install) (for running tests)
- [tflint](https://github.com/terraform-linters/tflint) (for linting)
- [terraform-docs](https://terraform-docs.io/user-guide/installation/) (optional, for documentation generation)

### Installation Commands

If you're on macOS, you can use Homebrew:

```bash
brew install opentofu awscli kubectl helm go tflint terraform-docs
```

For our Linux friends (Ubuntu/Debian):

```bash
# OpenTofu
curl -Lo /usr/local/bin/tofu https://github.com/opentofu/opentofu/releases/download/v1.6.0-alpha5/tofu_1.6.0-alpha5_linux_amd64
chmod +x /usr/local/bin/tofu

# AWS CLI
sudo apt-get update && sudo apt-get install -y awscli

# kubectl
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

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

Don't forget to configure your AWS CLI with the appropriate permissions.

## Quick Start

Let's get you up and running:

1. Clone the repository:

   ```bash
   git clone https://github.com/devsecflow/deploy-harbor-eks.git
   cd deploy-harbor-eks
   ```

2. Set up environment variables:

   ```bash
   export TF_VAR_db_password=$(openssl rand -base64 16)
   ```

3. Initialize OpenTofu:

   ```bash
   cd tofu
   tofu init
   ```

4. Create a `terraform.tfvars` file with your specific values:

   ```hcl
   region       = "us-west-2"
   cluster_name = "your-cluster-name"
   cert_arn     = "arn:aws:acm:us-west-2:your-account-id:certificate/your-certificate-id"
   domain_name  = "harbor.yourdomain.com"
   ```

5. Review and apply the configuration:

   ```bash
   tofu plan
   tofu apply
   ```

## Configuration

Here are the key variables you can customize:

- `region`: Which AWS region should we deploy to?
- `cluster_name`: What should we call your EKS cluster?
- `cert_arn`: ARN of the ACM certificate for HTTPS (more on this below)
- `domain_name`: What domain name will you use for Harbor?
- `node_instance_type`: What EC2 instance type for EKS nodes? (default: "t3.large")
- `vpc_cidr`: CIDR block for the VPC (default: "10.0.0.0/16")

### Understanding cert_arn

The `cert_arn` variable is the Amazon Resource Name (ARN) of an SSL/TLS certificate in AWS Certificate Manager (ACM). This certificate is key to enabling secure HTTPS access to your Harbor instance.

Here's how to get your cert_arn:

1. Head over to AWS Certificate Manager in your AWS Console.
2. Request or import a certificate for your domain (e.g., harbor.yourdomain.com).
3. Once it's issued, copy the ARN of the certificate.
4. Use this ARN as the value for `cert_arn` in your `terraform.tfvars` file.

## Post-Deployment Steps

After you've successfully deployed, there's just one more thing to do - configure your domain's DNS:

1. First, let's get the ELB address:

   ```bash
   kubectl get ingress -n harbor
   ```

   Look for the ADDRESS field in the output.

2. Now, create a CNAME record in your domain's DNS settings:
   - Host: harbor (or whatever subdomain you're using)
   - Points to: The ELB address you just retrieved
   - TTL: 300 seconds (or whatever you prefer)

This step ensures that your chosen domain name points to your shiny new Harbor instance on EKS.

## Directory Structure

Here's how our project is organized:

```text
├── LICENSE
├── README.md
├── test
│   ├── Makefile
│   ├── .tflint.hcl
│   ├── go.mod
│   └── harbor_test.go
└── tofu
    ├── csi.tf
    ├── efs.tf
    ├── eks.tf
    ├── harbor.tf
    ├── ingress.tf
    ├── pv.tf
    ├── rds.tf
    ├── sg.tf
    ├── tofu.tf
    ├── variables.tf
    └── vpc.tf
```

## Testing

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

We've set up a CI pipeline that runs our test suite on every push and pull request. If you're curious about the details, check out the `.github/workflows` directory.

## Contributing

We'd love for you to contribute! Here's how:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for all the details.

## Support

Run into a problem or have a question? No worries! Open an issue in our GitHub repository at <https://github.com/devsecflow/deploy-harbor-eks/issues> and we'll be happy to help. For more comprehensive support or to explore how DevSecFlow can further enhance your cybersecurity practices, visit [devsecflow.com](https://devsecflow.com) or contact us directly.

## About DevSecFlow

This project is maintained by DevSecFlow, a leading cybersecurity consulting firm specializing in innovative solutions for secure software development and deployment. Visit us at [devsecflow.com](https://devsecflow.com) to learn more about our services.

### Our Approach

At DevSecFlow, we offer:

- Comprehensive Assessment and Strategic Planning
- Integration of Leading Open-Source Technologies
- Automated Security and Orchestration Processes
- Ongoing Support and Continuous Improvement
- Customization for Industry-Specific Challenges

### Why Choose DevSecFlow

1. **Tailored Solutions**: We understand that every organization has unique challenges. Our solutions are customized to meet your specific needs and industry requirements.

2. **Open-Source Expertise**: We leverage leading open-source tools like Harbor, OPA, and Terraform to build scalable, adaptable security solutions free from vendor lock-in.

3. **Continuous Improvement**: We provide ongoing support, regular updates, and training to keep your security practices effective and resilient.

4. **Regulatory Compliance**: Our solutions are designed with compliance in mind, helping you meet industry standards and regulations.

5. **Proven Track Record**: Our team has successfully led major cybersecurity initiatives at top firms including GitLab, Salesforce, Allstate, Grail, and Booz Allen Hamilton.

By choosing this Harbor on EKS solution, you're not just getting a deployment script - you're benefiting from the collective expertise of the DevSecFlow team and our commitment to enhancing your organization's security posture.

---

Generated by [terraform-docs](https://terraform-docs.io/)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->