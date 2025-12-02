# Présentation globale du projet

Le but de ce projet est d'automatiser le déploiement de VMs et l'installation de services sur Proxmox. Pour cela, on utilise Terraform pour le déploiement de VMs, et Ansible pour configurer les machines une fois celles-ci déployées afin de configurer les services.

## Architecture du projet

L'objectif est de créer un projet scalable. C'est pourquoi notre architecture comprend plusieurs fichiers de configurations. A la racine du projet on retrouve deux dossiers, `terraform` et `ansible`, qui contiennent les fichiers relatifs à chaque outil.
```
.
├── ansible
│   ├── ansible.cfg
│   ├── inventory.ini
│   ├── playbook.yml
│   ├── README.md
│   ├── roles
│   │   └── base
│   │       ├── handlers
│   │       │   └── main.yml
│   │       ├── tasks
│   │       │   └── main.yml
│   │       └── vars
│   │           └── main.yml
│   └── start_ansible.sh
├── create_disk_template.sh
├── README.md
└── terraform
    ├── deploy_terraform.sh
    ├── destroy_terraform.sh
    ├── main.tf
    ├── providers.tf
    ├── README.md
    ├── variables.tf
    └── variables.tfvars
```

## Prérequis

Les préréquis liés aux différents outils sont présents dans le `README.md` de chaque dossier correspondant. Avant de vous lancer dans le déploiement de VMs, il est nécessaire de disposer d'un template sur votre instance Proxmox. Vous pouvez créer un template de VM cloud-init avec le script `create_disk_tempate.sh`, à créer sur votre instance Proxmox.

## HOW TO

Pour commencer il vous suffit de tirer le projet depuis Github. Ensuite, on lancera terraform, puis ansible. De ce fait, veuillez consulter la documentation présente dans les dossiers respectifs pour comprendre le fonctionnement de chaque partie.
