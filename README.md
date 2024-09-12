# Harbor on EKS: Streamlined Deployment for Vulnerability Scanning

Easily deploy Harbor, an open-source container registry and vulnerability scanning platform, on Amazon EKS using OpenTofu.

## Features

- One-command deployment of Harbor on Amazon EKS
- Scalable architecture using EFS for persistent storage
- Secure configuration with RDS for database backend
- Automated networking and load balancing setup
- Comprehensive test suite and CI/CD integration

## Features and Benefits

- **Effortless Deployment**: Get a production ready Harbor up and running on Amazon EKS with just a few commands
- **Smart Load Balancing**: Implements AWS Load Balancer Controller for smooth traffic management
- **Peace of Mind**: Includes a comprehensive test suite to ensure everything's working as it should
- **Budget-Friendly**: Efficiently uses AWS services to keep your costs in check
- **Your Harbor, Your Way**: Easily customizable to fit your organization's unique needs
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

For detailed information about setup, configuration, and usage, please visit our [full documentation](https://your-mkdocs-site-url.com).

## Contributing

We welcome contributions! Please see our [Contributing Guide](docs/CONTRIBUTING.md) for more details.

## Support

If you encounter any issues or have questions, please [open an issue](https://github.com/devsecflow/deploy-harbor-eks/issues) or contact us at [devsecflow.com](https://devsecflow.com).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## About DevSecFlow

This project is maintained by DevSecFlow. Learn more about us and our services at [devsecflow.com](https://devsecflow.com).