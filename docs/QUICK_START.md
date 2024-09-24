# Quick Start Guide

To deploy Harbor on EKS using this project, follow the steps below. You can use either **OpenTofu** or **Terraform** depending on your preference.

## 1. Clone the Repository

   ```bash
   git clone https://github.com/devsecflow/deploy-harbor-eks.git
   cd deploy-harbor-eks
   ```

## 2. Choose Your Tool: OpenTofu or Terraform

### **Option 1: OpenTofu**

1. Navigate to the `tofu` directory:

   ```bash
   cd tofu
   ```

2. Initialize OpenTofu:

   ```bash
   tofu init
   ```

### **Option 2: Terraform (Alternative)**

1. Navigate to the `terraform` directory:

   ```bash
   cd terraform
   ```

2. Initialize Terraform:

   ```bash
   terraform init
   ```

## 3. Create a `terraform.tfvars` File

Create the `terraform.tfvars` file with your specific values, applicable to both OpenTofu and Terraform:

   ```hcl
   region       = "us-west-2"
   cluster_name = "your-cluster-name"
   cert_arn     = "arn:aws:acm:us-west-2:your-account-id:certificate/your-certificate-id"
   domain_name  = "harbor.yourdomain.com"
   vpc_cidr     = "10.0.0.0/16"
   ```

## 4. Review and Apply the Configuration

### **For OpenTofu**

   ```bash
   tofu plan
   tofu apply
   ```

### **For Terraform**

   ```bash
   terraform plan
   terraform apply
   ```

## 5. Post-Deployment

After the deployment, follow the post-deployment steps in the `POST_DEPLOYMENT.md` file for additional configuration and setup.

For more detailed instructions, refer to the full documentation.
