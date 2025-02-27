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
  description = "Tag to assign to the resource"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Enable or disable public network access"
  type        = bool
  default     = false
}

variable "capacity" {
  description = "The capacity of the Event Hub Namespace"
  type        = number
  default     = 1
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}
