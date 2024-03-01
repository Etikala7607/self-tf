Example usage:
```

module "load_balancer_private" {
  source                              = "../../Modules/LoadBalancer"
  resource_group_name                 = azurerm_resource_group.main.name
  name                                = "test-private-lb"
  frontend_ip_configuration_subnet_id = azurerm_subnet.subnet1.id
  backend_pools                       = ["pool1", "pool2"]
  lb_inbound_rules = {
    0 = {
      name          = "rule-0"
      frontend_port = 8000
      backend_port  = 8000
      probe_port    = 8000
      pool_name     = "pool1"
    }
    1 = {
      name          = "rule-1"
      frontend_port = 8002
      backend_port  = 8001
      probe_port    = 8001
      pool_name     = "pool1"
    }
    2 = {
      name          = "rule-2"
      frontend_port = 8003
      backend_port  = 8003
      probe_port    = 8003
      pool_name     = "pool2"
    }
  }

  lb_nat_rules = {
    0 = {
      name          = "rule-nat"
      frontend_port = 8004
      backend_port  = 8004
    }
  }
  lb_nat_pools = {
    0 = {
      name                = "rule-0"
      frontend_port_start = 8005
      frontend_port_end   = 8006
      backend_port        = 8000
    }
  }
}

module "load_balancer_public" {
  source              = "../../Modules/LoadBalancer"
  resource_group_name = azurerm_resource_group.main.name
  name                = "test-public-lb"
  enable_public_ip    = true
  backend_pools       = ["pool1"]
  lb_outbound_rules = {
    0 = {
      name      = "rule-0"
      pool_name = "pool1"
    }
  }
}
 ```