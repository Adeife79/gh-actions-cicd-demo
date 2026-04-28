## Project Title: AWS Infrastructure as Code & CI/CD Pipeline with GitHub Actions 

## Project Overview
This project demonstrates a fully automated, end-to-end DevOps pipeline that provisions cloud infrastructure on AWS and deploys a Dockerized web application, all without any manual server configuration.

AWS infrastructure (VPC, subnets, and EC2) is defined and managed as code using Terraform, ensuring the environment is reproducible, version-controlled, and consistent across deployments. The application itself is containerized using Docker, eliminating environment inconsistencies between local development and production.

A GitHub Actions workflow ties evrything together which is automatically triggered on every push to `main` to validate infrastructure, build and push the Docker image to Docker Hub, and deploy the latest container to the EC2 instance via SSH.

## Prerequisites
- Terraform CLI
- AWS CLI + IAM 
- Docker
- GitHub secrets

## Repository Struture
```structure
.
└── gh_actions_demo1
    ├── .github
    │   └── workflows
    │       └── deploy.yaml                 # Full pipeline on push to main
    ├── app
    │   ├── Dockerfile                      #Container image definition
    │   ├── app.html
    │   ├── default.conf                    # Nginx configuration
    │   ├── omelette.jpg
    │   └── style.css
    ├── terraform-infra
    │   ├── compute.tf
    │   ├── networking.tf
    │   ├── output.tf                       # EC2 IP 
    │   ├── provider.tf
    │   ├── terraform.tfvars
    │   └── variables.tf
    ├── .gitignore
    └── README.md
```

## Infrastructure Setup (Terraform)
### Step 1: 
Create a Terraform-infra folder
```bash
mkdir terraform-infra
```
### Step 2: 
Create the required files (provider.tf, networking.tf, compute.tf, terraform.tfvar, variables.tf, output.tf) in the terraform-infra folder.
```bash
cd terraform-infra
touch provider.tf networking.tf compute.tf output.tf variables.tf terraform.tfvars 
```
### Step 3:  
Create resources for VPC, Subnets,Internet Gateway, Route Table, Route Table Association, and Security Group.

### Step 4:
 Authenticate into AWS Account using the command:
 ```bash
 aws configure
 ```
### Step 5:
Initialize terraform
```bash
terraform init
```
### Step 6:
Generate a terraform plan
```bash
terraform plan
```
### Step 7: 
Run terraform apply to create the necessary services on AWS
```bash
terraform apply
```

## Docker Image
### Step 1:
Navigate to the app folder to build docker image using the Dockerfile in the app folder.
```bash
cd app
```
### Step 2: 
Build and Run the Docker Image 
```bash
docker build -t <image_name> .
docker run -d -p <host_port>:<container_port> image_name 
```
### Step 3:
 Login to Docker Hub
```bash
docker login
```
### Step 4:
Login to Docker Hub and create a new repository.
### Steps 5: 
Login to Docker Hub on Linux terminal, tag the image, and push the image.
```bash
docker login
docker tag <image_name>  dockerhub-username/image_name
docker push dockerhub-username/image_name
```
---
## Secrets & Environment Variables
Click on the project repository on GitHub, navigate to the settings and then to the secrets and variables to add necessary secrets for the successful running of the CI/CD workflow. 
## CI/CD Pipeline (GitHub Actions)
This project uses GitHub Actions to automate the full build, test, and deployment lifecycle. Every push to main branch triggers the pipeline which builds a Docker image, pushes it to Docker Hub, and deploys it to an AWS EC2 instance provisioned by Terraform.
### Workflow file
---
`.github/workflows/deploy.yaml`

---

### Pipeline Stages
```
[1. Checkout] -> [2. Configure AWS Credentials] -> [3. Create S3 Backend] -> [4. Terraform Init & Apply]
-> [5. Login to Docker Hub] -> [6.Build & Push Docker Image] -> [7. Setup SSH Key] -> [8. Deploy to EC2 via SSH] 
```
## Contributions
Contributions are welcome and appreciated! Whether it's improving documentation, or proposing a new feature.
