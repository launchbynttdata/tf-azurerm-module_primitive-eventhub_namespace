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


resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                          = var.namespace_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  capacity                      = var.capacity
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "network_rulesets" {
    for_each = var.network_rule_set != null ? [var.network_rule_set] : []

    content {
      default_action                 = network_rulesets.value.default_action
      public_network_access_enabled  = var.public_network_access_enabled
      trusted_service_access_enabled = network_rulesets.value.trusted_service_access_enabled

      dynamic "ip_rule" {
        for_each = network_rulesets.value.ip_rules

        content {
          ip_mask = ip_rule.value.ip_mask
          action  = ip_rule.value.action
        }
      }

      dynamic "virtual_network_rule" {
        for_each = network_rulesets.value.virtual_network_rules

        content {
          subnet_id                                       = virtual_network_rule.value.subnet_id
          ignore_missing_virtual_network_service_endpoint = virtual_network_rule.value.ignore_missing_virtual_network_service_endpoint
        }
      }
    }
  }

  tags = var.tags

  lifecycle {
    precondition {
      condition = (
        (var.sku == "Basic" && var.capacity == 1) ||
        (var.sku == "Standard" && var.capacity >= 1 && var.capacity <= 20) ||
        (var.sku == "Premium" && var.capacity >= 1 && var.capacity <= 4)
      )
      error_message = "The capacity must be 1 for Basic, between 1-20 for Standard, or between 1-4 for Premium."
    }
  }
}
