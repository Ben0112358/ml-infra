variable "ml_homelab_root" {
  description = "Path to local ML folders. Must be set via environment variable TF_VAR_ml_homelab_root."
  type        = string
  default     = ""
  validation {
    condition     = length(var.ml_homelab_root) > 0
    error_message = <<EOT
Required environment variable TF_VAR_ml_homelab_root is not set.
Terraform variables from environment must be prefixed with 'TF_VAR_'.

Please set it before running Terraform, for example:

  export TF_VAR_ml_homelab_root=/home/yourusername/projects/ml-homelab

Replace '/home/yourusername/projects/ml-homelab' with your actual path.
EOT
  }
}
