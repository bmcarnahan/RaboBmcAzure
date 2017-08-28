#
# DeployWebsite.ps1
#
# Replace the following URL with a public GitHub repo URL
$gitrepo="https://github.com/bmcarnahan/RaboBmcAzure.git"

#$webappname="mywebapp$(Get-Random)"
#$location="West Europe"

## Create a resource group.
#New-AzureRmResourceGroup -Name $webappname -Location $location

## Create an App Service plan in Free tier.
#New-AzureRmAppServicePlan -Name $webappname -Location $location -ResourceGroupName $webappname -Tier Free

## Create a web app.
#New-AzureRmWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName $webappname

# Configure GitHub deployment from your GitHub repo and deploy once.
$PropertiesObject = @{
    repoUrl = "$gitrepo";
    branch = "master";
    isManualIntegration = "true";
}
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGroupName RaboBmc532 -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName RaboBmc532/web -ApiVersion 2015-08-01 -Force
