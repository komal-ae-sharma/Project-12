output "infra_ci_details" {
  description = "Values tracked by the Terraform plan"
  value       = terraform_data.infra_ci.input
}
