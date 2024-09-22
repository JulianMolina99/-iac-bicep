param acrName string
param aksClusterName string
param location string
param apiManagementServiceName string
param publisherEmail string
param publisherName string

module acrModule '../../modules/acr/acr.bicep' = {
  name: 'deployAcr'
  params: {
    acrName: acrName
    location: location
  }
}

module aksModule '../../modules/aks/aks.bicep' = {
  name: 'deployAks'
  params: {
    aksClusterName: aksClusterName
    location: location
    nodeCount: 2
    minCount: 2
    maxCount: 3
    vmSize: 'Standard_B2s'
  }
}

module apiManagement '../../modules/apim/apim.bicep' = {
  name: 'deployApiManagement'
  params: {
    apiManagementServiceName: apiManagementServiceName
    location: location
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}