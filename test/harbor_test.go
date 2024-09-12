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

	// Change to the tofu directory
	tofuDir := filepath.Join(rootDir, "tofu")
	err = os.Chdir(tofuDir)
	if err != nil {
		t.Fatalf("Failed to change directory to %s: %v", tofuDir, err)
	}

	// Print current directory for debugging
	currentDir, _ := os.Getwd()
	t.Logf("Current directory: %s", currentDir)

	// List contents of current directory for debugging
	files, _ := os.ReadDir(".")
	for _, file := range files {
		t.Logf("File: %s", file.Name())
	}

	// Set the TERRATEST_TERRAFORM_EXECUTABLE environment variable to "tofu"
	os.Setenv("TERRATEST_TERRAFORM_EXECUTABLE", "tofu")

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
}

func findRootDir() (string, error) {
	dir, err := os.Getwd()
	if err != nil {
		return "", err
	}

	for {
		if _, err := os.Stat(filepath.Join(dir, "go.mod")); err == nil {
			return dir, nil
		}
		parent := filepath.Dir(dir)
		if parent == dir {
			return "", os.ErrNotExist
		}
		dir = parent
	}
}