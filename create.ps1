# load variables
. C:\Users\00016306\Documents\_coderepo\azure-pipeline\_variables.ps1
Clear-Host
#Connect to Azure
Connect-AzAccount

# Set context for subscription 
Set-AzContext -SubscriptionName $SubscriptionName

# Create new resource group 
New-AzResourceGroup -Name $RGName -Location EastUS

# Create container registry (repo)
New-AzContainerRegistry -ResourceGroupName $RGName -Name $ACRName -EnableAdminUser -Sku Basic

# Get credentials for ACR-adminuser
$ACRcred = Get-AzContainerRegistryCredential -ResourceGroupName $RGName -RegistryName $ACRName 

# Docker upload the local image to the Container registry on azure
# Docker login to Azure 
docker login $ACRURL --username $ACRname --password $ACRcred.Password 
# Create Tag and Pushing Local Container Images to ACR
docker tag $DOImageTag $ACRURL/$DOImageTag
docker push $ACRURL/$DOImageTag
Write-Host "Docker object uploaded" -ForegroundColor Green

# Create container Object
$container = New-AzContainerInstanceObject -Name $DOimage -Image $ACRURL/$DOImageTag
Write-Host "New container instance will created" -ForegroundColor Green
# Create Image Registry Credetial Object
$IMRegCred = New-AzContainerGroupImageRegistryCredentialObject -Server $ACRURL -Username $ACRcred.Username -Password (ConvertTo-SecureString $ACRcred.Password -AsPlainText -Force)

# Creste Container instance and run the container
$null = New-AzContainerGroup -ResourceGroupName $RGName -Name $DOimage -Location eastus -Container $container -ImageRegistryCredential $IMRegCred -IpAddressType Public -OSType 'Linux' #-DnsNameLabel 'atikin'
Write-Host "Container instance successfull created" -ForegroundColor Green
###################################
Write-Host "Docker container successfull uploaded and startet!" -ForegroundColor Green
####################################