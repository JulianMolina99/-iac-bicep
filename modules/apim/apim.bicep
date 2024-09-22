param apiManagementServiceName string
param location string = 'East US'
param publisherEmail string
param publisherName string

resource apiManagement 'Microsoft.ApiManagement/service@2023-09-01-preview' = {
  name: apiManagementServiceName
  location: location
  sku: {
    name: 'Developer'
    capacity: 1
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
    publicNetworkAccess: 'Enabled'
    virtualNetworkType: 'None'
  }
}