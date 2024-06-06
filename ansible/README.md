# Ansible Playbooks

Create inventory file `inventory.yaml` see example `inventory-example.yaml`


## Install Docker 

    ansible-playbook -i inventory.yaml docker.yaml

## Create user 

Create variable file `vars.yaml` see example `vars-example.yaml` and run the playbook. 

    ansible-playbook -i inventory.yaml sudoer_user.yaml 

 
