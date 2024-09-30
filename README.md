# Description

Azure App Gateway does not have a configuration to do Percentage Weighted Load Balancing - App Gateway uses uses a round-robin algorithm to route the requests between healthy servers (https://learn.microsoft.com/en-us/azure/application-gateway/how-application-gateway-works). A workaround for that is to create multiple entries on the Backend Pool pointing to the same endpoint, so you can for example:
- 9 entries pointing to IP 10.0.0.1
- 1 entry  pointing to IP 10.0.0.2

Challenge is that Backend Pool only allow unique entries - one solution for that is to create fake DNS entries that all point to the same IP Address "10.0.0.1".

This sample uses Private DNS Zone to create fake DNS entries. 

# Resources

Deploys 2 VMs, one App Gateway for the LoadBalancing and Private DNS Zone for the fake DNS entries

# Deploy

run ./deploy.ps1

# Testing the solution

run ./test.ps1

# Destroy

run ./destroy.ps1