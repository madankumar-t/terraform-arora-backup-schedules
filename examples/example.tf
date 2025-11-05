module "aurora_backup" {
  source = "../.."
  region = "us-east-1"
  cross_region = "us-west-2"
  backup_vault_name = "aurora-prod-backups"
  aurora_cluster_arn = "arn:aws:rds:us-east-1:123456789012:cluster:aurora-prod"
  tags = { Project = "aurora", Environment = "production" }
}
