# Configuration Guide

This guide explains how to configure your Harbor on EKS deployment, including key variables and authentication options. Both OpenTofu and Terraform can be used for this setup.

## Key Variables

Create a `terraform.tfvars` file in the `tofu` or `terraform` directory with your specific values:

```hcl
region       = "us-west-2"
cluster_name = "my-harbor-cluster"
cert_arn     = "arn:aws:acm:us-west-2:123456789012:certificate/12345678-1234-1234-1234-123456789012"
domain_name  = "harbor.example.com"
vpc_cidr     = "10.0.0.0/16"
```

- `region`: AWS region for deployment
- `cluster_name`: Name for your EKS cluster
- `cert_arn`: ARN of the ACM certificate for HTTPS
- `domain_name`: Domain name for Harbor
- `vpc_cidr`: Your VPC CIDR block

### Notes

- You can use either **OpenTofu** or **Terraform** to manage this configuration. Terraform is a more mature and stable option if you're concerned about potential future changes in OpenTofu, which is still in development.

## Authentication Configuration

Harbor supports multiple authentication methods. You can configure the authentication mode in the `harbor.tf` file, whether you're using OpenTofu or Terraform. Here are the options:

### Database Authentication (Default)

This is enabled by default. No additional configuration is needed.

### LDAP Authentication

To enable LDAP authentication, update the `auth` section in `harbor.tf` as follows:

```hcl
auth = {
  mode = "ldap_auth"
  ldap = {
    enabled        = true
    url            = "ldaps://your-ldap-server.com"
    searchDN       = "cn=admin,dc=example,dc=com"
    searchPassword = "your-ldap-admin-password"
    baseDN         = "dc=example,dc=com"
    filter         = "(objectClass=person)"
    uid            = "uid"
    scope          = "2"
    timeout        = 5
  }
}
```

Adjust the LDAP settings according to your LDAP server configuration.

### OIDC Authentication

To enable OIDC authentication, update the `auth` section in `harbor.tf` as follows:

```hcl
auth = {
  mode = "oidc_auth"
  oidc = {
    enabled      = true
    name         = "Your OIDC Provider"
    endpoint     = "https://your-oidc-provider.com"
    clientId     = "your-client-id"
    clientSecret = "your-client-secret"
    groupsClaim  = "groups"
    adminGroup   = "harbor-admins"
    verifyToken  = false
  }
}
```

Replace the OIDC settings with your OIDC provider's configuration.

## Applying Configuration Changes

After making changes to your configuration, you’ll need to review and apply those changes based on whether you're using **OpenTofu** or **Terraform**:

### OpenTofu

1. Review your changes:

   ```bash
   tofu plan
   ```

2. Apply the changes:

   ```bash
   tofu apply
   ```

### Terraform (as an alternative to OpenTofu)

1. Review your changes:

   ```bash
   terraform plan
   ```

2. Apply the changes:

   ```bash
   terraform apply
   ```

   *Note: If you encounter any issues with OpenTofu due to its ongoing development, Terraform provides a more stable alternative for managing the configuration and applying changes.*

## Security Recommendations

Always handle sensitive information like passwords, client secrets, and tokens securely. It's recommended to store these in AWS Secrets Manager or using environment variables. Avoid hard-coding sensitive data directly into your configuration files.

For more detailed information about Harbor's configuration options, refer to the [official Harbor documentation](https://goharbor.io/docs/latest/install-config/).
