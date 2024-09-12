# Harbor on EKS: Streamlined Deployment for Vulnerability Scanning

Easily deploy Harbor, an open-source container registry and vulnerability scanning platform, on Amazon EKS using OpenTofu.

## Features and Benefits

- **Effortless Deployment**: Get a production-ready Harbor up and running on Amazon EKS with just a few commands
- **Scalable Architecture**: Uses EFS (Elastic File System) for persistent storage, allowing easy growth
- **Secure Configuration**: Utilizes RDS for a robust and secure database backend
- **Smart Load Balancing**: Implements AWS Load Balancer Controller for smooth traffic management
- **Comprehensive Testing**: Includes a test suite and CI/CD integration for reliability
- **Budget-Friendly**: Efficiently uses AWS services to optimize costs
- **Customizable**: Easily adaptable to fit your organization's unique needs
- **Best Practices Baked In**: Implements AWS and Kubernetes best practices right out of the box

## Quick Start

```bash
git clone https://github.com/devsecflow/deploy-harbor-eks.git
cd deploy-harbor-eks/tofu
export TF_VAR_db_password=$(openssl rand -base64 16)
tofu init
tofu apply
```

## Documentation

For detailed information about setup, configuration, and usage, please visit our [full documentation](https://devsecflow.github.io/deploy-harbor-eks/).

## Support

Need help? [Open an issue](https://github.com/devsecflow/deploy-harbor-eks/issues) or contact us at [devsecflow.com](https://devsecflow.com).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
