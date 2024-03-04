resource_group_name = "example"
location = "West Europe"
    name = "lb-01"
    sku  = "Standard"
    frontend_ip_configuration = {
      frontend_ip_configuration1 = {
        name                      = "feip-01"
        subnet_id             = "/subscriptions/7f2b7f9a-240e-4173-884e-ba25fa5fa24d/resourceGroups/example/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
        private_ip_address_allocation                = "Dynamic"
        private_ip_address = "10.0.1.128"

      }
      frontend_ip_configuration2 = {
        name                      = "feip-02"
        subnet_id             = "/subscriptions/7f2b7f9a-240e-4173-884e-ba25fa5fa24d/resourceGroups/example/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
        private_ip_address_allocation                = "Dynamic"
        private_ip_address = "10.0.1.192"

      }
      
    }
