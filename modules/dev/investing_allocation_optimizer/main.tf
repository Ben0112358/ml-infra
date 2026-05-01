################ NETWORK STUFF ####################
resource "null_resource" "network_setup_dev" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOT
      if docker network inspect ${var.docker_network_name} >/dev/null 2>&1; then
        echo "Network exists. Deleting..."
        docker network rm ${var.docker_network_name}
      fi
      docker network create --driver bridge ${var.docker_network_name}
    EOT
  }
}



################## CONFIG #######################
locals {
  enriched_template_vars = merge(
    var.shared_template_vars,
    {
      docker_project_network = var.docker_network_name
    }
  )
}

resource "null_resource" "always_run" {
  triggers = {
    always_run = timestamp()
  }
}

data "template_file" "global_config_investing_allocation_optimizer_dev" {
  template = file(var.config_template_path)
  vars     = local.enriched_template_vars
}

resource "local_file" "global_config_file_investing_allocation_optimizer_dev" {
  content    = data.template_file.global_config_investing_allocation_optimizer_dev.rendered
  filename   = var.config_path
  depends_on = [null_resource.always_run]
}

