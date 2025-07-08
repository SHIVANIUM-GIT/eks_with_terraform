# eks_with_terraform

## Overview

This project provisions an Amazon EKS (Elastic Kubernetes Service) cluster and supporting AWS infrastructure using Terraform. It is modularized for reusability and clarity, with separate modules for VPC networking and EKS cluster resources.

## Features

- Modular Terraform configuration
  - VPC with public/private subnets, NAT gateways, and route tables
  - Secure, private EKS cluster deployment
  - Required IAM roles and policies for EKS and node groups
  - EKS addons (vpc-cni, kube-proxy, coredns)
- Parameterized for region, instance types, subnets, AMI, and more

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- AWS CLI configured with appropriate credentials
- An AWS account with permissions to create EKS, VPC, IAM, and related resources

## Usage

1. **Clone the repository**

   ```sh
   git clone https://github.com/SHIVANIUM-GIT/eks_with_terraform.git
   cd eks_with_terraform
   ```

2. **Customize variables**

   Edit `terraform.tfvars` to set your desired values for cluster name, region, subnets, and other options.

3. **Initialize Terraform**

   ```sh
   terraform init
   ```

4. **Preview the changes**

   ```sh
   terraform plan
   ```

5. **Apply the configuration**

   ```sh
   terraform apply
   ```

6. **Access your EKS cluster**

   - Use the AWS CLI or console to retrieve your kubeconfig and connect to the cluster.
   - Example:
     ```sh
     aws eks update-kubeconfig --region <region> --name <cluster_name>
     ```

## Inputs

| Variable        | Description                       | Type         | Example / Default                     |
|-----------------|-----------------------------------|--------------|---------------------------------------|
| name            | Project/cluster name              | string       | "EKS-TERRAFORM"                       |
| region          | AWS region                        | string       | "ap-south-1"                          |
| instance_type   | EC2 instance types for workers    | list(string) | ["t3.medium"]                         |
| cidr_block      | VPC CIDR block                    | string       | "10.0.0.0/16"                         |
| pub_subnet      | Public subnets                    | list(string) | ["10.0.1.0/24", ...]                  |
| pri_subnet      | Private subnets                   | list(string) | ["10.0.101.0/24", ...]                |
| ami_type        | Worker node AMI type              | string       | "BOTTLEROCKET_x86_64"                 |

## Outputs

- VPC ID
- Subnet IDs
- Security group ID
- (Add more as needed...)

## File Structure

```
.
├── main.tf
├── provider.tf
├── variable.tf
├── terraform.tfvars
├── modules/
│   ├── vpc/
│   │   ├── vpc.tf
│   │   └── output.tf
│   └── eks/
│       ├── eks.tf
│       ├── IAM.tf
│       └── addons.tf
└── README.md
```

## Notes

- This configuration creates real cloud resources and may incur costs. Remember to run `terraform destroy` when done.
- For production, consider securing state files (e.g., use S3 backend with encryption and locking), versioning provider and module sources, and reviewing IAM permissions.

## License

MIT or your preferred license.
