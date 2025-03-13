run "verify_security_settings" {
  command = plan
  
  # Verify RBAC is enabled
  assert {
    condition     = azurerm_kubernetes_cluster.aks.role_based_access_control_enabled == true
    error_message = "RBAC should be enabled on the AKS cluster"
  }
  
  # Verify Azure AD integration is configured
  assert {
    condition     = length(azurerm_kubernetes_cluster.aks.azure_active_directory_role_based_access_control) > 0
    error_message = "Azure AD integration should be configured"
  }
  
  # Verify network policy is configured
  assert {
    condition     = azurerm_kubernetes_cluster.aks.network_profile[0].network_plugin == "azure"
    error_message = "AKS should use Azure CNI networking"
  }
}