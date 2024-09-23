# Application Infrastructure Documentation

This documentation explains the infrastructure defined in **Bicep** templates and how the components (AKS, ACR, API Management) are interconnected. The **FastAPI** application is deployed in an **Azure Kubernetes Service (AKS)** cluster with an **API Management** layer in front, and all resources are provisioned and managed using modular Bicep files. Here's a breakdown of the repository structure, the key components, and how they work together.

---

## Repository Structure and Modules

### Directory Structure:
- **`environments/prod`**: 
  - **`main.bicep`**: The main orchestration file that connects all the infrastructure modules for the production environment.
  - **`parameters.json`**: Contains environment-specific values such as resource names and locations.
  
- **`modules/acr/acr.bicep`**: Manages the Azure Container Registry (ACR), used for storing Docker images for the FastAPI application.
  
- **`modules/aks/aks.bicep`**: Defines the AKS cluster and node pools where the FastAPI application will be deployed.
  
- **`modules/apim/apim.bicep`**: Deploys Azure API Management, which controls access to the FastAPI application in AKS.

---