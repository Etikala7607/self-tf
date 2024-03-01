resource "azurerm_public_ip" "this" {
  count               = var.enable_public_ip ? 1 : 0
  name                = "${var.name}-publicip"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = var.tags
}

resource "azurerm_lb" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  frontend_ip_configuration {
    name                          = "${var.name}-ipconfiguration"
    subnet_id                     = var.enable_public_ip ? null : var.frontend_ip_configuration_subnet_id
    private_ip_address_allocation = var.enable_public_ip ? null : var.frontend_ip_configuration_private_ip_address_allocation
    public_ip_address_id          = var.enable_public_ip ? azurerm_public_ip.this[0].id : null
  }
  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "this" {
  for_each            = var.backend_pools
  name                = each.value
  loadbalancer_id     = azurerm_lb.this.id
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
  frontend_ip_configuration_name = azurerm_lb.this.frontend_ip_configuration[0].name
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
    name = azurerm_lb.this.frontend_ip_configuration[0].name
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
  frontend_ip_configuration_name = azurerm_lb.this.frontend_ip_configuration[0].name
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
  frontend_ip_configuration_name = azurerm_lb.this.frontend_ip_configuration[0].name
}

# -
# - Private Link Service
# -
resource "azurerm_private_link_service" "this" {
  count               = var.enable_pls ? 1 : 0
  name                = var.pls_name
  location            = var.location
  resource_group_name = var.resource_group_name

  load_balancer_frontend_ip_configuration_ids = [azurerm_lb.this.frontend_ip_configuration[0].id]

  nat_ip_configuration {
    name      = "${var.pls_name}_primary_pls_nat"
    subnet_id = var.pls_subnet_id
    primary   = true
  }

  tags = var.tags
}
