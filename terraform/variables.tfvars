# terraform.tfvars
pm_api_url       = "https://172.19.3.19:8006/api2/json"
pm_api_token_id  = "root@pam!terraform"
clone            = "debian-13-cloud-template"
target_node      = "pve2"
network_bridge   = ["vmbr0"]
server_dns       = "8.8.8.8"
size             = "20G"
storage          = "local-lvm"
ciuser           = "root"
cipwd            = "azertyuiop"

vms = [
  {
    name  = "server-base"
    ip    = "ip=172.19.30.110/16,gw=172.19.0.1"
    roles = ["base"]
  },
  {
    name  = "server-wikijs"
    ip    = "ip=172.19.30.111/16,gw=172.19.0.1"
    roles = ["base", "wikijs"]
  },
 # {
 #   name  = "server-monitoring"
 #   ip    = "ip=172.19.30.112/16,gw=172.19.0.1"
 #   roles = ["base", "monitoring", "grafana"]
 # }
]
