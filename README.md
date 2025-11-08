# Highly Available & Scalable Web App on AWS

Deploys a **highly available web application** using **Terraform** and **Ansible** on AWS. It demonstrates infrastructure automation, configuration management, and CI/CD best practices.

## Features

- EC2 instances across multiple Availability Zones
- Application Load Balancer (ALB) with health checks
- Auto Scaling Group (ASG)
- IAM role-based access via GitHub OIDC
- Flask app serving `/` and `/health`
- Terraform backend on an S3 bucket (enable versioning)

## Setup

1. Clone the repo:

```bash
git clone https://github.com/OmkarHosavalike/aws-high-availability.git
cd aws-high-availability
```
2. Configure repository secret variables:

- BACKEND_S3_BUCKET → S3 bucket for Terraform state (enable versioning)
- OIDC_IAM_ROLE → IAM role ARN for GitHub Actions

3. Run the workflow via GitHub Actions (By pushing to main branch)  
   Terraform provisions infrastructure and Ansible configures EC2 instances.

4. Test the app:

```bash
curl http://<ALB-DNS>/
curl http://<ALB-DNS>/health
```