
resource "azurerm_network_security_group" "firewall" {
  name                = "firewall"
  location            = azurerm_resource_group.mainrg.location
  resource_group_name = azurerm_resource_group.mainrg.name

  security_rule {
    name                       = "ICMP_ANY"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "ICMP"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = ""
  }
  security_rule {
    name                       = "SSH_ANY"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["2233","2222","22"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "RDP_TRUST"
    priority                   = 301
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefixes    = ["178.160.250.112/28", "37.252.68.159"]
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "basenet" {
  name                = "basenet"
  location            = azurerm_resource_group.mainrg.location
  resource_group_name = azurerm_resource_group.mainrg.name
  address_space       = ["10.81.0.0/16"]
}

resource "azurerm_subnet" "servernet" {
  name                      = "servernet"
  resource_group_name       = azurerm_resource_group.mainrg.name
  virtual_network_name      = azurerm_virtual_network.basenet.name
  address_prefix            = "10.81.10.0/24"
}

 resource "azurerm_subnet_network_security_group_association" "servernet_firewall" {
   subnet_id                 = azurerm_subnet.servernet.id
   network_security_group_id = azurerm_network_security_group.firewall.id
}





