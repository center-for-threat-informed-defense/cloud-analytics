# create sp in azure for testing with valid role and resource group

```shell
let "randomIdentifier=$RANDOM*$RANDOM"
servicePrincipalName="catest-$randomIdentifier"
roleName="Contributor"
subscriptionID=$(az account show --query id -o tsv)
# Verify the ID of the active subscription
echo "Using subscription ID $subscriptionID"
resourceGroup="casandbox"

echo "Creating SP for RBAC with name $servicePrincipalName, with role $roleName and in scopes /subscriptions/$subscriptionID/resourceGroups/$resourceGroup"
az ad sp create-for-rbac --name $servicePrincipalName --role $roleName --scopes /subscriptions/$subscriptionID/resourceGroups/$resourceGroup
```

```plain
echo "Creating SP for RBAC with name $servicePrincipalName, with role $roleName and in scopes /subscriptions/$subscriptionID/resourceGroups/$resourceGroup"
az ad sp create-for-rbac --name $servicePrincipalName --role $roleName --scopes /subscriptions/$subscriptionID/resourceGroups/$resourceGroup
Using subscription ID a282ebec-a0ab-45b6-bf86-c3eef61f241d
Creating SP for RBAC with name catest-153983725, with role Contributor and in scopes /subscriptions/a282ebec-a0ab-45b6-bf86-c3eef61f241d/resourceGroups/casandbox
This command or command group has been migrated to Microsoft Graph API. Please carefully review all breaking changes introduced during this migration: https://docs.microsoft.com/cli/azure/microsoft-graph-migration
Creating 'Contributor' role assignment under scope '/subscriptions/a282ebec-a0ab-45b6-bf86-c3eef61f241d/resourceGroups/casandbox'
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
{
  "appId": "701b8f74-9aad-4634-a764-bd3b5d2abf63",
  "displayName": "catest-153983725",
  "password": "~Oz8Q~Gh2QTnagBZcWLfw3_mb4-mUBtCW_LkdbLu",
  "tenant": "c5401d10-4d87-4ea7-95c3-e75d9ba6318a"
}
```
