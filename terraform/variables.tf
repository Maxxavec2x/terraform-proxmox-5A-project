variable "vms" {
  description = "List of VMs to create with their roles"
  type = list(object({
    name           = string
    ip             = string           # e.g. "ip=172.19.30.100/16,gw=172.19.0.1"
    roles          = list(string)      # e.g. ["base"] or ["base", "wikijs", "monitoring"]
  }))
}

variable "pm_api_url"         { type = string }
variable "pm_api_token_id"    { type = string }
variable "clone"              { type = string }
variable "target_node"        { type = string }
variable "network_bridge"     { type = list(string) }
variable "server_dns"         { type = string }
variable "size"               { type = string }
variable "storage"            { type = string }
variable "ciuser"             { type = string }
variable "cipwd"              { type = string }
