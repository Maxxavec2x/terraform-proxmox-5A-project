# Déploiement de VM sur Proxmox via Terraform

## Installation 
Installez Terraform.
Pour installer le projet, tirez le projet depuis le github, puis exécutez la commande ```terraform init```.

## Déploiement

Vous avez besoin de la clé d'api proxmox (secrète) pour lancer le déploiement. Demandez-la à Maxence SIBONI ou Thélio DOUCET.
Une fois la clé obtenue, mettez là dans un fichier ```token-pve2.txt``` dans le dossier terraform.
Vous pouvez ensuite exécuter le script ```./deploy_terraform.sh```. Si vous souhaitez apporter des modifications, comme déployer plus de VMs ou chnager les adresses IPs, vous pouvez éditer le fichier ```variables.tfvars```.

## Destruction des ressources

Pour détruire les ressources créées, vous pouvez utiliser le script ```./destroy_terraform.sh```

## Sécurité et gestion des secrets
Comme la clé api Proxmox est une donnée sensible, elle n'est pas présente en dur dans notre code, mais provient d'un fichier situé sur la machine hôte, sous le nom: ```token-pve2.txt```. Aussi, on ajoute notre clé publique aux machines créé afin de pouvoir se connecter en tant que root.
