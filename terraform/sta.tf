resource "azurerm_storage_account" "sta001" {
  name                     = "stadasdevwesteu001"
  resource_group_name      = azurerm_resource_group.rsg001.name
  location                 = azurerm_resource_group.rsg001.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.snt001.id]
  }
}

resource "azurerm_storage_container" "stc001" {
  name                  = "hdinsight"
  storage_account_name  = azurerm_storage_account.sta001.name
  container_access_type = "private"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "stf001" {
  name               = "raw"
  storage_account_id = azurerm_storage_account.sta001.id
}
