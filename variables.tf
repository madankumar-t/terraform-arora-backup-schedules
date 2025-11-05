variable "region" {
  description = "Primary AWS region for backup setup"
  type        = string
  default     = "us-east-1"
}

variable "cross_region" {
  description = "Secondary region for cross-region backup copy"
  type        = string
  default     = "us-west-2"
}

variable "backup_vault_name" {
  description = "Name of the AWS Backup Vault"
  type        = string
  default     = "aurora-backup-vault"
}

variable "aurora_cluster_arn" {
  description = "ARN of the Aurora cluster to back up"
  type        = string
}

variable "tags" {
  description = "Tags for backup resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
