name          = "EKS-TERRAFORM"
region        = "ap-south-1"
instance_type = "t3.medium"
cidr_block    = "10.0.0.0/16"
pub_subnet    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
pri_subnet    = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
ami_type      = "BOTTLEROCKET_x86_64"
instance_ami  = "ami-0d03cb826412c6b0f"