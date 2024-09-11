# variables.tf - Defines input variables for the Terraform configuration

variable "region" {
  type    = string
  default = "us-west-2"
}

variable "cluster_name" {
  type = string
}

variable "node_instance_type" {
  type    = string
  default = "t3.large"
}

variable "cert_arn" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_password" {
  type    = string
  default = "PleaseChangeMEw"
}