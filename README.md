# AKS Terraform Deployment

[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![AKS](https://img.shields.io/badge/AKS-Kubernetes-blue?style=for-the-badge&logo=kubernetes&logoColor=white)](https://azure.microsoft.com/en-us/products/kubernetes-service)

This repository contains infrastructure as code (IaC) for deploying a production-ready Azure Kubernetes Service (AKS) cluster with best practices and supporting infrastructure.

## 📋 Features

- ✅ **AKS cluster** with auto-scaling node pools
- ✅ **Azure Container Registry** integration with AKS
- ✅ **Microsoft Entra ID (Azure AD)** integration for RBAC
- ✅ **Key Vault** integration with CSI secrets provider
- ✅ **Log Analytics** workspace for monitoring and diagnostics
- ✅ **Automated Deployment** with GitHub Actions CI/CD pipeline
- ✅ **Security Scanning** with Checkov for infrastructure validation

## 🚀 Quick Start

### Prerequisites

- Azure subscription
- Azure CLI installed
- Terraform installed
- GitHub account (for GitHub Actions)

### Setup Service Principal

Before deploying, create a service principal with the required permissions:

1. Create the service principal with Contributor role:

   ```sh
   az ad sp create-for-rbac --name "AKSTerraformSP" --role "Contributor" --scopes /subscriptions/YOUR_SUB_ID
   
   ```
2. Add Microsoft Graph permissions for Azure AD integration:

  ```sh
   # Replace APP_ID with the appId from the previous command
   az ad app permission add --id APP_ID --api 00000003-0000-0000-c000-000000000000 --api-permissions 5b567255-7703-4780-807c-7be8301ae99b=Role
   
   ```
3. Grant admin consent:

```sh
az ad app permission grant --id APP_ID --api 00000003-0000-0000-c000-000000000000

```

4. Store the JSON output from step 1 in a GitHub secret named AZURE_CREDENTIALS


## Deployment Options

### Option 1: GitHub Actions (Recommended)

- Fork this repository
- Configure the GitHub secret `AZURE_CREDENTIALS` with your service principal details
- Push changes to trigger the deployment workflow or manually run the workflow

### Option 2: Local Deployment

```sh 
   Clone the repository
   git clone https://github.com/yourusername/aks-terraform.git
   cd aks-terraform

   # Initialize Terraform
   cd terraform
   terraform init

   # Preview changes
   terraform plan

   # Apply changes
   terraform apply

```

## 🧪 Testing

The infrastructure is tested using Terraform's built-in testing framework. To run tests:

```sh
   cd terraform
   terraform test
```

## 🔍 Security Scanning
Run security scanning with Checkov:

```sh
# Install Checkov
pip install checkov

# Scan Terraform code
checkov -d terraform/

```


## 📚 Additional Resources

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [Azure Kubernetes Service Documentation](https://learn.microsoft.com/en-us/azure/aks/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)