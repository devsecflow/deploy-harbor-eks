# Harbor User Guides

## Running a Vulnerability Scan with Harbor

This guide will walk you through the process of pushing an image to Harbor, running a vulnerability scan, and interpreting the results. We'll use Nginx as our example image.

### Prerequisites

- Harbor is deployed and accessible
- Docker is installed on your local machine
- You have admin access to your Harbor instance

### Steps

1. **Log in to Harbor**

   Use the Docker CLI to log in to your Harbor instance:

   ```bash
   docker login harbor.yourdomain.com
   ```

   Enter your Harbor credentials when prompted.

2. **Create a New Project**

   - Log in to the Harbor web interface
   - Click on "New Project"
   - Name your project (e.g., "nginx-test")
   - Set the project to "Public" for this example
   - Click "OK" to create the project

3. **Configure Automatic Scanning and SBOM Generation**

   - In your project, go to the "Configuration" tab
   - Under "Vulnerability scanning", check "Automatically scan images on push"
   - Under "SBOM generation", check "Automatically generate SBOM on push"
   - Click "Save" to apply these settings

4. **Pull the Nginx Image**

   Pull the latest Nginx image from Docker Hub:

   ```bash
   docker pull nginx:latest
   ```

5. **Tag the Nginx Image for Harbor**

   Tag the image with your Harbor registry:

   ```bash
   docker tag nginx:latest harbor.yourdomain.com/nginx-test/nginx:v1
   ```

6. **Push the Image to Harbor**

   Push the tagged image to your Harbor registry:

   ```bash
   docker push harbor.yourdomain.com/nginx-test/nginx:v1
   ```

7. **View Scan Results**

   - In the Harbor web interface, navigate to your "nginx-test" project
   - Find the nginx image you just pushed
   - Click on the image name to view details
   - Go to the "Vulnerabilities" tab to see the scan results
   - Review the list of vulnerabilities, their severity, and any available fixes

8. **View SBOM**

   - In the image details page, go to the "Artifacts" tab
   - You should see the SBOM artifact associated with your image
   - Click on the SBOM to view or download it

9. **Interpret the Results**

   - Pay special attention to "High" and "Critical" vulnerabilities
   - Consider updating to a newer version of Nginx if significant vulnerabilities are found
   - Investigate mitigation strategies for any unresolved vulnerabilities
   - Use the SBOM to understand the components of your image and their licenses

### Best Practices

- Regularly scan your images for new vulnerabilities
- Use the automatic scanning and SBOM generation features for all projects
- Implement policies to prevent the deployment of images with critical vulnerabilities
- Review SBOMs to ensure compliance with license requirements and to identify outdated components

By following these steps, you can effectively use Harbor to scan your container images for vulnerabilities and generate SBOMs, helping to maintain the security and compliance of your deployments.
