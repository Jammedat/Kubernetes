terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=4.1.0"
        }

    }

}

# dynamic block for nsg
locals {
    security_rules = {
        ssh = { priority = 100, port = "22" }
        http = { priority = 110, port = "80" }
        https = { priority = 120, port = "443" }
    }
}

# create a virtual network
resource "azurerm_virtual_network" "vnet" {
    name = var.vnet_name
    resource_group_name = var.resource_group_name
    location = var.location
    address_space = lookup(var.vnet_address_space, terraform.workspace, var.vnet_address_space["default"])
}

resource "azurerm_subnet" "subnet" {
    name = var.subnet_name
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = lookup(var.subnet_prefixes, terraform.workspace, var.subnet_prefixes["default"])
}

resource "azurerm_public_ip" "pip" {
    name = var.pip_name
    resource_group_name = var.resource_group_name
    location = var.location
    allocation_method = "Static"
    sku = "Standard"
}

resource "azurerm_network_interface" "nic" {
    name = var.nic_name
    resource_group_name = var.resource_group_name
    location = var.location

    ip_configuration {
        name = "internal"
        subnet_id = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.pip.id
    }
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = local.security_rules


    content {
    name                       = "Allow-${security_rule.key}"
    priority                   = security_rule.value.priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = security_rule.value.port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    }
  }
}

# associate nsg with subnet
resource "azurerm_subnet_network_security_group_association" "nsg_ass" {
    subnet_id = azurerm_subnet.subnet.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}

output "nic_id" {
    value = azurerm_network_interface.nic.id
}

output "public_ip_address" {
    value = azurerm_public_ip.pip.ip_address
}