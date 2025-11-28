# Déploiement de services et de leur configuration via Ansible

## Architecture

Le fichier ```inventory.ini``` est généré automatiquement à la suite du déploiement Terraform. On utilise des roles afin d'organiser le déploiement de différents services.
```
.
├── ansible.cfg
├── inventory.ini
├── playbook.yml
├── README.md
├── roles
│   └── base
│       ├── handlers
│       │   └── main.yml
│       ├── tasks
│       │   └── main.yml
│       └── vars
│           └── main.yml
└── start_ansible.sh
```



### Wikijs

[TO-DO]

### Monitoring

[TO-DO]

## How to

Avant de lancer le script ```./start_ansible.sh```, il est nécessaire d'installer le paquet python suivant sur l'hôte.
# To install on host : 
```pip install --break-system-packages passlib```
Ce paquet sert à Ansible à créer le hash du password pour la création d'un utilisateur.

