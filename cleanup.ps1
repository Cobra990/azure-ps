###
Clear-Host
Write-Host "Load variables..." -ForegroundColor Green
. C:\Users\00016306\Documents\_coderepo\azure-pipeline\_variables.ps1
Write-Host "Done!" -ForegroundColor Red

Write-Host "Clean up is started..." -ForegroundColor Green

# Connect to Azure 
Write-Host "Connect to Azure..." -ForegroundColor Green
#Connect-AzAccount
Write-Host "Done!" -ForegroundColor Green

#Set subscription context
Write-Host "Choise right subcription..." -ForegroundColor Green
$null = Set-AzContext -SubscriptionName $SubscriptionName
Write-Host "Done!"

# Clean up all created objects
Write-Host "Clean up files..." -ForegroundColor Green
$null = Remove-AzResourceGroup -Name $RGName -Force
Write-Host "All created resources for the project are cleaned up!" -ForegroundColor Green