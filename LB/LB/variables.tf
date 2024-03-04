variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "sku" {
  type    = string

}

variable "frontend_ip_configuration" {
  type = map(object({
    name                          = string
    subnet_id                     = string
    private_ip_address_allocation = string
    private_ip_address            = string

  }))
  description = "list of frontend ip configurations"
  default     = {}
}
