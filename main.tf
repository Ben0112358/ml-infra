
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

# Logs - serving / api
resource "null_resource" "create_serving_logs_dir" {
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${var.ml_homelab_root}/logs/serving
chmod 755 ${var.ml_homelab_root}/logs/serving
EOT
  }
  depends_on = [null_resource.create_ml_homelab_root]
}