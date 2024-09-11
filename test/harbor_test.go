package test

import (
	"os"
	"testing"
	"os/exec"
	"strings"
)

func TestHarborDeployment(t *testing.T) {
	// Set the TERRATEST_TERRAFORM_EXECUTABLE environment variable to "tofu"
	os.Setenv("TERRATEST_TERRAFORM_EXECUTABLE", "tofu")

	// Change to the tofu directory
	err := os.Chdir("../tofu")
	if err != nil {
		t.Fatalf("Failed to change directory: %v", err)
	}

	// Run tofu init
	cmd := exec.Command("tofu", "init")
	output, err := cmd.CombinedOutput()
	if err != nil {
		t.Fatalf("tofu init failed: %v\nOutput: %s", err, output)
	}

	// Run tofu plan
	cmd = exec.Command("tofu", "plan", "-var", "cluster_name=test-cluster", 
		"-var", "region=us-west-2", 
		"-var", "domain_name=example.com",
		"-var", "cert_arn=arn:aws:acm:us-west-2:123456789012:certificate/12345678-1234-1234-1234-123456789012")
	output, err = cmd.CombinedOutput()
	if err != nil {
		t.Fatalf("tofu plan failed: %v\nOutput: %s", err, output)
	}

	// Check if the plan output contains expected resources
	expectedResources := []string{
		"aws_eks_cluster",
		"aws_efs_file_system",
		"aws_db_instance",
	}

	for _, resource := range expectedResources {
		if !strings.Contains(string(output), resource) {
			t.Errorf("Expected resource %s not found in plan output", resource)
		}
	}

	// Note: We're not actually applying the changes or destroying resources in this test
	// as it could incur real costs and take a long time. In a real CI/CD pipeline,
	// you might want to apply to a sandboxed account and then destroy.
}