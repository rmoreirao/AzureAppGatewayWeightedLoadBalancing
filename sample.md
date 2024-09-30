https://learn.microsoft.com/en-us/azure/templates/microsoft.network/applicationgateways?pivots=deployment-language-bicep

{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "resources": [
    {
      "type": "Microsoft.Network/applicationGateways",
      "apiVersion": "2020-09-01",
      "name": "myAppGateway",
      "location": "[resourceGroup().location]",
      "properties": {
        "sku": {
          "name": "Standard_v2",
          "tier": "Standard_v2",
          "capacity": 2
        },
        "gatewayIPConfigurations": [
          {
            "name": "appGatewayIpConfig",
            "properties": {
              "subnet": {
                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'myVnet', 'mySubnet')]"
              }
            }
          }
        ],
        "frontendIPConfigurations": [
          {
            "name": "appGatewayFrontendIP",
            "properties": {
              "privateIPAddress": "10.0.0.10",
              "privateIPAllocationMethod": "Static",
              "subnet": {
                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'myVnet', 'mySubnet')]"
              }
            }
          }
        ],
        "frontendPorts": [
          {
            "name": "appGatewayFrontendPort",
            "properties": {
              "port": 80
            }
          }
        ],
        "backendAddressPools": [
          {
            "name": "backendPool1",
            "properties": {
              "backendAddresses": [
                {
                  "ipAddress": "10.0.1.4"
                }
              ]
            }
          },
          {
            "name": "backendPool2",
            "properties": {
              "backendAddresses": [
                {
                  "ipAddress": "10.0.1.5"
                }
              ]
            }
          }
        ],
        "backendHttpSettingsCollection": [
          {
            "name": "httpSettings",
            "properties": {
              "port": 80,
              "protocol": "Http",
              "cookieBasedAffinity": "Disabled",
              "requestTimeout": 20
            }
          }
        ],
        "httpListeners": [
          {
            "name": "appGatewayHttpListener",
            "properties": {
              "frontendIPConfiguration": {
                "id": "[concat(resourceId('Microsoft.Network/applicationGateways', 'myAppGateway'), '/frontendIPConfigurations/appGatewayFrontendIP')]"
              },
              "frontendPort": {
                "id": "[concat(resourceId('Microsoft.Network/applicationGateways', 'myAppGateway'), '/frontendPorts/appGatewayFrontendPort')]"
              },
              "protocol": "Http"
            }
          }
        ],
        "requestRoutingRules": [
          {
            "name": "routingRule",
            "properties": {
              "ruleType": "Basic",
              "httpListener": {
                "id": "[concat(resourceId('Microsoft.Network/applicationGateways', 'myAppGateway'), '/httpListeners/appGatewayHttpListener')]"
              },
              "backendAddressPool": {
                "id": "[concat(resourceId('Microsoft.Network/applicationGateways', 'myAppGateway'), '/backendAddressPools/backendPool1')]"
              },
              "backendHttpSettings": {
                "id": "[concat(resourceId('Microsoft.Network/applicationGateways', 'myAppGateway'), '/backendHttpSettingsCollection/httpSettings')]"
              },
              "priority": 1,
              "weight": 5
            }
          },
          {
            "name": "routingRule2",
            "properties": {
              "ruleType": "Basic",
              "httpListener": {
                "id": "[concat(resourceId('Microsoft.Network/applicationGateways', 'myAppGateway'), '/httpListeners/appGatewayHttpListener')]"
              },
              "backendAddressPool": {
                "id": "[concat(resourceId('Microsoft.Network/applicationGateways', 'myAppGateway'), '/backendAddressPools/backendPool2')]"
              },
              "backendHttpSettings": {
                "id": "[concat(resourceId('Microsoft.Network/applicationGateways', 'myAppGateway'), '/backendHttpSettingsCollection/httpSettings')]"
              },
              "priority": 2,
              "weight": 95
            }
          }
        ]
      }
    }
  ]
}