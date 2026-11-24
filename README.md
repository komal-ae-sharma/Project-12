# Project 12: Infrastructure CI Trigger (Terraform Plan)

## Goal

Validate the Terraform plan automatically on every push.

## What the pipeline does

The GitHub Actions workflow [`.github/workflows/terraform-plan.yml`](.github/workflows/terraform-plan.yml) runs on:

- Pushes to `main` and `feature/**` branches
- Pull requests targeting `main`

Pipeline steps:

| Step | Command | Purpose |
|------|---------|---------|
| Checkout | `actions/checkout@v4` | Get the repository code |
| Setup Terraform | `hashicorp/setup-terraform@v3` | Install the Terraform CLI |
| Init | `terraform init -input=false` | Initialize the working directory |
| Format check | `terraform fmt -check -recursive` | Enforce standard formatting |
| Validate | `terraform validate` | Check the configuration syntax |
| Plan | `terraform plan -input=false -out=tfplan` | Generate the execution plan |
| Upload artifact | `actions/upload-artifact@v4` | Save `tfplan` as the `terraform-plan` artifact |

## Repository structure

```text
.
├── .github/
│   └── workflows/
│       └── terraform-plan.yml   # CI pipeline
├── main.tf                      # Terraform resources
├── variables.tf                 # Input variables
├── outputs.tf                   # Outputs
├── .gitignore
└── README.md
```

The Terraform configuration uses the built-in `terraform_data` resource, so the plan runs without cloud credentials.

## Run locally

```powershell
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan -out=tfplan
```

## Trigger the pipeline

```powershell
git checkout -b feature/<name>
git add .
git commit -m "Your change"
git push -u origin feature/<name>
```

Then open the **Actions** tab on GitHub to see the run.

## Deliverables

- Successful **Terraform Plan Validation** job screenshot
- Uploaded `terraform-plan` artifact screenshot
