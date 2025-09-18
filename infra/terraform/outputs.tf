output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_rg" {
  value = azurerm_resource_group.rg.name
}
