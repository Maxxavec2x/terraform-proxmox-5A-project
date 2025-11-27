#!/bin/bash
set -xe

# Script pour créer des templates de vm pour terraform

# 1. Choose a free VM ID (I use 9000)
VMID=9000

# 2. Download the latest daily Debian 13 cloud image
cd /var/lib/vz/template/iso
wget -N https://cloud.debian.org/images/cloud/trixie/daily/latest/debian-13-generic-amd64-daily.qcow2

# 3. Create the empty VM (no disk yet)
qm create $VMID --name debian-13-cloud-template --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0 --ostype l26

# 4. Import the qcow2 and convert it directly to your storage (this creates the real disk file)
qm importdisk $VMID debian-13-generic-amd64-daily.qcow2 local-lvm --format raw
# → you will see something like:
#   Successfully imported disk as 'local-lvm:vm-9000-disk-0'

# 5. Now the disk really exists → attach it properly
qm set $VMID --scsihw virtio-scsi-single --scsi0 local-lvm:vm-$VMID-disk-0,size=8G

# 6. NOW run virt-customize on the real file that Proxmox just created
#     (find the exact path with "pvesm path local-lvm:vm-$VMID-disk-0")
DISK_PATH=$(pvesm path local-lvm:vm-$VMID-disk-0)
echo "Disk path = $DISK_PATH"

virt-customize -a "$DISK_PATH" \
  --install qemu-guest-agent \
  --root-password password:azerty

# 7. Finish the cloud-init configuration (this is what removes the "No CloudInit Drive found" message)
qm set $VMID --boot order=scsi0
qm set $VMID --serial0 socket --vga serial0
qm set $VMID --agent enabled=1
qm set $VMID --ide2 local-lvm:cloudinit
qm set $VMID --ciuser root
qm set $VMID --cipassword azerty
qm set $VMID --ipconfig0 ip=dhcp

# 8. Convert to template
qm template $VMID

echo "Debian 13 template $VMID is ready! root password = azerty"
