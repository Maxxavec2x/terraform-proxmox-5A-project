# Déploiement de services et de leur configuration via Ansible

## Architecture

Le fichier ```inventory.ini``` est généré automatiquement à la suite du déploiement Terraform. On utilise des roles afin d'organiser le déploiement de différents services.
```
.
├── ansible.cfg
├── inventory.ini         : Inventaire créé automatiquement par Terraform
├── playbook.yml          : Fichier qui associe à chaque groupe de machine un ou plusieurs rôles
├── roles
│   ├── base
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── vars
│   │       └── main.yml
│   └── wikijs
│       ├── files
│       │   └── systemd_wikijs.conf
│       ├── tasks
│       │   ├── ansible.cfg
│       │   └── main.yml
│       └── vars
│           ├── vars_vault.yml
│           └── vars.yml
└── start_ansible.sh        : Script pour lancer le playbook ansible
```

### Les rôles
Nous sommes passer via l'utilisation de rôles pour diviser le déploiement de nos services. De ce fait, chaque service fait l'objet d'un rôle spécifique, ce qui permet ensute d'associer un ou plusieurs rôles à nos machines dans le playbook. L'architecture d'un rôle se compose de: un dossier `tasks`, qui répertorie les actions à effectuer, et un dossier `vars` qui comporte les variables. D'autres dossiers peuvent être ajouter, comme les `handlers` ou les `files`. Le tout est de conserver quelque chose de clair et surtout scalable. En effet, l'idée derrière cela est de pouvoir intégrer des services assez rapidement, en ajoutant simplement un rôle (ce fût le cas pour wikijs).


## How to

### Insallation
Installez Ansible.
Avant de lancer le script ```./start_ansible.sh```, il est nécessaire d'installer le paquet python suivant sur l'hôte.
```pip install --break-system-packages passlib```
Ce paquet sert à Ansible à créer le hash du password pour la création d'un utilisateur.

## Intégration d'un rôle / Scalabilité
Pour intégrer un rôle, il faut que ce dernier suive l'architecture présentée précedemment. Ensuite, il suffit d'intégrer cela dans le dossier rôle, puis de modifier le playbook pour ajouter ce rôle aux machines souhaitées.


## Sécurité et gestion des secrets
On créé un user 'toto', et on ajoute notre clé publique afin de pouvoir se connecter en tant que 'toto' sur les machines. Aussi, on désactive la possibilité de se connecter en tant que root sur les machines.



