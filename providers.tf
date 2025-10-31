terraform {

required_providers {

proxmox = {

source = "Telmate/proxmox"

version = "3.0.2-rc03"

}

}

}

provider "proxmox" {

pm_api_url = var.pm_api_url

pm_api_token_id = var.pm_api_token_id

pm_api_token_secret = local.pm_api_token_secret

pm_tls_insecure = true
pm_parallel = 1
pm_log_enable = false
pm_timeout = 600
pm_minimum_permission_check = false
# pm_log_enable = true

# pm_log_file = "terraform-plugin-prox-vm.log"

# pm_log_levels = {

# _default = "debug"

# _capturelog = ""

# }

}
