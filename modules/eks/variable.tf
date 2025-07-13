# Core Infrastructure Variables
variable "name" {
  description = "Base name for all resources (e.g., 'prod', 'dev')"
  type        = string
  default     = "my-eks"
}

variable "vpc_id" {
  description = "ID of the VPC where EKS will be deployed"
  type        = string
}

variable "pub_subnet_id" {
  description = "List of public subnet IDs for load balancers"
  type        = list(string)
}

variable "pri_subnet_id" {
  description = "List of private subnet IDs for worker nodes"
  type        = list(string)
}

# Security Variables
variable "sg_control_id" {
  description = "Control plane security group ID (must allow 443 from worker nodes)"
  type        = string
}

# Node Group Variables
variable "instance_type" { 
  description = "List of EC2 instance types for worker nodes"
  type        = string
}

variable "ami_type" {
  description = "AMI type for worker nodes (AL2_x86_64, AL2_arm_64, BOTTLEROCKET_x86_64, etc.)"
  type        = string
  # default     = "AL2_x86_64"  
}

variable "jump_box_sg_id" {
  type = string
  description = "Security group for the jump box"
}
