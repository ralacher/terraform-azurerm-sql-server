output "server_resource_id" {
  value       = azurerm_sql_server.server.id
  description = "The Azure Resource Mananger ID for the SQL Server."
}

output "server_fqdn" {
  value       = azurerm_sql_server.server.fully_qualified_domain_name
  description = "The fully qualified domain name of the Azure SQL Server (e.g. myServerName.database.windows.net)."
}

output "server_principal_id" {
  value       = azurerm_sql_server.server.identity.principal_id
  description = "The Principal ID for the Service Principal associated with the Identity of this SQL Server."
}
