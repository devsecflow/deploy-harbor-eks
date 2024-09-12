# Post-Deployment Steps

After successfully deploying Harbor on EKS, follow these steps:

1. Retrieve the ELB address:

   ```bash
   kubectl get ingress -n harbor
   ```

2. Create a CNAME record in your domain's DNS settings:
   - Host: harbor (or your chosen subdomain)
   - Points to: The ELB address from step 1
   - TTL: 300 seconds (or as preferred)

3. Access Harbor using your domain and verify the installation.

4. Configure any additional settings in Harbor as needed for your environment.

For more detailed post-deployment configuration, refer to the [Harbor documentation](https://goharbor.io/docs/).
