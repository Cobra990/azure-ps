#Variables für die Einrichtung von Container on Azure
$global:SubscriptionName = "SUB1"
#Azure RG for the Docker
$global:RGName = "ACIRG"
# Azure container registry name
$global:ACRName = "atikin01"
#Docker image name
$global:DOImage = "atikinme"
$global:DOImageTag = "atikinme:20230912"
# ---------------------------
# DO NOT CHANGE
# ---------------------------
#  ACR login url
$global:ACRURL = "$ACRName.azurecr.io"