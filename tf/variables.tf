variable "location" {
  description = "Azure region where resources will be created (e.g., 'eastus', 'westeurope')"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of the resource group for AKS deployment"
  type        = string
  default     = "aks-rg"
}

variable "cluster_name" {
  description = "Name of the AKS cluster - must be globally unique and DNS compatible"
  type        = string
  default     = "aks-cluster"
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster - used with the cluster name to form the full FQDN"
  type        = string
  default     = "aks"
}

variable "kubernetes_version" {
  description = "Kubernetes version to use (defaults to latest if not specified)"
  type        = string
  default     = null
}

variable "acr_name" {
  description = "Name of the Azure Container Registry - must be globally unique and only contain alphanumeric characters"
  type        = string
  default     = "akscr"

  validation {
    condition     = can(regex("^[a-zA-Z0-9]+$", var.acr_name))
    error_message = "ACR name must only contain alphanumeric characters."
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

variable "node_vm_size" {
  description = "VM size for the default node pool (e.g., 'Standard_DS2_v2')"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "min_node_count" {
  description = "Minimum number of nodes in the default node pool when using auto-scaling"
  type        = number
  default     = 2
}

variable "max_node_count" {
  description = "Maximum number of nodes in the default node pool when using auto-scaling"
  type        = number
  default     = 5
}

variable "initial_node_count" {
  description = "Initial number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "os_disk_size_gb" {
  description = "Size of the OS disk in GB for each node in the node pool"
  type        = number
  default     = 128
}

variable "log_analytics_retention_days" {
  description = "Retention period in days for logs in Log Analytics workspace"
  type        = number
  default     = 30

  validation {
    condition     = var.log_analytics_retention_days >= 30 && var.log_analytics_retention_days <= 730
    error_message = "Log Analytics retention days must be between 30 and 730."
  }
}