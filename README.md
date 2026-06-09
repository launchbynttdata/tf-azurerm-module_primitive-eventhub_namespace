<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.77, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.76.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub_namespace.eventhub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace_name"></a> [namespace\_name](#input\_namespace\_name) | The name of the Event Hub Namespace | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Event Hub will be deployed | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Azure region where the Event Hub will be deployed | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The sku for the eventhub namespace. Possible values: Basic, Standard, Premium | `string` | `"Standard"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enable or disable public network access | `bool` | `false` | no |
| <a name="input_network_rule_set"></a> [network\_rule\_set](#input\_network\_rule\_set) | Optional network rule set for the Event Hub Namespace.<br/>  Use this to restrict public access while still allowing trusted Azure services. | <pre>object({<br/>    default_action                 = optional(string, "Deny")<br/>    trusted_service_access_enabled = optional(bool, true)<br/>    ip_rules = optional(list(object({<br/>      ip_mask = string<br/>      action  = optional(string, "Allow")<br/>    })), [])<br/>    virtual_network_rules = optional(list(object({<br/>      subnet_id                                       = string<br/>      ignore_missing_virtual_network_service_endpoint = optional(bool, false)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The capacity of the Event Hub Namespace:<br/>  - Basic: 1<br/>  - Standard: Between 1 and 20<br/>  - Premium: Between 1 and 4 | `number` | `1` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace_id"></a> [namespace\_id](#output\_namespace\_id) | The ID of the Event Hub Namespace |
| <a name="output_namespace_name"></a> [namespace\_name](#output\_namespace\_name) | The Name of the Event Hub Namespace |
| <a name="output_public_network_access_enabled"></a> [public\_network\_access\_enabled](#output\_public\_network\_access\_enabled) | Is Public network access enabled? |
| <a name="output_trusted_service_access_enabled"></a> [trusted\_service\_access\_enabled](#output\_trusted\_service\_access\_enabled) | Whether trusted Azure services are allowed by the namespace network rule set |
| <a name="output_default_primary_connection_string"></a> [default\_primary\_connection\_string](#output\_default\_primary\_connection\_string) | The primary connection string for the authorization rule RootManageSharedAccessKey |
| <a name="output_default_primary_key"></a> [default\_primary\_key](#output\_default\_primary\_key) | The primary key for the authorization rule RootManageSharedAccessKey |
| <a name="output_default_secondary_connection_string"></a> [default\_secondary\_connection\_string](#output\_default\_secondary\_connection\_string) | The secondary connection string for the authorization rule RootManageSharedAccessKey |
| <a name="output_default_secondary_key"></a> [default\_secondary\_key](#output\_default\_secondary\_key) | The secondary key for the authorization rule RootManageSharedAccessKey |
<!-- END_TF_DOCS -->
