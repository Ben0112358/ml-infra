###################################################
################# SHARED STUFF ####################
###################################################


############### FOLDER CREATION ###################

# Root
resource "null_resource" "create_ml_homelab_root" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}
chmod 755 ${var.ml_homelab_root}
EOT
  }
}

# Raw data
resource "null_resource" "create_raw_data_dir" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/data/raw
chmod 755 ${var.ml_homelab_root}/data/raw
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}

# Clean data
resource "null_resource" "create_clean_data_dir" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/data/clean
chmod 755 ${var.ml_homelab_root}/data/clean
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}

# Models
resource "null_resource" "create_models_dir" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/models
chmod 755 ${var.ml_homelab_root}/models
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}

# Configs
resource "null_resource" "create_configs_dir" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/configs
chmod 755 ${var.ml_homelab_root}/configs
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}

# Logs - terraform
resource "null_resource" "create_terraform_logs_dir" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/logs/terraform
chmod 755 ${var.ml_homelab_root}/logs/terraform
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}

# Logs - data
resource "null_resource" "create_data_logs_dir" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/logs/data
chmod 755 ${var.ml_homelab_root}/logs/data
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}

# Logs - training
resource "null_resource" "create_training_logs_dir" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/logs/training
chmod 755 ${var.ml_homelab_root}/logs/training
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}

# Logs - serving
resource "null_resource" "create_serving_logs_dir" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/logs/serving
chmod 755 ${var.ml_homelab_root}/logs/serving
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}

# Logs - ui
resource "null_resource" "create_ui_logs_dir" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/logs/ui
chmod 755 ${var.ml_homelab_root}/logs/ui
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}

# Logs - pipeline
resource "null_resource" "create_pipeline_logs_dir" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/logs/pipeline
chmod 755 ${var.ml_homelab_root}/logs/pipeline
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}


###################################################
############## PROJECT & MODE SPECIFIC ############
###################################################
locals {
  config_path = "${var.ml_homelab_root}/configs/config_${var.project_name}_${var.mode}_${var.timestamp}.yaml"
}

module "dummy_project_dev" {
  source               = "./modules/dev/dummy_project"
  count                = var.mode == "dev" && var.project_name == "dummy_project" ? 1 : 0
  shared_template_vars = local.shared_template_vars
  ml_homelab_root      = var.ml_homelab_root
  mode                 = var.mode
  project_name         = var.project_name
  config_template_path = "${path.root}/templates/config.yaml.tmpl"
  config_path          = local.config_path
  docker_network_name  = var.docker_network_name
  timestamp            = var.timestamp

  depends_on = [null_resource.create_ml_homelab_root]
}

module "dummy_project_prod" {
  source               = "./modules/prod/dummy_project"
  count                = var.mode == "prod" && var.project_name == "dummy_project" ? 1 : 0
  shared_template_vars = local.shared_template_vars
  ml_homelab_root      = var.ml_homelab_root
  mode                 = var.mode
  project_name         = var.project_name
  config_template_path = "${path.root}/templates/config.yaml.tmpl"
  config_path          = local.config_path
  docker_network_name  = var.docker_network_name
  timestamp            = var.timestamp

  depends_on = [null_resource.create_ml_homelab_root]
}
