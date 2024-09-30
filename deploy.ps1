$env:RG_NAME="rg-appgateway-loadbalancing-uk"
$env:VM1_NAME="myVM1"
$env:VM2_NAME="myVM2"

az group create --name $env:RG_NAME --location uksouth

$vm1Exists = az vm show --resource-group $env:RG_NAME --name $env:VM1_NAME --query "name" --output tsv

if ($vm1Exists) {
    az vm start --resource-group $env:RG_NAME --name $env:VM1_NAME
    Write-Output "Virtual machine '$env:VM1_NAME' has been started."
}

$vm2Exists = az vm show --resource-group $env:RG_NAME --name $env:VM2_NAME --query "name" --output tsv

if ($vm2Exists) {
    az vm start --resource-group $env:RG_NAME --name $env:VM2_NAME
    Write-Output "Virtual machine '$env:VM2_NAME' has been started."
}

az deployment group create --resource-group $env:RG_NAME --template-file main.bicep --parameters adminUsername=vmadmin