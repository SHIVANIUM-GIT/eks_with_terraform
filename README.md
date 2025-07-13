# EKS with Terraform

## Overview

This project provisions an Amazon EKS (Elastic Kubernetes Service) cluster and all supporting AWS infrastructure using Terraform. The configuration is modular and designed to be easily reusable and customizable for different environments, making it ideal for both production and development use cases.

---

## Features

- **Modular Terraform structure:** Clean separation for VPC, EKS, and Jump Box/Bastion modules.
- **VPC design:** Creates public and private subnets, NAT gateways, routing tables, and security groups.
- **Secure and private EKS cluster:** Deploys the control plane and worker nodes in private subnets.
- **IAM Roles and Policies:** All required IAM roles and policies for EKS and worker node groups are created automatically.
- **EKS Addons:** Installs core addons like `vpc-cni`, `kube-proxy`, and `coredns`.
- **Highly parameterized:** Easily configure region, instance types, AMIs, subnets, and more using input variables.
- **Jump Box Support:** Optional bastion server for secure access to private resources.

---

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- AWS CLI configured with appropriate credentials
- An AWS account with permissions to create EKS, VPC, IAM, and related resources
- (Optional) [kubectl](https://kubernetes.io/docs/tasks/tools/) for interacting with your EKS cluster

---

## Project Structure

```
main.tf                # Root Terraform configuration
provider.tf            # AWS provider setup
terraform.tfvars       # Variable values for your environment
variable.tf            # Variable definitions

modules/
  vpc/                 # VPC, subnets, security groups
  eks/                 # EKS cluster, node groups, IAM, addons
  jump_box/            # Bastion/jump server

scripts/
  install.sh           # Installs AWS CLI and kubectl on the jump box

README.md              # Documentation (this file)
```

---

## Usage

1. **Clone the repository**
    ```sh
    git clone https://github.com/SHIVANIUM-GIT/eks_with_terraform.git
    cd eks_with_terraform
    ```

2. **Customize variables**
    Edit `terraform.tfvars` to set your values for cluster name, region, subnets, and other options.

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
    - Use the AWS CLI or console to retrieve your kubeconfig and connect to the cluster:
      ```sh
      aws eks update-kubeconfig --region <region> --name <cluster_name>
      ```
    - The jump box can be used for secure SSH access to private resources as needed.

---

## Customization

- Modify variables in `terraform.tfvars` or `variable.tf` to fit your requirements (region, CIDR blocks, instance types, etc).
- Add or update modules to extend the infrastructure (e.g., integrate with monitoring, additional AWS services).
- Security best practices: for production, secure state files (e.g., use S3 backend with encryption and locking), version provider and module sources, and review IAM permissions.

---

## Clean Up

To destroy all resources created by this project:
```sh
terraform destroy
```
**Important:** This configuration creates real cloud resources that may incur costs. Always clean up when finished.

---

## Inputs

| Variable        | Description                       | Type         | Example / Default                     |
|-----------------|-----------------------------------|--------------|---------------------------------------|
| name            | Project/cluster name              | string       | "EKS-TERRAFORM"                       |
| region          | AWS region                        | string       | "ap-south-1"                          |
| instance_type   | EC2 instance types for workers    | string       | "t3.medium"                           |
| cidr_block      | VPC CIDR block                    | string       | "10.0.0.0/16"                         |
| pub_subnet      | Public subnets                    | list(string) | ["10.0.1.0/24", ...]                  |
| pri_subnet      | Private subnets                   | list(string) | ["10.0.101.0/24", ...]                |
| ami_type        | Worker node AMI type              | string       | "AL2023_x86_64_STANDARD"              |
| instance_ami    | Jump box AMI                      | string       | "ami-03f4878755434977f"               |

---

## Outputs

- VPC ID
- Subnet IDs
- Security Group IDs
- EKS Cluster Name and Endpoint
- (You can extend outputs as needed)

---

## File Structure

```
.
├── main.tf
├── provider.tf
├── variable.tf
├── terraform.tfvars
├── modules/
│   ├── vpc/
│   ├── eks/
│   └── jump_box/
├── scripts/
│   └── install.sh
└── README.md
```

---
