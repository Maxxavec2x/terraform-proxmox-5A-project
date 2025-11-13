locals {
  pm_api_token_secret = trim(file("${path.module}/secret.txt"), "\n")
}
resource "proxmox_vm_qemu" "proxmox" {

count = var.instance_count

name = element(var.name,count.index)

target_node = var.target_node

clone = var.clone

#cpu

cpu {
  cores = 1
  sockets = 1
}


#memory

memory = "2048"

#network

network {
id = 0

bridge = element(var.network_bridge,count.index)

model = "virtio"

}

ipconfig0 = element(var.ip,count.index)

nameserver = var.server_dns


disks {

virtio {

virtio0 {

disk {

size = var.size

storage = var.storage

iothread = true

}

}

}

}

#cloud init config

os_type = "cloud-init"

ciuser = var.ciuser

cipassword = var.cipwd

#sshkeys = <<EOF

#${var.ssh_key}

#EOF

}
