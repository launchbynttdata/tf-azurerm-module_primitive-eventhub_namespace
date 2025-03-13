// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

output "namespace_id" {
  description = "The ID of the Event Hub Namespace"
  value       = azurerm_eventhub_namespace.eventhub_namespace.id
}

output "namespace_name" {
  description = "The Name of the Event Hub Namespace"
  value       = azurerm_eventhub_namespace.eventhub_namespace.name
}

output "public_network_access_enabled" {
  description = "Is Public network access enabled?"
  value       = azurerm_eventhub_namespace.eventhub_namespace.public_network_access_enabled
}

output "default_primary_connection_string" {
  description = "The primary connection string for the authorization rule RootManageSharedAccessKey"
  value       = azurerm_eventhub_namespace.eventhub_namespace.default_primary_connection_string
  sensitive   = true
}

output "default_primary_key" {
  description = "The primary key for the authorization rule RootManageSharedAccessKey"
  value       = azurerm_eventhub_namespace.eventhub_namespace.default_primary_key
  sensitive   = true
}

output "default_secondary_connection_string" {
  description = "The secondary connection string for the authorization rule RootManageSharedAccessKey"
  value       = azurerm_eventhub_namespace.eventhub_namespace.default_secondary_connection_string
  sensitive   = true
}

output "default_secondary_key" {
  description = "The secondary key for the authorization rule RootManageSharedAccessKey"
  value       = azurerm_eventhub_namespace.eventhub_namespace.default_secondary_key
  sensitive   = true
}
