resource "azurerm_public_ip" "vm1" {
  name                = "vm1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "vm1_nic1" {
  name                = "vm1_nic1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "vm1_lip1"
    subnet_id                     = azurerm_subnet.servers.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.81.10.11"
    public_ip_address_id          = azurerm_public_ip.vm1.id
  }
}

resource "azurerm_virtual_machine" "vm1" {
  name                  = "vm1"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.vm1_nic1.id]
  vm_size               = "Basic_A0"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.7"
    version   = "latest"
  }
  storage_os_disk {
    name              = "vm1_os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "twink1-vm1"
    admin_username = "twinkadmin"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/twinkadmin/.ssh/authorized_keys"
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAsQet7FpUFuBylm+JrVxhYkQJlUyeuvxHVLEa3cn37CarrhGmhthr5lSE/2QZnICQ1v+9K1pkznHPJoWhQbFBU4CQ1WzBvcSWjzoPeSgMZm+NT6G+TxK+KuINfVKP5PwxkWYRBBkjTDn404HZYeg4eKo0/j1xQ4JwZIVoqyER/qY/Ipj22ANvnXBVP+vFXXwurb9TnsLnzfc+/eckl7+axtdNTl04npOvo5cZ2RN+g9rth8AZY3pPYq5sjjHyBYssnzyNgri4keXC8Req8XyabfaO6hZ9qrbUjXjCc6OG6AAYk8LxCwI99QAHtWUfd8XblF08vjj+2hMDlxSMKiPEVw== "
    }
  }
}

