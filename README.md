# Azure Web App Infrastructure with Terraform

This repository contains Terraform configurations to deploy a **secure Python web application** on Azure. The setup includes:

- **Azure App Service Plan** and **Linux Web App**
- **Storage Account** with a private **Blob Container**
- **Virtual Network (VNet)** and **Subnet**
- **Private Endpoint** to securely connect the Web App to the Storage Account
- **Private DNS Zone** for name resolution

## Prerequisites

Before you begin, ensure you have the following installed and configured:

1. **Azure Account**: Active Azure subscription with sufficient permissions.
2. **Terraform**: Version `1.5.0` or later.
   - [Download Terraform](https://www.terraform.io/downloads.html)
3. **Azure CLI**: To authenticate Terraform with Azure.
   - [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
4. **Text Editor**: Visual Studio Code or any preferred editor.
5. **Git**: Installed locally for version control.

### Azure Authentication

Authenticate with Azure using the Azure CLI:
```bash
az login
```
Ensure the correct subscription is set:
```bash
az account set --subscription "<your-subscription-id>"
```

## Project Structure

```plaintext
Azure-WebApp-StorageAccount-with-Terraform/
├── main.tf             # Main configuration for Azure resources
├── variables.tf        # Input variables for customization
├── outputs.tf          # Outputs for key resource details (e.g., URLs, IPs)
├── providers.tf        # Azure provider and backend configuration
├── versions.tf         # Terraform and provider version requirements
└── terraform.tfvars    # Environment-specific values for variables
```

## Step-by-Step Deployment

### 1. Clone the Repository

```bash
git clone <repository-url>
cd azure_python_app_infra
```

### 2. Initialize Terraform

Initialize the Terraform working directory and download the necessary provider plugins:

```bash
terraform init
```

### 3. Validate the Configuration

Ensure the configuration files are valid:

```bash
terraform validate
```

### 4. Plan the Deployment

Generate an execution plan to preview the changes:

```bash
terraform plan -out=tfplan
```

### 5. Apply the Configuration

Deploy the resources to Azure:

```bash
terraform apply tfplan
```

### 6. View Outputs

After successful deployment, view the resource details:

```bash
terraform output
```

## Configuration Details

### Input Variables (`variables.tf`)

| Variable                 | Description                                  | Default Value |
|--------------------------|----------------------------------------------|---------------|
| `project_name`           | The name of the project or application      | `sample`      |
| `environment`            | The environment type (e.g., DEV, PRD)       | `DEV`         |
| `azure_region`           | Azure region for deployment                 | `japaneast`   |
| `vnet_address_space`     | VNet address space (CIDR)                   | `10.200.0.0/16`|
| `subnet_address_prefix`  | Subnet address prefix (CIDR)                | `10.200.1.0/24`|
| `app_service_plan_sku`   | App Service Plan SKU                        | `P1v2`        |
| `storage_account_sku`    | Storage Account SKU                         | `Standard_LRS`|

### Outputs (`outputs.tf`)

| Output Name            | Description                                      |
|------------------------|--------------------------------------------------|
| `web_app_url`          | URL of the deployed web application             |
| `storage_account_name` | Name of the deployed Storage Account            |
| `private_endpoint_ip`  | Private IP of the Storage Account Private Endpoint |

## Troubleshooting

### Common Issues

1. **Duplicate Provider Configuration**:
   Ensure `azurerm` provider is declared only once in either `providers.tf` or `versions.tf`. Remove any duplicate blocks.

   Example:
   ```hcl
   # Remove duplicate provider block if present
   provider "azurerm" {
     features {}
   }
   ```

2. **Deprecated Attributes**:
   - Replace `enforce_private_link_endpoint_network_policies` with `private_endpoint_network_policies = "Disabled"`.
   - Use `azurerm_service_plan` instead of the deprecated `azurerm_app_service_plan`.

3. **Authentication Errors**:
   Ensure you are authenticated using Azure CLI (`az login`) and have the correct subscription selected.

### Debugging

Run Terraform in debug mode for more details:
```bash
TF_LOG=DEBUG terraform apply
```

## Cleanup

To destroy all resources created by this configuration:

```bash
terraform destroy
```

Confirm the destruction prompt to delete the resources.

---

## License

This project is licensed under the MIT License. Feel free to use and modify it as needed.
