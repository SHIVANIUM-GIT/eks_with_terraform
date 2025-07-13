# EKS with Terraform

## Overview
This project provisions an Amazon EKS (Elastic Kubernetes Service) cluster and supporting AWS infrastructure using Terraform. The configuration is modular, making it easy to reuse and customize for different environments.

## Features
- Modular Terraform structure (VPC, EKS, Jump Box)
- VPC with public/private subnets, NAT gateways, and security groups
- Secure, private EKS cluster deployment
- Required IAM roles and policies for EKS and node groups
- EKS addons (vpc-cni, kube-proxy, coredns)
- Parameterized for region, instance types, subnets, AMI, and more

## Prerequisites
- [Terraform](https://www.terraform.io/downloads) >= 1.0
- AWS CLI configured with appropriate credentials
- An AWS account with permissions to create EKS, VPC, IAM, and related resources
- (Optional) kubectl for interacting with the EKS cluster

## Project Structure
```
main.tf                # Root Terraform configuration
provider.tf            # AWS provider setup
terraform.tfvars       # Variable values for your environment
variable.tf            # Variable definitions
modules/
  vpc/                 # VPC, subnets, security groups
  eks/                 # EKS cluster, node groups, IAM
  jump_box/            # Bastion/jump server
scripts/install.sh     # Script to install AWS CLI and kubectl
```

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
   - Use the output values to configure `kubectl` and connect to your cluster.
   - The jump box can be used for secure access to private resources.

## Customization
- Modify variables in `terraform.tfvars` or `variable.tf` to fit your environment.
- Add or update modules as needed for your use case.

## Clean Up
To destroy all resources created by this project:
```sh
terraform destroy
```

## License
MIT

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
