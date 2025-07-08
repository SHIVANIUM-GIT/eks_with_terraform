# Core Infrastructure Variables
variable "name" {
  description = "Base name for all resources (e.g., 'prod', 'dev')"
  type        = string
  default     = "my-eks"
}

variable "instance_ami" {
  description = "AMI type for worker nodes (AL2_x86_64, AL2_arm_64, BOTTLEROCKET_x86_64, etc.)"
  type        = string
  default     = "AL2_x86_64"  # Amazon Linux 2
}
# Node Group Variables
# In variables.tf
variable "instance_type" {
  description = "EC2 instance type for jump server"
  type        = string
  default     = "t3.micro"
}
variable "pub_subnet_id" {
  description = "List of public subnet IDs for load balancers"
  type        = list(string)
}

variable "jump_box_sg_id" {
  description = "Security group for the jump box"
  type        = string
}
