# Configuration Guide

This guide explains the key variables you can customize in your `terraform.tfvars` file.

## Key Variables

- `region`: AWS region for deployment (e.g., "us-west-2")
- `cluster_name`: Name for your EKS cluster
- `cert_arn`: ARN of the ACM certificate for HTTPS
- `domain_name`: Domain name for Harbor (e.g., "harbor.yourdomain.com")
- `node_instance_type`: EC2 instance type for EKS nodes (default: "t3.large")
- `vpc_cidr`: CIDR block for the VPC (default: "10.0.0.0/16")

## Example `terraform.tfvars`

```hcl
region       = "us-west-2"
cluster_name = "my-harbor-cluster"
cert_arn     = "arn:aws:acm:us-west-2:123456789012:certificate/12345678-1234-1234-1234-123456789012"
domain_name  = "harbor.example.com"
```

## Understanding `cert_arn`

The `cert_arn` variable is the Amazon Resource Name (ARN) of an SSL/TLS certificate in AWS Certificate Manager (ACM). To obtain it:

1. Go to AWS Certificate Manager in your AWS Console.
2. Request or import a certificate for your domain (e.g., harbor.yourdomain.com).
3. Once issued, copy the ARN of the certificate.
4. Use this ARN as the value for `cert_arn` in your `terraform.tfvars` file.

## Post-Deployment Configuration

After successful deployment, configure your domain's DNS:

1. Get the ELB address:

   ```bash
   kubectl get ingress -n harbor
   ```

2. Create a CNAME record in your domain's DNS settings:
   - Host: harbor (or your chosen subdomain)
   - Points to: The ELB address from step 1
   - TTL: 300 seconds (or as preferred)

This ensures your domain name resolves to your new Harbor instance on EKS.
