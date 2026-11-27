locals {
  configs_dir = "${var.ml_homelab_root}/configs"
  logs_dir    = "${var.ml_homelab_root}/logs"

  shared_template_vars = {
    raw_data       = "${var.ml_homelab_root}/data/raw"
    clean_data     = "${var.ml_homelab_root}/data/clean"
    models         = "${var.ml_homelab_root}/models"
    logs           = local.logs_dir
    terraform_logs = "${local.logs_dir}/infra"
    data_logs      = "${local.logs_dir}/data"
    training_logs  = "${local.logs_dir}/training"
    serving_logs   = "${local.logs_dir}/serving"
    ui_logs        = "${local.logs_dir}/ui"
    pipeline_logs  = "${local.logs_dir}/pipeline"
  }
}
