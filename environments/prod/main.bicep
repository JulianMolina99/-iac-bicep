param acrName string = 'acrtechnicalassessmentprod'
param aksClusterName string = 'aks-technicalassessment-prod'
param location string = 'eastus'

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

module apiManagement 'modules/apim/apim.bicep' = {
  name: 'deployApiManagement'
  params: {
    apiManagementServiceName: 'api-technicalassessment-prod'
    location: 'East US'
    publisherEmail: 'julianmolinac99@gmail.com'
    publisherName: 'Technical Assessment'
  }
}
