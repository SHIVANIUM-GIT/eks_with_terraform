name          = "EKS-terraform"
region        = "ap-south-1"
instance_type = "t3.medium"
cidr_block    = "10.0.0.0/16"
pub_subnet    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
pri_subnet    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
