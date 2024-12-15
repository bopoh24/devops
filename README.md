# DevOps example


## Requirements

1) Terraform
2) Hetzner Cloud API Token
3) Ansible

For MacOS you can run `make deps` (brew required) or install manually

## Terraform

Create ```hetzner/.env``` file. See example ```hetzner/.env-example```


## Ansible Playbooks

Create inventory file `ansible/inventory.yaml` see example `ansible/inventory-example.yaml`

Create variable file `ansible/vars.yaml` see example `ansible/vars-example.yaml`


## Run make to see help

```make```
