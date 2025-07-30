locals {
  shared_template_vars = {
    raw_data        = "${var.ml_homelab_root}/data/raw"
    clean_data      = "${var.ml_homelab_root}/data/clean"
    models          = "${var.ml_homelab_root}/models"
    logs            = "${var.ml_homelab_root}/logs"
    terraform_logs  = "${var.ml_homelab_root}/logs/terraform"
    data_logs       = "${var.ml_homelab_root}/logs/data"
    training_logs   = "${var.ml_homelab_root}/logs/training"
    serving_logs    = "${var.ml_homelab_root}/logs/serving"
    ui_logs         = "${var.ml_homelab_root}/logs/ui"
    pipeline_logs   = "${var.ml_homelab_root}/logs/pipeline"
  }
}
