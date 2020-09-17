provider "azurerm" {
  version = "2.27.0"
}

provider "azuread" {
  version = "1.0.0"
}

resource "azurerm_sql_server" "server" {
  resource_group_name          = var.resource_group_name
  name                         = var.server_name
  location                     = var.server_location
  administrator_login          = var.server_administrator_username
  administrator_login_password = var.server_administrator_password
  version                      = var.server_version
  connection_policy            = var.server_connection_policy

  identity = {
    type = "SystemAssigned"
  }

  extended_auditing_policy {
    storage_endpoint                        = var.storage_account_access_key
    storage_account_access_key              = var.storage_account_endpoint
    storage_account_access_key_is_secondary = var.storage_account_access_key_is_secondary
    retention_in_days                       = var.storage_account_retention_in_days
  }

  tags = var.tags
}

data "azuread_group" "administrators" {
    name = var.sql_administrator_active_directory_group
}

resource "azurerm_sql_active_directory_administrator" "aad_admin" {
  server_name         = azurerm_sql_server.server.name
  resource_group_name = var.resoruce_group_name
  login               = var.sql_administrator_active_directory_group
  tenant_id           = data.azuread_group.administrators.tenant_id
  object_id           = data.azuread_group.administrators.id
}

resource "azurerm_sql_firewall_rule" "allow" {
  count               = length(var.server_firewall_rules)
  name                = var.server_firewall_rules[count.index].name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.server.name
  start_ip_address    = var.server_firewall_rules[count.index].start_ip_address
  end_ip_address      = var.server_firewall_rules[count.index].end_ip_address
}

resource "azurerm_sql_firewall_rule" "allow_azure" {
  count               = var.server_firewall_allow_azure == true ? 1 : 0
  name                = "azure"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}