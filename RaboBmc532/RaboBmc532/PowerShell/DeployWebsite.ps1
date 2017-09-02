#
# DeployWebsite.ps1
#

#$webappname="mywebapp$(Get-Random)"
#$location="West Europe"

## Create a resource group.
#New-AzureRmResourceGroup -Name $webappname -Location $location

## Create an App Service plan in Free tier.
#New-AzureRmAppServicePlan -Name $webappname -Location $location -ResourceGroupName $webappname -Tier Free

## Create a web app.
#New-AzureRmWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName $webappname

Select-AzureRmSubscription -SubscriptionName 'Visual Studio Enterprise'
$appsettings = @{'psKey' = 'psValue'; 'AzureKey' = 'AzureValue'; 'OverriddenKey' = 'OverriddenValueAzure'}
Set-AzureRmWebAppSlot -ResourceGroupName RaboBmc532 -Name RaboBmc532 -Slot production -AppSettings $appsettings
# To display the AppSettings for the web app...
$webapp = Get-AzureRmWebAppSlot -ResourceGroupName RaboBmc532 -Name RaboBmc532 -Slot production
$webapp.SiteConfig.AppSettings

# Configure GitHub deployment from your GitHub repo and deploy once.
$gitrepo="https://github.com/bmcarnahan/RaboBmcAzure.git"
$PropertiesObject = @{
    repoUrl = "$gitrepo";
    branch = "master";
    isManualIntegration = "true";
}
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGroupName RaboBmc532 -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName RaboBmc532/web -ApiVersion 2015-08-01 -Force

# Add a new web slot
New-AzureRmWebAppSlot -ResourceGroupName RaboBmc532 -Name RaboBmc532 -Slot development

# Remove an existing web slot
Remove-AzureRmWebAppSlot -ResourceGroupName RaboBmc532 -Name RaboBmc532 -Slot development

# Switch from the development web slot to the production web slot.
Switch-AzureRmWebAppSlot -SourceSlotName development -DestinationSlotName production -ResourceGroupName RaboBmc532 -Name RaboBmc532