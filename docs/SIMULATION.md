# Multi-Cloud IaC Simulation

> Terraform Infrastructure Orchestration - Simulation Guide

## Overview

Multi-Cloud IaC is a sovereign infrastructure demonstration showcasing Terraform-based multi-cloud provisioning. This simulation allows you to experience Infrastructure-as-Code management across multiple cloud providers locally.

## Prerequisites

- Docker 20.10+
- Docker Compose v2+
- Terraform 1.0+ (optional, for CLI usage)
- 2GB+ RAM recommended

## Quick Start

### Option 1: Using vsp-porto (Recommended)

```bash
# Install vsp-porto
curl -fsSL https://porto.vspatabuga.io/ | sh

# Install Multi-Cloud IaC simulation
vsp-porto install iac

# Start the simulation
vsp-porto start iac -o

# View logs
vsp-porto logs iac -f
```

### Option 2: Direct Docker

```bash
git clone https://github.com/vspatabuga/sovereign-cloud-fabric.git
cd sovereign-cloud-fabric
./simulate.sh
```

## Access URLs

| Service | URL | Description |
|---------|-----|-------------|
| Terraform UI | http://localhost:3002 | Infrastructure dashboard |
| Terraform CLI | docker exec | Run terraform commands |

## Features

- **Multi-Cloud Provisioning** - Simulated Azure, OCI, GCP
- **Terraform State Management** - Infrastructure state control
- **Provider Abstraction** - Cloud-agnostic configurations
- **Resource Visualization** - Interactive infrastructure map
- **Plan/Apply Workflow** - Standard IaC operations

## Components

### Terraform Docker
Containerized Terraform execution environment.

### State Backend
Local state storage simulating remote backend.

### Provider Modules
Abstraction layer for multi-cloud resources.

## Demo Workflow

1. **Initialize** - `terraform init`
2. **Plan** - `terraform plan`
3. **Apply** - `terraform apply`
4. **Inspect** - View created resources

## Terraform Commands

```bash
# Enter Terraform container
docker exec -it vsp-iac-terraform sh

# Initialize
terraform init

# Plan changes
terraform plan

# Apply infrastructure
terraform apply

# Show state
terraform show

# Destroy
terraform destroy
```

## Stopping the Simulation

```bash
# Using vsp-porto
vsp-porto stop iac

# Or using docker-compose
docker compose -p vsp-iac down
```

## Troubleshooting

### Terraform init fails

```bash
# Check provider versions
cat terraform/providers.tf

# Clear cache
rm -rf .terraform
terraform init
```

## Documentation

- [Architecture](./ARCHITECTURE.md)
- [Development Setup](./SETUP.md)
