locals {
  location            = "westeurope"
  resource_group_name = "twink1"

  # Loc_Common            = "${data.terraform_remote_state.Data_Common.outputs.Out_Common}"
  # Loc_Random            = "${local.Loc_Common["Loc_Random"]}"
  # Loc_AdminUser         = "${local.Loc_Common["Loc_AdminUser"]}"
  # Loc_AdminPassword     = "${local.Loc_Common["Loc_AdminPassword"]}"
  # Loc_AdminKey          = "${local.Loc_Common["Loc_AdminKey"]}"
  # Loc_StorAcc_Name      = "${local.Loc_Common["Loc_StorAcc_Name"]}"
}

