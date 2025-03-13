output "resource_group_name" {
  description = "Name of the resource group containing all AKS resources"
  value       = azurerm_resource_group.aks.name
}

output "cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "cluster_id" {
  description = "Resource ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "node_resource_group" {
  description = "Name of the resource group containing the AKS node resources"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "kube_config" {
  description = "Configuration for connecting to the AKS cluster using kubectl"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "host" {
  description = "Kubernetes cluster API server hostname"
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.host
  sensitive   = true
}

output "acr_login_server" {
  description = "Login server URL for Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_id" {
  description = "Resource ID of the Azure Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics workspace used for AKS monitoring"
  value       = azurerm_log_analytics_workspace.aks.id
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL for the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.oidc_issuer_url
}

output "deployed_version" {
  description = "Kubernetes version deployed on the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.kubernetes_version
}