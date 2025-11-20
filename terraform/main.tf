locals {
  pm_api_token_secret = trim(file("${path.module}/token-pve2.txt"), "\n")
}
resource "proxmox_vm_qemu" "proxmox" {

count = var.instance_count

name = element(var.name,count.index)

target_node = var.target_node

clone = var.clone
full_clone = false
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

scsi {

scsi0 {

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
# ----------------------------------------------------
# Génération automatique du fichier Ansible inventory
# ----------------------------------------------------
resource "local_file" "ansible_inventory" {
  depends_on = [proxmox_vm_qemu.proxmox]

  content = <<EOT
[all]
%{ for index, vm in proxmox_vm_qemu.proxmox ~}
${vm.name} ansible_host=${vm.ipconfig0} ansible_user=${var.ciuser} ansible_password=${var.cipwd}
%{ endfor ~}
EOT

  filename = "${path.module}/../ansible/inventory.ini"
}

