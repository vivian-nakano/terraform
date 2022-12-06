resource "azurerm_resource_group" "rg" {
  for_each = {
    "EUA" = "East US"
    "Europa" = "West Europe"
    "Asia" = "Japan East"
  }

  name     = each.key
  location = each.value

  tags = local.common_tags
}

##NO ARQUIVO OUTPUT

output "location-resource-group-eua" { 
    value = azurerm_resource_group.resource_group["EUA"].location
}
output "location-resource-group-europa" { 
    value = azurerm_resource_group.resource_group["Europa"].location
}
output "location-resource-group-asia" { 
    value = azurerm_resource_group.resource_group["Asia"].location
}
