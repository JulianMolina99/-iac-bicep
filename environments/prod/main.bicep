param acrName string = 'acrtechnicalassessmentprod'
param aksClusterName string = 'aksCluster'
param location string = 'eastus'

module acrModule './modules/acr.bicep' = {
  name: 'deployAcr'
  params: {
    acrName: acrName
    location: location
  }
}

module aksModule './modules/aks.bicep' = {
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
