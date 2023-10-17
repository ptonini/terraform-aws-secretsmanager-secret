output "this" {
  value = aws_secretsmanager_secret.this
}

output "policy_arns" {
  value = { for k, v in module.policies : k => v.this.arn }
}

output "kubernetes_secret_provider_class_manifest" {
  value = yamlencode({
    apiVersion = "secrets-store.csi.x-k8s.io/v1"
    kind       = "SecretProviderClass"
    metadata = {
      name = var.name
    }
    spec = {
      provider = "aws"
      parameters = {
        region  = data.aws_region.current.name
        objects = <<-EOF
          - object_name: ${aws_secretsmanager_secret.this.arn}
            object_alias: ${var.name}${var.object_file_extension}
        EOF
      }
    }
  })
}