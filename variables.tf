variable "project_name" {
  description = "The name of the project or application"
  type        = string
  default     = "sample"
}

variable "environment" {
  description = "The environment type (e.g., DEV, PRD)"
  type        = string
  default     = "DEV"
}

variable "azure_region" {
  description = "Azure region for deployment"
  type        = string
  default     = "japaneast"
}

variable "vnet_address_space" {
  description = "VNet address space (CIDR)"
  type        = string
  default     = "10.200.0.0/16"
}

variable "subnet_address_prefix" {
  description = "Subnet address prefix (CIDR)"
  type        = string
  default     = "10.200.1.0/24"
}

variable "app_service_plan_sku" {
  description = "App Service Plan SKU"
  type        = string
  default     = "P1v2"
}

variable "storage_account_sku" {
  description = "Storage Account SKU"
  type        = string
  default     = "Standard_LRS"
}