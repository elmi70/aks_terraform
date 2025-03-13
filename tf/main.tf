data "azurerm_kubernetes_service_versions" "current" {
  location        = var.location
  include_preview = false
}
locals {
  sensitive_admin_group_ids = sensitive([data.azuread_group.aks_admins.object_id])
}
data "azuread_group" "aks_admins" {
  display_name     = "aksadmins"
  security_enabled = true
}

resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "aks" {
  name                = "${var.cluster_name}-logs"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  sku                 = "PerGB2018"
  retention_in_days   = var.log_analytics_retention_days
  tags                = var.tags
}

# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  sku                 = "Standard"
  admin_enabled       = false
  tags                = var.tags
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = coalesce(var.kubernetes_version, data.azurerm_kubernetes_service_versions.current.latest_version)

  # Identity
  identity {
    type = "SystemAssigned"
  }

  # Default node pool
  default_node_pool {
    name                 = "agentpool"
    vm_size              = var.node_vm_size
    auto_scaling_enabled = true
    min_count            = var.min_node_count
    max_count            = var.max_node_count
    node_count           = var.initial_node_count
    os_disk_size_gb      = var.os_disk_size_gb
    os_sku               = "Ubuntu"
    max_pods             = 110
    type                 = "VirtualMachineScaleSets"
  }

  # Network profile
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  # Azure AD integration
  azure_active_directory_role_based_access_control {
    admin_group_object_ids = local.sensitive_admin_group_ids
    azure_rbac_enabled     = false
  }

  # OIDC Issuer
  oidc_issuer_enabled = true

  # Workload Identity
  workload_identity_enabled = true

  # Azure Monitor
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.aks.id
  }

  # Key Vault integration
  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }

  # Auto-upgrade settings
  automatic_upgrade_channel = "patch"

  # Maintenance window
  maintenance_window {
    allowed {
      day   = "Sunday"
      hours = [0, 1, 2, 3]
    }
  }
  private_cluster_enabled = false
  tags                    = var.tags

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }
}

# Role assignment for AKS to pull from ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
