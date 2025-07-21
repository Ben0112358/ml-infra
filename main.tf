
###################################################
############### FOLDER CREATION ###################
###################################################

# Root
resource "null_resource" "create_ml_homelab_root" {
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}
chmod 755 ${var.ml_homelab_root}
EOT
  }
}

# Raw data
resource "null_resource" "create_raw_data_dir" {
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
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/models
chmod 755 ${var.ml_homelab_root}/models
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}

# Logs - terraform
resource "null_resource" "create_terraform_logs_dir" {
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
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/logs/pipeline
chmod 755 ${var.ml_homelab_root}/logs/pipeline
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}

###################################################
################ NETWORK STUFF ####################
###################################################
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "dummy_project" {
  name            = "dummy_project"
  driver          = "bridge"
  check_duplicate = true
}

###################################################
############### CONFIG CREATION ###################
###################################################
data "template_file" "global_config" {
  template = file("${path.module}/templates/config.yaml.tmpl")
  vars = {
    raw_data              = "${var.ml_homelab_root}/data/raw"
    clean_data            = "${var.ml_homelab_root}/data/clean"
    models                = "${var.ml_homelab_root}/models"
    logs                  = "${var.ml_homelab_root}/logs"
    terraform_logs        = "${var.ml_homelab_root}/logs/terraform"
    data_logs             = "${var.ml_homelab_root}/logs/data"
    training_logs         = "${var.ml_homelab_root}/logs/training"
    serving_logs          = "${var.ml_homelab_root}/logs/serving"
    ui_logs               = "${var.ml_homelab_root}/logs/ui"
    pipeline_logs         = "${var.ml_homelab_root}/logs/pipeline"
    dummy_project_network = docker_network.dummy_project.name
  }
}

resource "local_file" "global_config_file" {
  content  = data.template_file.global_config.rendered
  filename = "${var.ml_homelab_root}/config.yaml"
}
