# Quick Start Guide

To deploy Harbor on EKS using this project:

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

   ```text
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

6. Follow the post-deployment steps in POST_DEPLOYMENT.md.

For more detailed instructions, refer to the full documentation.
