
locals {
  loc_rgrp_name     = "Twink1"
  loc_rgrp_location = "westeurope"
}

resource "azurerm_resource_group" "rgrp" {
  name     = local.loc_rgrp_name
  location = local.loc_rgrp_location
}

