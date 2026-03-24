# ============================================
# Terraform Variables
# Sovereign Cloud Fabric - Infrastructure Simulation
# ============================================

variable "environment" {
  description = "Environment name (e.g., dev, staging, production, simulation)"
  type        = string
  default     = "simulation"

  validation {
    condition     = contains(["dev", "staging", "production", "simulation"], var.environment)
    error_message = "Environment must be one of: dev, staging, production, simulation"
  }
}

variable "location" {
  description = "Azure region location"
  type        = string
  default     = "southeastasia"

  validation {
    condition = contains([
      "eastasia",
      "southeastasia",
      "centralus",
      "eastus",
      "westus",
      "uksouth",
      "westeurope"
    ], var.location)
    error_message = "Location must be a valid Azure region"
  }
}

variable "project_prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "vsp"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]*$", var.project_prefix))
    error_message = "Prefix must start with lowercase letter and contain only lowercase letters, numbers, and hyphens"
  }
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "VSP Porto Simulation"
  }
}

# VM Configuration
variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "vspadmin"
  sensitive   = true
}

# Network Configuration
variable "vnet_address_space" {
  description = "Virtual network address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Subnet address prefixes"
  type        = map(list(string))
  default = {
    internal = ["10.0.1.0/24"]
    dmz      = ["10.0.2.0/24"]
    public   = ["10.0.3.0/24"]
  }
}

# Storage Configuration
variable "storage_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.storage_tier)
    error_message = "Storage tier must be Standard or Premium"
  }
}

variable "storage_replication" {
  description = "Storage replication type"
  type        = string
  default     = "LRS"

  validation {
    condition = contains([
      "LRS", # Locally Redundant
      "GRS", # Geo-Redundant
      "ZRS", # Zone-Redundant
      "GZRS" # Geo-Zone-Redundant
    ], var.storage_replication)
    error_message = "Invalid replication type"
  }
}

# Enable/Disable Cloud Providers
variable "enable_azure" {
  description = "Enable Azure resources"
  type        = bool
  default     = true
}

variable "enable_gcp" {
  description = "Enable GCP resources"
  type        = bool
  default     = false
}

variable "enable_aws" {
  description = "Enable AWS resources"
  type        = bool
  default     = false
}
