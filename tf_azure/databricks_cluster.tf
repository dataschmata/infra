
resource "databricks_cluster" "db_cluster_std" {
  depends_on              = [azurerm_databricks_workspace.dbw100]
  node_type_id            = data.databricks_node_type.dbc_smallest.id
  spark_version           = data.databricks_spark_version.dbc_latest_lts.id
  cluster_name            = "Standard"
  autotermination_minutes = 10
  is_pinned               = true

  autoscale {
    min_workers = 1
    max_workers = 2
  }

  azure_attributes {
    availability       = "SPOT_WITH_FALLBACK_AZURE"
    first_on_demand    = 0
    spot_bid_max_price = -1
  }

  # spark_conf = {
  #   "spark.databricks.cluster.profile": "serverless",
  #   "spark.databricks.acl.dfAclsEnabled": "true",
  #   "spark.databricks.repl.allowedLanguages": "sql,python,r",
  # }
}