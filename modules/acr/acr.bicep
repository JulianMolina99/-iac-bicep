param acrName string
param location string = 'eastus'

resource acr 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  location: location
  name: acrName
  properties: {
    adminUserEnabled: false
    anonymousPullEnabled: false
    dataEndpointEnabled: false
    encryption: {
      status: 'disabled'
    }
    metadataSearch: 'Disabled'
    networkRuleBypassOptions: 'AzureServices'
    policies: {
      azureADAuthenticationAsArmPolicy: {
        status: 'enabled'
      }
      exportPolicy: {
        status: 'enabled'
      }
      quarantinePolicy: {
        status: 'disabled'
      }
      retentionPolicy: {
        days: 7
        status: 'disabled'
      }
      softDeletePolicy: {
        retentionDays: 7
        status: 'disabled'
      }
      trustPolicy: {
        status: 'disabled'
        type: 'Notary'
      }
    }
    publicNetworkAccess: 'Enabled'
    zoneRedundancy: 'Disabled'
  }
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}

resource acrRepositoriesAdmin 'Microsoft.ContainerRegistry/registries/scopeMaps@2023-11-01-preview' = {
  parent: acr
  name: '_repositories_admin'
  properties: {
    actions: [
      'repositories/*/metadata/read'
      'repositories/*/metadata/write'
      'repositories/*/content/read'
      'repositories/*/content/write'
      'repositories/*/content/delete'
    ]
    description: 'Can perform all read, write and delete operations on the registry'
  }
}

resource acrRepositoriesPull 'Microsoft.ContainerRegistry/registries/scopeMaps@2023-11-01-preview' = {
  parent: acr
  name: '_repositories_pull'
  properties: {
    actions: [
      'repositories/*/content/read'
    ]
    description: 'Can pull any repository of the registry'
  }
}

resource acrRepositoriesPush 'Microsoft.ContainerRegistry/registries/scopeMaps@2023-11-01-preview' = {
  parent: acr
  name: '_repositories_push'
  properties: {
    actions: [
      'repositories/*/content/read'
      'repositories/*/content/write'
    ]
    description: 'Can push to any repository of the registry'
  }
}
