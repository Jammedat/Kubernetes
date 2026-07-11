terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=4.1.0"
        }

    }

}

provider "azurerm" {
    features {}
    subscription_id = "b0244480-0b0d-44e1-90b7-e32d65bfb667"
}


# global tag
locals {
    env = terraform.workspace
    base_tags = {
        environment = local.env
        managedby = "Terraform"
        project = "tf-lab"
        owner = "devops-team"

    }
}

# create a resource group
resource "azurerm_resource_group" "rg" {
    name = "${terraform.workspace}-rg"
    location = "koreacentral"
    tags = local.base_tags
}

module "network" {
    source = "./modules/network"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    vnet_name = "${terraform.workspace}-vnet"
    subnet_name = "${terraform.workspace}-subnet"
    pip_name = "${terraform.workspace}-pip"
    nic_name = "${terraform.workspace}-nic"
    nsg_name = "${terraform.workspace}-nsg"
}



resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${terraform.workspace}-example-machine"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B2s_v2"
  admin_username      = "adminuser"
  tags = local.base_tags
  network_interface_ids = [ module.network.nic_id, ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  custom_data = base64encode(file("script.sh"))

  
}

output "public_ip_address" {
    value = module.network.public_ip_address
}
