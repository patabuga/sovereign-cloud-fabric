# ============================================
# VSP Multi-Cloud Terraform Configuration
# Sovereign Cloud Fabric - Infrastructure Simulation
# ============================================

terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote state for multi-cloud (simulated)
  backend "local" {
    path = "terraform.tfstate"
  }
}

# ============================================
# Variables
# ============================================

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "simulation"
}

variable "location" {
  description = "Primary location for resources"
  type        = string
  default     = "southeastasia"
}

variable "project_prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "vsp"
}

# ============================================
# Azure Resource Group (Simulated)
# ============================================

resource "azurerm_resource_group" "main" {
  name     = "${var.project_prefix}-${var.environment}-rg"
  location = var.location

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "VSP Porto Simulation"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.project_prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "dmz" {
  name                 = "dmz"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

# ============================================
# Azure VM (Simulated Web Server)
# ============================================

resource "azurerm_virtual_machine" "web" {
  name                = "${var.project_prefix}-web-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vm_size             = "Standard_B1s"

  network_interface_ids = [azurerm_network_interface.web.id]

  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "webserver"
    admin_username = "vspadmin"
    admin_password = "VspSimulation123!" # Demo only!
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    Environment = var.environment
    Role        = "WebServer"
  }
}

resource "azurerm_network_interface" "web" {
  name                = "${var.project_prefix}-web-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Environment = var.environment
  }
}

# ============================================
# Azure Storage Account (Simulated)
# ============================================

resource "azurerm_storage_account" "main" {
  name                     = "${var.project_prefix}store${var.environment}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_storage_container" "data" {
  name                  = "simulation-data"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

# ============================================
# GCP Resources (Simulated Comments)
# ============================================

# In production, these would be uncommented:
# 
# provider "google" {
#   project = "vsp-simulation"
#   region  = "asia-southeast1"
# }
# 
# resource "google_compute_instance" "web" {
#   name         = "web-server"
#   machine_type = "e2-medium"
#   zone         = "asia-southeast1-a"
#   
#   boot_disk {
#     initialize_params {
#       image = "debian-11"
#     }
#   }
#   
#   network_interface {
#     network = "default"
#   }
# }

# ============================================
# AWS Resources (Simulated Comments)
# ============================================

# In production, these would be uncommented:
#
# provider "aws" {
#   region = "ap-southeast-1"
# }
#
# resource "aws_instance" "web" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t3.micro"
#   
#   tags = {
#     Name = "vsp-web-server"
#   }
# }
