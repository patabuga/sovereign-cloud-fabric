# ============================================
# Terraform Outputs
# Sovereign Cloud Fabric - Infrastructure Simulation
# ============================================

output "resource_group" {
  description = "Azure Resource Group name"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "Azure Resource Group ID"
  value       = azurerm_resource_group.main.id
}

output "virtual_network" {
  description = "Virtual Network name"
  value       = azurerm_virtual_network.main.name
}

output "virtual_network_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.main.id
}

output "subnets" {
  description = "Subnet details"
  value = {
    internal = azurerm_subnet.internal.id
    dmz      = azurerm_subnet.dmz.id
  }
}

output "storage_account" {
  description = "Storage Account name"
  value       = azurerm_storage_account.main.name
}

output "storage_account_endpoint" {
  description = "Storage Account primary endpoint"
  value       = azurerm_storage_account.main.primary_blob_endpoint
}

output "vm_private_ip" {
  description = "VM private IP address"
  value       = azurerm_network_interface.web.private_ip_address
  sensitive   = false
}

# Simulation Info
output "simulation_info" {
  description = "Information about this simulation"
  value = {
    environment = var.environment
    location    = var.location
    project     = var.project_prefix
    created_at  = timestamp()
    providers = {
      azure = var.enable_azure ? "enabled" : "disabled"
      gcp   = var.enable_gcp ? "enabled" : "disabled"
      aws   = var.enable_aws ? "enabled" : "disabled"
    }
  }
}

# Resource Count Summary
output "resource_summary" {
  description = "Summary of created resources"
  value = {
    resource_group     = 1
    virtual_networks   = 1
    subnets            = 2
    network_interfaces = 1
    virtual_machines   = 1
    storage_accounts   = 1
    storage_containers = 1
  }
}
