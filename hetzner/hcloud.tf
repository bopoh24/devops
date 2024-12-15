terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.49"
    }
  }
}

# Define the Hetzner Cloud API token
variable "HCLOUD_TOKEN" {
  sensitive = true
  type = string
}

# Define default ssh key path
variable "SSH_KEY_PATH" {
  type = string
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.HCLOUD_TOKEN
}

# Create a server
resource "hcloud_server" "web" {
  name        = "my-server"
  image       = "ubuntu-24.04"
  server_type = "cx22"
  location   = "nbg1"
  ssh_keys   = [hcloud_ssh_key.default.id]
}

# # Create a volume
# resource "hcloud_volume" "storage" {
#   name       = "my-volume"
#   size       = 50
#   server_id  = hcloud_server.web.id
#   automount  = true
#   format     = "ext4"
# }

# Create a new SSH key
resource "hcloud_ssh_key" "default" {
  name       = "My key"
  public_key = file(var.SSH_KEY_PATH)
}
