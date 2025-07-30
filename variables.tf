variable "ml_homelab_root" {
  description = "Path to local ML folders. Must be set via environment variable TF_VAR_ml_homelab_root."
  type        = string
  default     = ""
}

variable "mode" {
  description = "Dev|Prod. Must be set via environment variable TF_VAR_mode."
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Project to run infra for. Must be set via environment variable TF_VAR_project_name."
  type        = string
  default     = ""
}

variable "docker_network_name" {
  description = "Name of the project docket network. Must be set via environment variable TF_VAR_docker_network_name."
  type        = string
  default     = ""
}

variable "timestamp" {
  description = "Timestamp of the execution. Must be set via environment variable TF_VAR_docker_timestamp."
  type        = string
  default     = ""
}
