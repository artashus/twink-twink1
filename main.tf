
locals {
  loc_rgrp_name     = "Twink1"
  loc_rgrp_location = "westeurope"
}

terraform {
  required_version = "=0.12.24"
}

provider "azurerm" {
  version         = "~> 2.5"
  features {}
}


resource "azurerm_resource_group" "rgrp" {
  name     = local.loc_rgrp_name
  location = local.loc_rgrp_location
}

