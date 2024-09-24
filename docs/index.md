# Harbor on EKS: Streamlined Deployment for Vulnerability Scanning

> **Note**: We're excited to announce that our next major update will focus on modularizing this configuration, making it even easier to customize and use different components of the code independently.

Easily deploy Harbor, an open-source container registry and vulnerability scanning platform, on Amazon EKS using OpenTofu.

## Overview

This project provides an automated, infrastructure-as-code solution for deploying Harbor on Amazon EKS. It's designed to simplify the process of setting up a robust, production-ready vulnerability scanning solution suitable for organizations of all sizes.

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

## Quick Start

```bash
git clone https://github.com/devsecflow/deploy-harbor-eks.git
cd deploy-harbor-eks/tofu
tofu init
tofu apply

alternatively try
terraform init
terraform apply
```

## Documentation

For more detailed information, please refer to the following guides:

- [Prerequisites](PREREQUISITES.md): Tools and configurations needed before deployment
- [Quick Start Guide](QUICK_START.md): Detailed steps to get up and running
- [Configuration Guide](CONFIGURATION.md): How to customize your Harbor on EKS deployment
- [Post-Deployment Steps](POST_DEPLOYMENT.md): What to do after successful deployment
- [Testing](TESTING.md): Running and understanding the test suite
- [Continuous Integration](CONTINUOUS_INTEGRATION.md): Our CI/CD setup using GitHub Actions
- [Security Considerations](SECURITY.md): Security features and best practices
- [Branching Strategy](BRANCHING_STRATEGY.md): Our Git branching model
- [Contributing Guidelines](CONTRIBUTING.md): How to contribute to this project
- [About DevSecFlow](ABOUT_DEVSECFLOW.md): Information about the maintainers of this project

## Directory Structure

```text
├── LICENSE
├── README.md
├── docs/
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

## Support

Need help? [Open an issue](https://github.com/devsecflow/deploy-harbor-eks/issues) or contact us at [devsecflow.com](https://devsecflow.com).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
