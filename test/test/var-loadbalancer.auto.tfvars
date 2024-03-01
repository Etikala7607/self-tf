resource_group_name = "name"

load_balancers = {
  loadbalancer1 = {
    name = "lb-01"
    sku  = "Standard"
    frontend_ips = [
      {
        name                      = "feip-01"
        subnet_name               = "snet-01"
        vnet_name                 = "vnet-01" #"jstartvmssfirst"
        networking_resource_group = "lb-westus2-nprd-app-rg-01"
        static_ip                 = null # "10.0.1.4" #(Optional) Set null to get dynamic IP 
        zones                     = null
      }
      
    ]
    backend_pool_names = ["lbvm-lbbep","lbvmss-lbbep"]
    enable_public_ip   = false # set this to true to if you want to create public load balancer
    public_ip_name     = null
  }
}

load_balancer_rules = {
  loadbalancerrules1 = {
    name                      = "ssh-lbr"
    lb_key                    = "loadbalancer1"
    frontend_ip_name          = "feip-01"
    backend_pool_name         = "lbvm-lbbep"
    lb_protocol               = null
    lb_port                   = "22"
    probe_port                = "22"
    backend_port              = "22"
    enable_floating_ip        = null
    disable_outbound_snat     = null
    enable_tcp_reset          = null
    probe_protocol            = "Tcp"
    request_path              = "/"
    probe_interval            = 5
    probe_unhealthy_threshold = 2
    load_distribution         = "SourceIPProtocol"
    idle_timeout_in_minutes   = 5
  },
  loadbalancerrules2 = {
    name                      = "https-lbr"
    lb_key                    = "loadbalancer1"
    frontend_ip_name          = "feip-01"
    backend_pool_name         = "lbvm-lbbep"
    lb_protocol               = null
    lb_port                   = "443"
    probe_port                = "443"
    backend_port              = "443"
    enable_floating_ip        = null
    disable_outbound_snat     = null
    enable_tcp_reset          = null
    probe_protocol            = "Tcp"
    request_path              = "/"
    probe_interval            = 5
    probe_unhealthy_threshold = 2
    load_distribution         = "SourceIPProtocol"
    idle_timeout_in_minutes   = 5
  },
  loadbalancerrules3 = {
    name                      = "lbr"
    lb_key                    = "loadbalancer1"
    frontend_ip_name          = "feip-01"
    backend_pool_name         = "lbvm-lbbep"
    lb_protocol               = null
    lb_port                   = "9993"
    probe_port                = "9993"
    backend_port              = "9993"
    enable_floating_ip        = null
    disable_outbound_snat     = null
    enable_tcp_reset          = null
    probe_protocol            = "Tcp"
    request_path              = "/"
    probe_interval            = 5
    probe_unhealthy_threshold = 2
    load_distribution         = "SourceIPProtocol"
    idle_timeout_in_minutes   = 5
  }
  /*,
  loadbalancerrules3 = {
    name                      = "ssh-lbr-02"
    lb_key                    = "loadbalancer1"
    frontend_ip_name          = "feip-01"
    backend_pool_name         = "lbvmss-lbbep-01"
    lb_protocol               = null
    lb_port                   = "22"
    probe_port                = "22"
    backend_port              = "22"
    enable_floating_ip        = null
    disable_outbound_snat     = null
    enable_tcp_reset          = null
    probe_protocol            = "Tcp"
    request_path              = "/"
    probe_interval            = 5
    probe_unhealthy_threshold = 2
    load_distribution         = "SourceIPProtocol"
    idle_timeout_in_minutes   = 5
  }*/

}

load_balancer_nat_pools = {}

lb_outbound_rules = {
}

load_balancer_nat_rules = {
  /*loadbalancernatrules1 = {
    name                    = "jstartvmlbnatrule"
    lb_keys                 = ["loadbalancer1"]
    frontend_ip_name        = "jstartvmlbfrontend"
    lb_port                 = 80
    backend_port            = 22
    idle_timeout_in_minutes = 5
  }*/
}

lb_additional_tags = {
  iac          = "Terraform"
  env          = "nprd"
  automated_by = "devops-sp"
}