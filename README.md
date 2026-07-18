# Terraform Infrastructure as Code (IaC) Project

## Overview

This project provisions and manages a **Development (Dev) AWS environment** using **Terraform**. The infrastructure follows Infrastructure as Code (IaC) best practices by using reusable Terraform modules, remote state management with an **Amazon S3 backend**, and automated deployments through **GitHub Actions CI/CD**.

The project is modular, making it scalable, maintainable, and easy to extend for additional environments such as staging and production.

---

# Architecture

The infrastructure provisions the following AWS resources:

- Virtual Private Cloud (VPC)
- Public and Private Subnets
- Internet Gateway
- Route Tables
- Security Groups
- EC2 Instance(s)
- Application Load Balancer (ALB)

Terraform modules are used to separate infrastructure components into reusable building blocks.

N/B 
The remote statefile is configured in the providers block with S3 bucket and for this project, he statefile locking was not enabled but can be added with the parameter 
use_lockfile = true
```
.
├── .github/
│   └── workflows/
│       └── deploy.yml
│
├── provider.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── main.tf
│
├── modules/
│   ├── vpc/
│   ├── security-group/
│   ├── ec2/
│   └── alb/
│
└── README.md
│
└── .gitignore

```

---

# Infrastructure Components

## VPC Module

Creates:

- VPC
- Public subnets
- Private subnets
- Internet Gateway
- Route Tables
- Route Table Associations

---

## Security Group Module

Creates security groups for:

### Application Load Balancer

Allows:

- HTTP (80)
- HTTPS (443)

### EC2

Allows:

- SSH (22)
- HTTP from ALB
- Application ports as required

---

## EC2 Module

Deploys:

- EC2 Instance(s)
- User Data (optional)

---

## Application Load Balancer Module

Creates:

- Application Load Balancer
- Target Group
- Listener
- Listener Rules
- Target Group Attachments

Traffic Flow

```
Internet
      │
      ▼
Application Load Balancer
      │
      ▼
Target Group
      │
      ▼
EC2 Instance(s)
```

---

# Terraform Backend

Terraform state is stored remotely using an Amazon S3 bucket.

Benefits include:

- Centralized state
- Team collaboration
- State locking (when using DynamoDB)
- Secure state management
- Versioning support

Example backend configuration:

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "dev/terraform.tfstate"
    region = "eu-west-2"
    user_lockfile = true # This enables remote state if true
  }
}
```

> **Note:** Sensitive backend configuration values should not be committed to source control.

---

# Project Structure

```
modules/
│
├── vpc/
│   ├── main.tf
│   ├── variables.tf
│   ├── data.tf
│   └── outputs.tf
│
├── security-group/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── ec2/
│   ├── main.tf
│   ├── data.tf
│   ├── user_data.sh
│   ├── variables.tf
│   └── outputs.tf
│
└── alb/
    ├── main.tf
    └── variables.tf
```

Each module contains the standard:

- `main.tf`
- `variables.tf`
- `outputs.tf`

---

# Prerequisites

Before running this project ensure you have:

- Terraform "~> 6.0"
- AWS CLI
- Git
- AWS Account
- IAM User with sufficient permissions

Configure AWS credentials:

```bash
aws configure
```

---

# Installation

Clone the repository

```bash
git clone https://github.com/chrisugwumba/terraform-vpc-github-actions.git

cd <repository>
- cd terraform-vpc-github-actions


# Open your project in vscode by running the command 
- code .
 # this only works if this shortcut is configured in your vscode
```


Create a new branch to avoid commiting changes to your main branch and trigering the pipeline and when you push your code to github
```bash
git switch -c feature 
or 
git checkout -b new-branch-name 

# this codes creatures and switches you to a new feature branch
```
Initialize Terraform to download and install your configurations snd dependencies

```bash
terraform init
```

Validate configuration to check for error and misconfigurations

```bash
terraform validate
```

Format Terraform code

```bash
terraform fmt
```

Create execution plan shows your the infrastructure that will be created

```bash
terraform plan
```

Deploy infrastructure to deply the results of your terraform plan

```bash
terraform apply
```

Destroy infrastructure to destroy the infrastruture

```bash
terraform destroy
```

---

# Terraform Workflow

```
terraform init

↓

terraform validate

↓

terraform fmt

↓

terraform plan

↓

terraform apply
```

---

# CI/CD Pipeline

This project uses **GitHub Actions** for Continuous Integration and Continuous Deployment.

The pipeline automatically validates and deploys infrastructure based on the Git workflow.

## Workflow

### Feature Branch

Developer creates a feature branch.

```
main
   │
   └── feature/new-feature
```
# For a this project

Developer pushes code. He then creates a pull request from the main feature branch. the code gets review. If the code is ok, a pull request is intiated and the pipeline is automatically triggered

GitHub Actions automatically runs:

- Terraform Format
- Terraform Init
- Terraform Validate
- Terraform Plan

No infrastructure changes are applied.


### 

```
For a production grade project, this is the standard way of defining your cicd pipeline
Developer pushes code 

GitHub Actions automatically runs:

- Terraform Format
- Terraform Init
- Terraform Validate
- Terraform Plan

No infrastructure changes are applied.

---

### Pull Request

A Pull Request is created from the feature branch to `main`.

The pipeline runs:

- Terraform Format
- Terraform Validate
- Terraform Plan

The generated plan can be reviewed before merging.

---

### Merge to Main

After approval:

- Pull Request is merged into `main`

GitHub Actions automatically runs:

- Terraform Init
- Terraform Validate
- Terraform Plan
- Terraform Apply

Infrastructure is updated automatically in the Development environment.

---

# GitHub Actions Pipeline

```
Feature Branch
      │
      ▼
Push Code
      │
      ▼
Terraform fmt
      │
      ▼
Terraform validate
      │
      ▼
Terraform plan
      │
      ▼
Pull Request
      │
      ▼
Code Review
      │
      ▼
Merge
      │
      ▼
Main Branch
      │
      ▼
Terraform Apply
```
```
# If this is a test environment, you can destroy this code from your local terminal following the steps below

- Navigate to your project folder,
- Run terraform init to intialize, all configured dependencies
- Run terraform destroy --auto-approve to destroy the resources
- this only works if AWS CLI is configured on your terminal
---

# Git Branch Strategy

```
main
 │
 ├── feature/network
 │
 ├── feature/alb
 │
 ├── feature/ec2
 │
 └── feature/security-group
```

Development workflow:

1. Create a feature branch.
2. Implement infrastructure changes.
3. Push changes to GitHub.
4. GitHub Actions validates the Terraform code.
5. Create a Pull Request.
6. Review and approve the Pull Request.
7. Merge into `main`.
8. GitHub Actions automatically deploys the infrastructure.

---

# GitHub Secrets

The following secrets should be configured in the GitHub repository:

| Secret | Description |
|----------|-------------|
| AWS_ACCESS_KEY_ID | AWS Access Key |
| AWS_SECRET_ACCESS_KEY | AWS Secret Key |
| AWS_REGION | AWS Region |

Optional:

| Secret | Description |
|----------|-------------|
| TF_VAR_* | Terraform Variables |
| AWS_SESSION_TOKEN | Temporary Credentials |

---





# Best Practices

This project follows Terraform best practices:

- Modular architecture
- Remote state management
- Version-controlled infrastructure
- Reusable modules
- Least-privilege IAM access
- GitHub Actions automation
- Pull Request reviews before deployment
- Infrastructure changes through code only

---

# Security

Recommended security practices:

- Never commit AWS credentials.
- Store secrets in GitHub Secrets.
- Enable S3 bucket versioning for Terraform state.
- Use DynamoDB state locking to prevent concurrent state modifications.
- Apply least-privilege IAM policies.
- Restrict Security Group ingress to only required ports.
- Encrypt the S3 backend using SSE.

---

# Future Improvements

Potential enhancements include:

- Multi-environment support (Dev, Staging, Production)
- Terraform Workspaces
- Automated security scanning using tfsec or Checkov
- Cost estimation with Infracost
- Terraform documentation generation
- Automated testing with Terratest
- Blue/Green deployments
- Auto Scaling Groups
- Route 53 DNS integration
- ACM TLS certificates
- CloudWatch monitoring and alarms

---

# Troubleshooting

### Backend initialization issues

```bash
terraform init -reconfigure
```

### Refresh state

```bash
terraform refresh
```

### View current state

```bash
terraform state list
```

### Check Terraform version

```bash
terraform version
```

---

# License

This project is provided for educational and development purposes. Update this section with your organization's preferred license (for example, MIT or Apache 2.0) before public distribution.

---

# Author

- Ugwumba Chrisangelo Amaechi

Cloud Engineer | DevOps Engineer

---

# Acknowledgements

- Digital CLoud Academy
- Terraform
- Amazon Web Services (AWS)
- GitHub Actions
- HashiCorp Terraform Registry# terraform-vpc-github-actions
AWS Infrastucture Deployment Using Terraform and Github Actions CICD Pipeline
