resource "azurerm_lb" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configuration
    content {
      name                          = frontend_ip_configuration.value.name
      subnet_id                     = frontend_ip_configuration.value.subnet_id
      private_ip_address_allocation = frontend_ip_configuration.value.private_ip_address_allocation
      private_ip_address            = frontend_ip_configuration.value.private_ip_address
      zones                         = frontend_ip_configuration.value.zones
    }
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "this" {
  for_each        = var.backend_pools
  name            = each.value
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_lb_probe" "this" {
  for_each            = var.lb_inbound_rules
  name                = "${each.value.name}-probe"
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.this.id
  port                = each.value.probe_port
  protocol            = "tcp"
}

resource "azurerm_lb_rule" "this" {
  for_each                       = var.lb_inbound_rules
  name                           = each.value.name
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = "tcp"
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  backend_address_pool_id        = azurerm_lb_backend_address_pool.this[each.value.pool_name].id
  probe_id                       = azurerm_lb_probe.this[each.key].id
  load_distribution              = "SourceIPProtocol"
}

resource "azurerm_lb_outbound_rule" "this" {
  for_each                = var.lb_outbound_rules
  resource_group_name     = var.resource_group_name
  loadbalancer_id         = azurerm_lb.this.id
  name                    = each.value.name
  protocol                = "All"
  backend_address_pool_id = azurerm_lb_backend_address_pool.this[each.value.pool_name].id
  frontend_ip_configuration {
    name = each.value.frontend_ip_configuration_name
  }
}

resource "azurerm_lb_nat_rule" "this" {
  for_each                       = var.lb_nat_rules
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.this.id
  name                           = each.value.name
  protocol                       = "Tcp"
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
}

resource "azurerm_lb_nat_pool" "this" {
  for_each                       = var.lb_nat_pools
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.this.id
  name                           = each.value.name
  protocol                       = "Tcp"
  frontend_port_start            = each.value.frontend_port_start
  frontend_port_end              = each.value.frontend_port_end
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
}

# -
# - Private Link Service
# -
locals {
  frontend_ip_configurations_id_map = { for x in azurerm_lb.this.frontend_ip_configuration : x.name => x.id }
}

resource "azurerm_private_link_service" "this" {
  for_each            = var.private_links
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  load_balancer_frontend_ip_configuration_ids = [local.frontend_ip_configurations_id_map[each.value.frontend_ip_configuration_name]]

  nat_ip_configuration {
    name      = "${each.value.name}_primary_pls_nat"
    subnet_id = var.pls_subnet_id
    primary   = true
  }

  tags = var.tags
}
