Example usage:
```
module "load_balancer_db" {
  source                              = "../../../cloud-migration-base/Modules/LoadBalancerMultipleFrontends"
  resource_group_name                 = data.azurerm_resource_group.main.name
  location                            = data.azurerm_resource_group.main.location
  name                                = "${local.rg_name_prefix}-db-lb"
  frontend_ip_configuration = {
    1 = {
      name                          = "db-ip-configuration"
      subnet_id                     = data.azurerm_subnet.subnet_db.id
      private_ip_address_allocation = "dynamic"
      private_ip_address            = null
      zones                         = null
    }
    2 = {
      name                          = "fileshare-ip-configuration"
      subnet_id                     = data.azurerm_subnet.subnet_db.id
      private_ip_address_allocation = "dynamic"
      private_ip_address            = null
      zones                         = null
    }
  }
  backend_pools                       = ["pool1"]
  lb_inbound_rules = {
    port8080 = {
      name          = "rule-port8080"
      frontend_port = 80
      backend_port  = 8080
      probe_port    = 8080
      pool_name     = "pool1"
      frontend_ip_configuration_name = "db-ip-configuration"
    },
    port8443 = {
      name          = "rule-port8443"
      frontend_port = 443
      backend_port  = 8443
      probe_port    = 8443
      pool_name     = "pool1"
      frontend_ip_configuration_name = "db-ip-configuration"
    },
    port3389 = {
      name = "ccrw-eastus2-poc-db-lb-lbr-01"
      frontend_port = "8000"
      backend_port = "3389"
      probe_port = "3389"
      pool_name = "pool1"
      frontend_ip_configuration_name = "db-ip-configuration"
    },
    port1433 = {
      name = "ccrw-eastus2-poc-db-lb-lbr-02"
      frontend_port = "1433"
      backend_port = "1433"
      probe_port = "1433"
      pool_name = "pool1"
      frontend_ip_configuration_name = "db-ip-configuration"
    }
  }
  private_links    = {
    1 = {
      name = "${local.pls_name_prefix}-db-pls"
      frontend_ip_configuration_name = "db-ip-configuration"
    }
    2 = {
      name = "${local.pls_name_prefix}-fileshare-pls"
      frontend_ip_configuration_name = "fileshare-ip-configuration"
    }
  }
  pls_subnet_id = data.azurerm_subnet.subnet_pls.id
  tags          = local.tags
}
 ```