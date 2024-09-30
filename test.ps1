$env:RG_NAME="rg-appgateway-loadbalancing-uk"
$env:PUBLIC_IP_NAME="public_ip0"


# get the public ip of App Gateway using az cli
$publicIp = az network public-ip show --resource-group $env:RG_NAME --name $env:PUBLIC_IP_NAME --query "ipAddress" --output tsv

$url = "http://$publicIp/"
$outputFile = "results.txt"

# Ensure the output file is empty before starting
Clear-Content -Path $outputFile -ErrorAction SilentlyContinue

for ($i = 1; $i -le 100; $i++) {
    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing
        $result = $response.Content
    } catch {
        $result = "Error: $_"
    }
    Write-Host "Request $i - Result: $result"
    $result | Out-File -FilePath $outputFile -Append
}

# Read the content of the file
$content = Get-Content -Path $outputFile

# Group the content by unique values and count the occurrences
$groupedContent = $content | Group-Object

# Output the count for each unique value
foreach ($group in $groupedContent) {
    Write-Output "$($group.Name): $($group.Count)"
}