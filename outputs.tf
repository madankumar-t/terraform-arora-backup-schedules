output "aurora_primary_vault_arn" {
  value       = aws_backup_vault.aurora_vault.arn
  description = "ARN of the primary backup vault"
}

output "aurora_cross_region_vault_arn" {
  value       = aws_backup_vault.aurora_cross_region_vault.arn
  description = "ARN of the cross-region backup vault"
}

output "aurora_4hour_plan_id" {
  value       = aws_backup_plan.aurora_4hour.id
  description = "ID of the Aurora 4-hour backup plan"
}

output "aurora_daily_plan_id" {
  value       = aws_backup_plan.aurora_daily.id
  description = "ID of the Aurora daily backup plan"
}
