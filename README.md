# AWS Backup for Aurora (Cross-Region)

This Terraform module automates backups for an Amazon Aurora cluster with cross-region replication.

## Features
- Every 4 hours: Retention 3 days, DR copy 7 days
- Daily at 05:00 UTC: Retention 7 days, DR copy 14 days

## Usage
```bash
terraform init
terraform apply
```

### Inputs
| Variable | Description | Default |
|-----------|-------------|----------|
| region | Primary AWS region | us-east-1 |
| cross_region | Secondary DR region | us-west-2 |
| backup_vault_name | Backup vault name | aurora-backup-vault |
| aurora_cluster_arn | Aurora cluster ARN | N/A |
| tags | Tags for resources | {} |

### Outputs
| Output | Description |
|---------|-------------|
| aurora_primary_vault_arn | ARN of primary vault |
| aurora_cross_region_vault_arn | ARN of DR vault |
| aurora_4hour_plan_id | 4-hour plan ID |
| aurora_daily_plan_id | Daily plan ID |

### License
MIT
