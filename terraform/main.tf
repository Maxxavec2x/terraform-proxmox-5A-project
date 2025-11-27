locals {
  pm_api_token_secret = trim(file("${path.module}/token-pve2.txt"), "\n")
}

resource "proxmox_vm_qemu" "proxmox" {
  count       = var.instance_count
  name        = element(var.name, count.index)
  target_node = var.target_node
  clone       = var.clone
  full_clone  = true                     # Important: false = linked clone → Cloud-Init broken on most storage types
  
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
  ipconfig0   = element(var.ip, count.index)
  nameserver  = var.server_dns

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
