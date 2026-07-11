variable "vnet_address_space" {
    type = map(list(string))
    default = {
        default = ["10.0.0.0/16"]
        dev = ["10.1.0.0/16"]
        test = ["10.2.0.0/16"]
        prod = ["10.3.0.0/16"]
    }

}

variable "subnet_prefixes" {
    type = map(list(string))
    default = {
        default = ["10.0.1.0/24"]
        dev = ["10.1.1.0/24"]
        test = ["10.2.1.0/24"]
        prod = ["10.3.1.0/24"]
    }
}

variable "resource_group_name" {
    type = string
}

variable "location" {
    type = string
}

variable "vnet_name" {
    type = string
}

variable "subnet_name" {
    type = string
}

variable "pip_name" {
    type = string
}

variable "nic_name" {
    type = string
}

variable "nsg_name" {
    type = string
}
