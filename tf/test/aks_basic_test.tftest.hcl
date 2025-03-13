run "verify_aks_basic_config" {
  command = plan
  
  # Check that AKS resource exists
  assert {
    condition     = length(azurerm_kubernetes_cluster.aks) > 0
    error_message = "AKS cluster resource not found"
  }
  
  # Verify the cluster is in the correct region
  assert {
    condition     = azurerm_kubernetes_cluster.aks.location == "westeurope"
    error_message = "AKS cluster should be in West Europe region"
  }
  
  # Verify node pool configuration
  assert {
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool[0].vm_size == "Standard_DS2_v2"
    error_message = "VM size should be Standard_DS2_v2"
  }
  
  # Verify auto-scaling is enabled
  assert {
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool[0].enable_auto_scaling == true
    error_message = "Auto-scaling should be enabled"
  }
}