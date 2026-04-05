# 🌐 Sovereign Cloud Fabric

## 📌 Project Overview
**Sovereign Cloud Fabric** is a high-level orchestration framework for managing distributed digital infrastructure. It enables the seamless provisioning and management of resources across multiple cloud providers (Azure, OCI, GCP) using a unified, code-driven approach.

This project embodies the concept of **Infrastructure Sovereignty**, ensuring that the control plane remains independent of any single provider.

---

## 🏗️ System Architecture (Distributed Control Plane)

```mermaid
flowchart TD
    %% Global Styling
    classDef default fill:#f9f9f9,stroke:#333,stroke-width:1px,color:#333,font-family:Inter,sans-serif;
    classDef control fill:#ede7f6,stroke:#4527a0,stroke-width:2px;
    classDef provider fill:#e3f2fd,stroke:#1565c0,stroke-width:2px;
    classDef compute fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px;
    classDef storage fill:#efebe9,stroke:#5d4037,stroke-width:2px;
    classDef infra fill:#eceff1,stroke:#455a64,stroke-width:1px;

    %% Nodes & Structure
    TF[Terraform CLI / CI-CD]
    
    subgraph CONTROL_PLANE [Unified Control Plane]
        direction TB
        STATE[(Terraform State)]
        VARS[Environment Variables]
    end

    subgraph CLOUD_NODES [Multi-Cloud Execution Layer]
        direction LR
        AZ[Microsoft Azure]
        OCI[Oracle Cloud]
        GCP[Google Cloud]
    end

    subgraph RESOURCES [Sovereign Resources]
        direction TB
        VM[Virtual Machines / Compute]
        NET[Virtual Networks / VCN]
        CONT[Container Registry]
    end

    %% Connections
    TF ==>|Provision| CONTROL_PLANE
    CONTROL_PLANE ==>|Apply Config| AZ
    CONTROL_PLANE ==>|Apply Config| OCI
    CONTROL_PLANE ==>|Apply Config| GCP
    
    AZ --- VM
    OCI --- NET
    GCP --- CONT
    
    %% Assign Classes
    class TF infra;
    class STATE,VARS control;
    class AZ,OCI,GCP provider;
    class VM,NET,CONT compute;
```

### 📋 Diagram Legend (IaC & Provisioning)
| Symbol/Style | Description | Classification |
| :--- | :--- | :--- |
| **Rectangle [ ]** | Infrastructure Modules or Cloud Providers | **Provider/Service** |
| **Cylinder [( )]** | Terraform State Persistence | **State Store** |
| **Bold Line (==>)** | Provisioning and Lifecycle Management | **Orchestration** |
| **Thin Line (---)** | Resource Association | **Dependency** |
| **Purple Box** | Unified Logic & Variables | **Control Plane** |
| **Blue Box** | External Cloud Ecosystems | **Execution Layer** |
| **Green Box** | Deployed Sovereign Assets | **Resource Layer** |

---

## 🚀 Key Components & Logic

### 1. The Orchestrator: Terraform
Terraform acts as the "Source of Truth" for the entire infrastructure. By using a modular design, the system can deploy identical network topologies and compute clusters across different clouds simultaneously.

### 2. State Management & Consistency
The **Terraform State** ensures that the actual infrastructure matches the desired state defined in code. This allows for rapid scaling, disaster recovery, and consistent security patching across the multi-cloud environment.

### 3. Resource Abstraction
Cloud-specific complexities (like Azure VNets vs. OCI VCNs) are abstracted into high-level Terraform modules. This allows the architect to focus on system design rather than provider-specific nuances.

---

## 🛡️ Provisioning Workflow

1.  **Code:** Define the desired infrastructure in HCL (HashiCorp Configuration Language).
2.  **Plan:** Terraform generates an execution plan, showing exactly what will be created, modified, or destroyed.
3.  **Apply:** The Control Plane communicates with Cloud APIs (Azure, OCI, etc.) to provision resources.
4.  **Sync:** Terraform updates the state file to reflect the live environment.
5.  **Audit:** Every infrastructure change is version-controlled via Git, providing a complete audit trail of the system's evolution.

---

## 🛠️ Tech Stack Employed

| Layer | Technologies |
| :--- | :--- |
| **IaC Orchestration** | ![](https://img.shields.io/badge/Terraform-7B42BC?style=flat&logo=terraform&logoColor=white) ![](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white) |
| **Cloud Providers** | ![](https://img.shields.io/badge/Azure-0078D4?style=flat&logo=microsoftazure&logoColor=white) ![](https://img.shields.io/badge/OCI-F80000?style=flat&logo=oracle&logoColor=white) ![](https://img.shields.io/badge/GCP-4285F4?style=flat&logo=googlecloud&logoColor=white) |
| **Containerization** | ![](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white) ![](https://img.shields.io/badge/Astro-FF5D01?style=flat&logo=astro&logoColor=white) |
| **Configuration** | ![](https://img.shields.io/badge/YAML-CB171E?style=flat&logo=yaml&logoColor=white) ![](https://img.shields.io/badge/HCL-623CE4?style=flat&logo=hashicorp&logoColor=white) |

---

## 🛠️ Simulation & Modules
Explore our **Terraform Modules** and deployment templates to simulate a sovereign cloud environment in your own infrastructure.

---
*Standardized by PES AI-Assistant (Gemini CLI)*
*Infrastructure-as-Code Compliance v1.0*
