# efs.tf - Configures Amazon Elastic File System (EFS) for Harbor

# Create an EFS file system
resource "aws_efs_file_system" "harbor" {
  encrypted = true
  tags = {
    Name = "harbor-${var.cluster_name}"
  }
}

# Create EFS mount targets in each private subnet
resource "aws_efs_mount_target" "efs" {
  for_each       = { for i, val in module.vpc.private_subnets : i => val }
  file_system_id = aws_efs_file_system.harbor.id
  subnet_id      = each.value
}

# Define the EFS access policy
data "aws_iam_policy_document" "efs_policy" {
  statement {
    sid    = "Statement01"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "elasticfilesystem:ClientRootAccess",
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
    ]

    resources = [aws_efs_file_system.harbor.arn]

    condition {
      test     = "Bool"
      variable = "elasticfilesystem:AccessedViaMountTarget"
      values   = ["true"]
    }
  }
}

# Attach the policy to the EFS file system
resource "aws_efs_file_system_policy" "efs_policy" {
  file_system_id = aws_efs_file_system.harbor.id
  policy         = data.aws_iam_policy_document.efs_policy.json
}

# Create an EFS access point for Harbor
resource "aws_efs_access_point" "harbor" {
  file_system_id = aws_efs_file_system.harbor.id
  posix_user {
    gid = "1000"
    uid = "1000"
  }

  root_directory {
    path = "/harbor"
    creation_info {
      owner_gid   = "1000"
      owner_uid   = "1000"
      permissions = "777"
    }
  }
}