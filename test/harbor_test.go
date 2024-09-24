package test

import (
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"testing"
)

func TestHarborDeployment(t *testing.T) {
	// Find the root directory of the project
	rootDir, err := findRootDir()
	if err != nil {
		t.Fatalf("Failed to find root directory: %v", err)
	}

	// Check if we are using OpenTofu or Terraform
	executable := os.Getenv("TERRATEST_TERRAFORM_EXECUTABLE")
	if executable == "" {
		// Default to tofu if not specified
		executable = "tofu"
	}

	// Change to the tofu or terraform directory based on the executable
	dir := filepath.Join(rootDir, executable)
	err = os.Chdir(dir)
	if err != nil {
		t.Fatalf("Failed to change directory to %s: %v", dir, err)
	}

	// Print current directory for debugging
	currentDir, _ := os.Getwd()
	t.Logf("Current directory: %s", currentDir)

	// List contents of current directory for debugging
	files, _ := os.ReadDir(".")
	for _, file := range files {
		t.Logf("File: %s", file.Name())
	}

	// Run init based on the selected tool (OpenTofu or Terraform)
	cmd := exec.Command(executable, "init")
	output, err := cmd.CombinedOutput()
	if err != nil {
		t.Fatalf("%s init failed: %v\nOutput: %s", executable, err, output)
	}

	// Run plan with variables
	cmd = exec.Command(executable, "plan", "-var", "cluster_name=test-cluster",
		"-var", "region=us-west-2",
		"-var", "domain_name=example.com",
		"-var", "cert_arn=arn:aws:acm:us-west-2:123456789012:certificate/12345678-1234-1234-1234-123456789012")
	output, err = cmd.CombinedOutput()
	if err != nil {
		t.Fatalf("%s plan failed: %v\nOutput: %s", executable, err, output)
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
}

func findRootDir() (string, error) {
	dir, err := os.Getwd()
	if err != nil {
		return "", err
	}

	for {
		if _, err := os.Stat(filepath.Join(dir, "go.mod")); err == nil {
			return filepath.Dir(dir), nil // Return the parent of the directory containing go.mod
		}
		parent := filepath.Dir(dir)
		if parent == dir {
			return "", os.ErrNotExist
		}
		dir = parent
	}
}
