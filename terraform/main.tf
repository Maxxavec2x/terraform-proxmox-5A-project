locals {
  pm_api_token_secret = trim(file("${path.module}/token-pve2.txt"), "\n")
  ssh_public_key      = trimspace(file("~/.ssh/id_ed25519.pub"))
}

resource "proxmox_vm_qemu" "proxmox" {
  count       = length(var.vms)
  name        = var.vms[count.index].name
  target_node = var.target_node
  clone       = var.clone
  full_clone  = false
  cpu {
    cores    = 1
    sockets  = 1
  }
  memory   = 2048

  # Network
  network {
    id = 0
    model  = "virtio"
    bridge = element(var.network_bridge, count.index)
  }

  # Disk
disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.storage
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size     = var.size
          storage  = var.storage
          iothread = true
        }
      }
    }
  }
  # Cloud-Init user data (this overwrites the template values)
  os_type    = "cloud-init"
  ciuser      = var.ciuser          # root
  cipassword  = var.cipwd           # azertyuiop
  ipconfig0   = var.vms[count.index].ip
  nameserver  = var.server_dns
  sshkeys     = local.ssh_public_key
  # Make the console work again in the web GUI
  serial {
    id   = 0
    type = "socket"
  }
  vga {
    type = "serial0"                # This is what makes noVNC show the real console
  }

  # Nice to have
  agent = 1                         # qemu-guest-agent enabled
}

# ----------------------------------------------------
# Génération automatique du fichier Ansible inventory
# ----------------------------------------------------
# main.tf → local_file "ansible_inventory"
# main.tf → version ultra-simple et définitive
# VERSION DYNAMIQUE PARFAITE (recommandée)
resource "local_file" "ansible_inventory" {
  content = <<-EOT
    [all:vars]
    ansible_user=root
    ansible_ssh_common_args='-o StrictHostKeyChecking=no'
    ansible_python_interpreter=/usr/bin/python3

    %{ for role in distinct(flatten([for vm in var.vms : vm.roles])) }
    [${role}Group]
    %{ for vm in var.vms }
    %{ if contains(vm.roles, role) }
    ${vm.name} ansible_host=${proxmox_vm_qemu.proxmox[index(var.vms, vm)].default_ipv4_address}
    %{ endif }
    %{ endfor }
    %{ endfor ~}
  EOT

  filename = "${path.module}/../ansible/inventory.ini"
}
