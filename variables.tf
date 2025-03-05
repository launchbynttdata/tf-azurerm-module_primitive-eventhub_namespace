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
    condition = (
      (var.sku == "Basic" && var.capacity == 1) ||
      (var.sku == "Standard" && var.capacity >= 1 && var.capacity <= 20) ||
      (var.sku == "Premium" && var.capacity >= 1 && var.capacity <= 4)
    )
    error_message = "The capacity must be 1 for Basic, between 1-20 for Standard, or between 1-4 for Premium"
  }

}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}
