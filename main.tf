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
mkdir -p ${local.shared_template_vars.raw_data}
chmod 755 ${local.shared_template_vars.raw_data}
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
mkdir -p ${local.shared_template_vars.clean_data}
chmod 755 ${local.shared_template_vars.clean_data}
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
mkdir -p ${local.shared_template_vars.models}
chmod 755 ${local.shared_template_vars.models}
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
mkdir -p ${local.shared_template_vars.terraform_logs}
chmod 755 ${local.shared_template_vars.terraform_logs}
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
mkdir -p ${local.shared_template_vars.data_logs}
chmod 755 ${local.shared_template_vars.data_logs}
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
mkdir -p ${local.shared_template_vars.training_logs}
chmod 755 ${local.shared_template_vars.training_logs}
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
mkdir -p ${local.shared_template_vars.serving_logs}
chmod 755 ${local.shared_template_vars.serving_logs}
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
mkdir -p ${local.shared_template_vars.ui_logs}
chmod 755 ${local.shared_template_vars.ui_logs}
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
mkdir -p ${local.shared_template_vars.pipeline_logs}
chmod 755 ${local.shared_template_vars.pipeline_logs}
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}


###################################################
############## PROJECT & MODE SPECIFIC ############
###################################################
locals {
  config_path          = "${var.ml_homelab_root}/configs/config_${var.project_name}_${var.mode}_${var.timestamp}.yaml"
  config_template_path = "${path.root}/templates/config.yaml.tmpl"
}

###################################################
################## DUMMY PROJECT ###################
###################################################

module "dummy_project_dev" {
  source               = "./modules/dev/dummy_project"
  count                = var.mode == "dev" && var.project_name == "dummy_project" ? 1 : 0
  shared_template_vars = local.shared_template_vars
  config_template_path = local.config_template_path
  config_path          = local.config_path
  docker_network_name  = var.docker_network_name

  depends_on = [null_resource.create_ml_homelab_root]
}

module "dummy_project_prod" {
  source               = "./modules/prod/dummy_project"
  count                = var.mode == "prod" && var.project_name == "dummy_project" ? 1 : 0
  shared_template_vars = local.shared_template_vars
  config_template_path = local.config_template_path
  config_path          = local.config_path
  docker_network_name  = var.docker_network_name

  depends_on = [null_resource.create_ml_homelab_root]
}

###################################################
####### INVESTING ALLOCATION OPTIMIZER ############
###################################################

module "investing_allocation_optimizer_dev" {
  source               = "./modules/dev/investing_allocation_optimizer"
  count                = var.mode == "dev" && var.project_name == "investing_allocation_optimizer" ? 1 : 0
  shared_template_vars = local.shared_template_vars
  config_template_path = local.config_template_path
  config_path          = local.config_path
  docker_network_name  = var.docker_network_name

  depends_on = [null_resource.create_ml_homelab_root]
}

module "investing_allocation_optimizer_prod" {
  source               = "./modules/prod/investing_allocation_optimizer"
  count                = var.mode == "prod" && var.project_name == "investing_allocation_optimizer" ? 1 : 0
  shared_template_vars = local.shared_template_vars
  config_template_path = local.config_template_path
  config_path          = local.config_path
  docker_network_name  = var.docker_network_name

  depends_on = [null_resource.create_ml_homelab_root]
}

###################################################
################ BOARD MEETING PROTOCOL ###########
###################################################

module "board_meeting_protocol_dev" {
  source               = "./modules/dev/board_meeting_protocol"
  count                = var.mode == "dev" && var.project_name == "board_meeting_protocol" ? 1 : 0
  shared_template_vars = local.shared_template_vars
  config_template_path = local.config_template_path
  config_path          = local.config_path
  docker_network_name  = var.docker_network_name

  depends_on = [null_resource.create_ml_homelab_root]
}

module "board_meeting_protocol_prod" {
  source               = "./modules/prod/board_meeting_protocol"
  count                = var.mode == "prod" && var.project_name == "board_meeting_protocol" ? 1 : 0
  shared_template_vars = local.shared_template_vars
  config_template_path = local.config_template_path
  config_path          = local.config_path
  docker_network_name  = var.docker_network_name

  depends_on = [null_resource.create_ml_homelab_root]
}