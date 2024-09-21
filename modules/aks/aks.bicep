param aksClusterName string
param location string = 'eastus'
param nodePoolName string = 'nodepool1'
param nodeCount int = 2
param minCount int = 2
param maxCount int = 3
param vmSize string = 'Standard_B2s'

resource aks 'Microsoft.ContainerService/managedClusters@2024-06-02-preview' = {
  location: location
  name: aksClusterName
  identity: {
    type: 'SystemAssigned'
  }
  properties: {

    agentPoolProfiles: [
      {
        name: nodePoolName
        count: nodeCount
        minCount: minCount
        maxCount: maxCount
        enableAutoScaling: true
        vmSize: vmSize
        mode: 'System'
        osDiskSizeGB: 128
        osSKU: 'Ubuntu'
        osType: 'Linux'
        orchestratorVersion: '1.29'
        powerState: {
          code: 'Running'
        }
        securityProfile: {
          sshAccess: 'LocalUser'
        }
        type: 'VirtualMachineScaleSets'
        upgradeSettings: {
          maxSurge: '10%'
        }
      }
    ]
    autoScalerProfile: {
      'balance-similar-node-groups': 'false'
      'scale-down-delay-after-add': '10m'
      'scale-down-delay-after-delete': '10s'
      'scale-down-delay-after-failure': '3m'
      'scale-down-unneeded-time': '10m'
      'scale-down-unready-time': '20m'
      'scale-down-utilization-threshold': '0.5'
      'scan-interval': '10s'
      'skip-nodes-with-system-pods': 'true'
    }
    dnsPrefix: '${aksClusterName}-dns'
    enableRBAC: true
    networkProfile: {
      dnsServiceIP: '10.0.0.10'
      loadBalancerSku: 'standard'
      networkPlugin: 'kubenet'
      serviceCidr: '10.0.0.0/16'
      podCidr: '10.244.0.0/16'
    }
  }
  sku: {
    name: 'Base'
    tier: 'Free'
  }
}

resource nodepool 'Microsoft.ContainerService/managedClusters/agentPools@2024-06-02-preview' = {
  parent: aks
  name: nodePoolName
  properties: {
    count: nodeCount
    minCount: minCount
    maxCount: maxCount
    enableAutoScaling: true
    vmSize: vmSize
    mode: 'System'
    osDiskSizeGB: 128
    osSKU: 'Ubuntu'
    osType: 'Linux'
    orchestratorVersion: '1.29'
  }
}
