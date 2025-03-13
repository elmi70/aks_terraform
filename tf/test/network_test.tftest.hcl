run "verify_networking" {
  command = plan
  
  # Verify network profile exists
  assert {
    condition     = length(azurerm_kubernetes_cluster.aks.network_profile) > 0
    error_message = "Network profile should be configured"
  }
  
  # Verify service CIDR is set
  assert {
    condition     = azurerm_kubernetes_cluster.aks.network_profile[0].service_cidr != ""
    error_message = "Service CIDR should be set"
  }
  
  # Verify load balancer is standard
  assert {
    condition     = azurerm_kubernetes_cluster.aks.network_profile[0].load_balancer_sku == "standard"
    error_message = "Load balancer SKU should be standard"
  }
}