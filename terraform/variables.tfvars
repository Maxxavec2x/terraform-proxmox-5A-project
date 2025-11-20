pm_api_url = "https://172.19.3.19:8006/api2/json"

pm_api_token_id = "root@pam!terraform"

instance_count = 2

name = ["terraform-created-machine1","terraform-created-machine2"]

clone = "debian-13-desktop"

target_node = "pve2"

#vmbr0 = LAN / vmbr1 = VM_Network / vmbr2 = DMZ

network_bridge = ["vmbr0","vmbr0"]

ip = ["ip=172.19.30.100/16,gw=172.19.0.1","ip=172.19.30.101/16,gw=172.19.0.1"]

server_dns = "192.168.1.1"

size = "32"

storage = "local-lvm"

ciuser = "root"

cipwd = "azertyuiop"

#ssh_key = "ssh-rsa AAA…
