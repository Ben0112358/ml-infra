output "ml_homelab_root" {
  description = "The base path for local ML folders."
  value       = var.ml_homelab_root
}

output "mode" {
  description = "dev|prod."
  value       = var.mode
}

output "project_name" {
  description = "Name of the project to construct infra for."
  value       = var.project_name
}

output "docker_network_name" {
  description = "Name of the project docker network"
  value       = var.docker_network_name
}

output "timestamp" {
  description = "Timestamp of project execution"
  value       = var.timestamp
}


output "CONFIG_PATH" {
  description = "Path of config file"
  value       = local.config_path
}