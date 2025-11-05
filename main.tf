resource "aws_backup_vault" "aurora_vault" {
  name = var.backup_vault_name
  tags = var.tags
}

provider "aws" {
  alias  = "secondary"
  region = var.cross_region
}

resource "aws_backup_vault" "aurora_cross_region_vault" {
  provider = aws.secondary
  name     = "${var.backup_vault_name}-dr"
  tags     = var.tags
}

resource "aws_iam_role" "backup_role" {
  name = "aws-backup-aurora-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "backup.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "backup_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_backup_plan" "aurora_4hour" {
  name = "aurora-4hour-backup"

  rule {
    rule_name         = "aurora-4hour-rule"
    target_vault_name = aws_backup_vault.aurora_vault.name
    schedule          = "cron(0 */4 * * ? *)"
    lifecycle { delete_after = 3 }
    copy_action {
      destination_vault_arn = aws_backup_vault.aurora_cross_region_vault.arn
      lifecycle { delete_after = 7 }
    }
  }
  tags = var.tags
}

resource "aws_backup_plan" "aurora_daily" {
  name = "aurora-daily-backup"

  rule {
    rule_name         = "aurora-daily-rule"
    target_vault_name = aws_backup_vault.aurora_vault.name
    schedule          = "cron(0 5 * * ? *)"
    lifecycle { delete_after = 7 }
    copy_action {
      destination_vault_arn = aws_backup_vault.aurora_cross_region_vault.arn
      lifecycle { delete_after = 14 }
    }
  }
  tags = var.tags
}

resource "aws_backup_selection" "aurora_selection_4hour" {
  name         = "aurora-4hour-selection"
  iam_role_arn = aws_iam_role.backup_role.arn
  plan_id      = aws_backup_plan.aurora_4hour.id
  resources    = [var.aurora_cluster_arn]
}

resource "aws_backup_selection" "aurora_selection_daily" {
  name         = "aurora-daily-selection"
  iam_role_arn = aws_iam_role.backup_role.arn
  plan_id      = aws_backup_plan.aurora_daily.id
  resources    = [var.aurora_cluster_arn]
}
