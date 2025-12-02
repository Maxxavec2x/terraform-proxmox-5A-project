# Déploiement de VM sur Proxmox via Terraform

## Architecture

```
.
├── deploy_terraform.sh   : script de déploiement des VMs
├── destroy_terraform.sh  : script de destruction des VMs installées
├── main.tf               : Fichier principal de terraform, qui lance la création des VMs
├── providers.tf          : Fichier qui comporte la configuration des providers (dans notre cas, Proxmox)
├── token-pve2.txt        : Fichier qui comporte la clé d'API Proxmox (NON PRESENT SUR LE GIT)
├── variables.tf          : Fichier pour déclarer le tye de nos variables
└── variables.tfvars      : Fichier de configuration des VMs (IP, noms, disques, ...)

```

## HOW TO

### Installation 
Installez Terraform.
Lors de votre première exécution, veillez à exécuter la commande ```terraform init```.

### Déploiement

Vous avez besoin de la clé d'api proxmox (secrète) pour lancer le déploiement. Demandez-la à Maxence SIBONI ou Thélio DOUCET.
Une fois la clé obtenue, mettez-la dans un fichier ```token-pve2.txt``` dans le dossier terraform.
Vous pouvez ensuite exécuter le script ```./deploy_terraform.sh```. Si vous souhaitez apporter des modifications, comme déployer plus de VMs ou changer les adresses IPs, vous pouvez éditer le fichier ```variables.tfvars```.

### Destruction des ressources

Pour détruire les ressources créées, vous pouvez utiliser le script ```./destroy_terraform.sh```

### Sécurité et gestion des secrets
Comme la clé api Proxmox est une donnée sensible, elle n'est pas présente en dur dans notre code, mais provient d'un fichier situé sur la machine hôte, sous le nom: ```token-pve2.txt```. Aussi, on ajoute notre clé publique aux machines créées afin de pouvoir se connecter en tant que root. Ces appels sont réalisés via les chemins relatifs dans ```main.tf```, ce qui permet à notre code de ne contenir aucun secret.
