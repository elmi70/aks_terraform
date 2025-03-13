<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.1.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/container_registry) | resource |
| [azurerm_key_vault.aks_kv](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/key_vault) | resource |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/kubernetes_cluster) | resource |
| [azurerm_log_analytics_workspace.aks](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.aks](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.aks_acr_pull](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_kv_secrets_user](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/role_assignment) | resource |
| [azuread_group.aks_admins](https://registry.terraform.io/providers/hashicorp/azuread/3.1.0/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/data-sources/client_config) | data source |
| [azurerm_kubernetes_service_versions.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/data-sources/kubernetes_service_versions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_name"></a> [acr\_name](#input\_acr\_name) | Name of the Azure Container Registry - must be globally unique and only contain alphanumeric characters | `string` | `"akscr"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the AKS cluster - must be globally unique and DNS compatible | `string` | `"aks-cluster"` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | DNS prefix for the AKS cluster - used with the cluster name to form the full FQDN | `string` | `"aks"` | no |
| <a name="input_initial_node_count"></a> [initial\_node\_count](#input\_initial\_node\_count) | Initial number of nodes in the default node pool | `number` | `2` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version to use (defaults to latest if not specified) | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where resources will be created (e.g., 'eastus', 'westeurope') | `string` | `"westeurope"` | no |
| <a name="input_log_analytics_retention_days"></a> [log\_analytics\_retention\_days](#input\_log\_analytics\_retention\_days) | Retention period in days for logs in Log Analytics workspace | `number` | `30` | no |
| <a name="input_max_node_count"></a> [max\_node\_count](#input\_max\_node\_count) | Maximum number of nodes in the default node pool when using auto-scaling | `number` | `5` | no |
| <a name="input_min_node_count"></a> [min\_node\_count](#input\_min\_node\_count) | Minimum number of nodes in the default node pool when using auto-scaling | `number` | `2` | no |
| <a name="input_node_vm_size"></a> [node\_vm\_size](#input\_node\_vm\_size) | VM size for the default node pool (e.g., 'Standard\_DS2\_v2') | `string` | `"Standard_DS2_v2"` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | Size of the OS disk in GB for each node in the node pool | `number` | `128` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group for AKS deployment | `string` | `"aks-rg"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | <pre>{<br/>  "Environment": "Development",<br/>  "ManagedBy": "Terraform"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_id"></a> [acr\_id](#output\_acr\_id) | Resource ID of the Azure Container Registry |
| <a name="output_acr_login_server"></a> [acr\_login\_server](#output\_acr\_login\_server) | Login server URL for Azure Container Registry |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | Resource ID of the AKS cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Name of the AKS cluster |
| <a name="output_deployed_version"></a> [deployed\_version](#output\_deployed\_version) | Kubernetes version deployed on the AKS cluster |
| <a name="output_host"></a> [host](#output\_host) | Kubernetes cluster API server hostname |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Configuration for connecting to the AKS cluster using kubectl |
| <a name="output_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#output\_log\_analytics\_workspace\_id) | Resource ID of the Log Analytics workspace used for AKS monitoring |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | Name of the resource group containing the AKS node resources |
| <a name="output_oidc_issuer_url"></a> [oidc\_issuer\_url](#output\_oidc\_issuer\_url) | OIDC issuer URL for the AKS cluster |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Name of the resource group containing all AKS resources |
<!-- END_TF_DOCS -->