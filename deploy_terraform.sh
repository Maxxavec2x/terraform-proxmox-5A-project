#!/bin/bash

set -e
# Si vous exécutez pour la première fois
#terraform init

terraform plan -var-file variables.tfvars &&
  terraform apply -var-file variables.tfvars
