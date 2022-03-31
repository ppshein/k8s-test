resource "aws_secretsmanager_secret" "cred_secret" {
  name                    = "${var.business_unit}/${var.project}-${var.environment}-secret"
  recovery_window_in_days = 0
  tags                    = local.common_tags
}

resource "aws_secretsmanager_secret_version" "cred_secret_value" {
  secret_id = aws_secretsmanager_secret.cred_secret.id
  secret_string = jsonencode(
    {
      "DbUser"     = var.database.user
      "DbPassword" = var.database.password
      "DbName"     = var.database.name
      "DbPort"     = var.database.port
      "DbHost"     = var.database.host
      "ListenHost" = var.application.host
      "ListenPort" = var.application.port
    }
  )
}
