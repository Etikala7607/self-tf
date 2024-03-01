output "azurerm_lb" {
  value = azurerm_lb.this
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
output "azurerm_private_link_services" {
  value = var.private_links != null ? azurerm_private_link_service.this : null
}