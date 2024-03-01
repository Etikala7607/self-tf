variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "name" {
  type = string
}

variable "sku" {
  type    = string
  default = "standard"
}

variable "frontend_ip_configuration" {
  type = map(object({
    name                          = string
    subnet_id                     = string
    private_ip_address_allocation = string
    private_ip_address            = string
    zones                         = list(string)
  }))
  description = "list of frontend ip configurations"
  default     = {}
}
variable "backend_pools" {
  type    = set(string)
  default = []
}

variable "lb_inbound_rules" {
  type = map(object({
    name                           = string
    frontend_port                  = number
    backend_port                   = number
    probe_port                     = number
    pool_name                      = string
    frontend_ip_configuration_name = string
  }))
  default = {}
}

variable "lb_outbound_rules" {
  type = map(object({
    name                           = string
    pool_name                      = string
    frontend_ip_configuration_name = string
  }))
  default = {}
}

variable "lb_nat_rules" {
  type = map(object({
    name                           = string
    frontend_port                  = number
    backend_port                   = number
    frontend_ip_configuration_name = string
  }))
  default = {}
}
variable "lb_nat_pools" {
  type = map(object({
    name                           = string
    frontend_port_start            = number
    frontend_port_end              = number
    backend_port                   = number
    frontend_ip_configuration_name = string
  }))
  default = {}
}

# PLS Variables
variable "private_links" {
  type = map(object({
    name                           = string
    frontend_ip_configuration_name = string
  }))
  default = {}
}
variable "pls_subnet_id" {
  type    = string
  default = null
}
