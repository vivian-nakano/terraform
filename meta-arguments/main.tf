##peguei o exemplo de criar um modulo remoto na azure
##apenas referenciando o depends_on
##neste caso, o depends on vai dizer que precisar que o resource group seja primeiro criado, para depois o module network ser criado

module "network" {
    source = "Azure/network/azurerm"
    version = "3.5.0"

    depends_on = [azurerm_resource_group.resource_group] ## é uma lista de recursos

    resource_group_name = azurerm_resource_group.resource_group.name
}