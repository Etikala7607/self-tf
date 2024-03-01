output "azurerm_lb" {
  value = azurerm_lb.this
}
output "azurerm_public_ip" {
  value = var.enable_public_ip ? azurerm_public_ip.this[0] : null
}
output "azurerm_lb_backend_address_pools" {
  value = var.backend_pools != null ? azurerm_lb_backend_address_pool.this : null
}
output "azurerm_lb_probes" {
  value = var.lb_inbound_rules != null ? azurerm_lb_probe.this : null
}
output "azurerm_lb_rules" {
  value = var.lb_inbound_rules != null ? azurerm_lb_rule.this : null
}
output "azurerm_lb_outbound_rules" {
  value = var.lb_outbound_rules != null ? azurerm_lb_outbound_rule.this : null
}
output "azurerm_lb_nat_rules" {
  value = var.lb_nat_rules != null ? azurerm_lb_nat_rule.this : null
}
output "azurerm_lb_nat_pools" {
  value = var.lb_nat_pools != null ? azurerm_lb_nat_pool.this : null
}
output "azurerm_private_link_service" {
  value = var.enable_pls ? azurerm_private_link_service.this[0] : null
}