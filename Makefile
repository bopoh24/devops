include hetzner/.env

# HELP =================================================================================================================
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
all, help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nMRTool Makefile help:\n  make \033[36m<target>\033[0m\n"} /^[0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

install-tf:
	@echo "Installing terraform"
	brew tap hashicorp/tap
	brew install hashicorp/tap/terraform
	@echo "Terraform installed"
.PHONY: install-tf

install-ansible:
	@echo "Installing ansible"
	brew install ansible
	@echo "Ansible installed"
.PHONY: install-ansible

deps: install-tf install-ansible ## Install dependencies
.PHONY: install-deps

hz-plan: ## Plan hetzner
	@echo "Planning hetzner"
	cd ./hetzner && terraform init && TF_VAR_HCLOUD_TOKEN=$(HCLOUD_TOKEN) TF_VAR_SSH_KEY_PATH=$(SSH_KEY_PATH) terraform plan
	@echo "Hetzner planned"
.PHONY: hz-plan

hz-apply: ## Apply hetzner
	@echo "Applying hetzner"
	cd ./hetzner && terraform init && TF_VAR_HCLOUD_TOKEN=$(HCLOUD_TOKEN) TF_VAR_SSH_KEY_PATH=$(SSH_KEY_PATH) terraform apply -auto-approve
	@echo "Hetzner applied"
.PHONY: hz-apply

hz-destroy: ## Destroy hetzner
	@echo "Destroying hetzner"
	cd ./hetzner && terraform init && TF_VAR_HCLOUD_TOKEN=$(HCLOUD_TOKEN) TF_VAR_SSH_KEY_PATH=$(SSH_KEY_PATH) terraform destroy -auto-approve
	@echo "Hetzner destroyed"

docker-install: ## Install docker
	@echo "Installing docker"
	cd ./ansible && ansible-playbook -i inventory.yaml docker.yaml
	@echo "Docker installed"


user-create: ## Create user
	@echo "Creating user"
	cd ./ansible && ansible-playbook -i inventory.yaml sudoer_user.yaml
	@echo "User created"
