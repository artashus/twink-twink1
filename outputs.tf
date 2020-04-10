output "vm1_public_ip" {
  value = azurerm_public_ip.vm1.ip_address
}

# output "common_info" {
#   value                 = "${local.Loc_Common}"
# }
