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

variable "namespace_name" {
  description = "The name of the Event Hub Namespace"
  type        = string
}

variable "location" {
  description = "The Azure region where the Event Hub will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The Azure region where the Event Hub will be deployed"
  type        = string
}

variable "sku" {
  description = "The sku for the eventhub namespace. Possible values: Basic, Standard, Premium"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "The SKU must be of: Basic, Standard, Premium."
  }
}

variable "public_network_access_enabled" {
  description = "Enable or disable public network access"
  type        = bool
  default     = false
}

variable "network_rule_set" {
  description = <<EOT
  Optional network rule set for the Event Hub Namespace.
  Use this to restrict public access while still allowing trusted Azure services.
  EOT
  type = object({
    default_action                 = optional(string, "Deny")
    trusted_service_access_enabled = optional(bool, true)
    ip_rules = optional(list(object({
      ip_mask = string
      action  = optional(string, "Allow")
    })), [])
    virtual_network_rules = optional(list(object({
      subnet_id                                       = string
      ignore_missing_virtual_network_service_endpoint = optional(bool, false)
    })), [])
  })
  default = null

  validation {
    condition     = try(var.network_rule_set == null ? true : contains(["Allow", "Deny"], var.network_rule_set.default_action), false)
    error_message = "network_rule_set.default_action must be either Allow or Deny."
  }
}

variable "capacity" {
  description = <<EOT
  The capacity of the Event Hub Namespace:
  - Basic: 1
  - Standard: Between 1 and 20
  - Premium: Between 1 and 4
  EOT
  type        = number
  default     = 1

  validation {
    condition     = var.capacity >= 1
    error_message = "capacity must be greater than or equal to 1."
  }
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}
