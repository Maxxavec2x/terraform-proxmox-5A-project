pm_api_url = "https://172.19.3.26:8006/api2/json"

pm_api_token_id = "root@pam!terraform-test"

#pm_api_token_secret = trim(file("secret.txt"))

instance_count = 2

name = ["terraform-created-machine1","terraform-created-machine2"]

clone = "vm-debian-test-terraform"

target_node = "pveauto"

#vmbr0 = LAN / vmbr1 = VM_Network / vmbr2 = DMZ

network_bridge = ["vmbr0","vmbr0"]

ip = ["ip=192.168.100.203/24,gw=192.168.100.254","ip=10.0.0.10/24,gw=10.0.0.254"]

server_dns = "192.168.1.1"

size = "20"

storage = "local-lvm"

ciuser = "root"

cipwd = "azertyuiop"

#ssh_key = "ssh-rsa AAA…
