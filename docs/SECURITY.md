# Security Considerations

We take security seriously in this project. Here are some key security aspects and considerations:

## Static Analysis

We use tfsec for static analysis of our Terraform configurations. Some checks are excluded based on the specific requirements of our Harbor on EKS deployment:

- `aws-eks-no-public-cluster-access` and `aws-eks-no-public-cluster-access-to-cidr`: Our Harbor instance needs to be publicly accessible.
- `aws-ec2-no-public-egress-sgr`: Harbor requires broad egress rules for its functionality.
- `aws-rds-enable-performance-insights`: While beneficial, this is not critical for our current deployment.

These exclusions are configured in the `.tfsec.yml` file. We continuously review our security posture and may adjust these exclusions in future updates.

## Security Features

1. **EKS Security**: We implement EKS best practices, including proper IAM roles and security groups.
2. **RDS Security**: The database is deployed in a private subnet with restricted access.
3. **Network Security**: We use VPC security groups to control inbound and outbound traffic.
4. **Encryption**: Data at rest is encrypted for EFS and RDS.

## Reporting Security Issues

If you discover a security vulnerability in this project, please report it to us by [opening an issue](https://github.com/devsecflow/deploy-harbor-eks/issues) with the label "security". We ask that you give us a reasonable amount of time to respond and address the issue before making it public.

## Security Updates

We strive to keep all dependencies up-to-date, especially those with security implications. Regular reviews and updates are part of our maintenance process.

Remember, security is a shared responsibility. While we've implemented several security measures, how you configure and use this deployment can also impact its security. Always follow AWS and Kubernetes security best practices in your environment.
