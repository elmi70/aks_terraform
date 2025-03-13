data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "aks_kv" {
  name                       = "${var.cluster_name}-kv"
  location                   = azurerm_resource_group.aks.location
  resource_group_name        = azurerm_resource_group.aks.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false # Set to true for production
  enable_rbac_authorization  = true

  tags = var.tags
}

resource "azurerm_role_assignment" "aks_kv_secrets_user" {
  scope                = azurerm_key_vault.aks_kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}