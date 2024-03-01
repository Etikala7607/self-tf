variable "resource_group_name" {
  type        = string
}
variable "location" {
  type        = string
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

variable "enable_public_ip" {
  type    = bool
  default = false
}
variable "frontend_ip_configuration_subnet_id" {
  type    = string
  default = null
}
variable "frontend_ip_configuration_private_ip_address_allocation" {
  type    = string
  default = "dynamic"
}
variable "backend_pools" {
  type    = set(string)
  default = []
}

variable "lb_inbound_rules" {
  type = map(object({
    name          = string
    frontend_port = number
    backend_port  = number
    probe_port    = number
    pool_name     = string
  }))
  default = {}
}

variable "lb_outbound_rules" {
  type = map(object({
    name      = string
    pool_name = string
  }))
  default = {}
}

variable "lb_nat_rules" {
  type = map(object({
    name          = string
    frontend_port = number
    backend_port  = number
  }))
  default = {}
}
variable "lb_nat_pools" {
  type = map(object({
    name                = string
    frontend_port_start = number
    frontend_port_end   = number
    backend_port        = number
  }))
  default = {}
}

# PLS Variables
variable "enable_pls" {
  type    = bool
  default = false
}
variable "pls_name" {
  type    = string
  default = null
}
variable "pls_subnet_id" {
  type    = string
  default = null
}