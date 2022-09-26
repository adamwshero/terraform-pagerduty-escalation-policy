# Complete Terraform Example

```
locals {
  external_deps = read_terragrunt_config(find_in_parent_folders("external-deps.hcl"))
  account_vars  = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  product_vars  = read_terragrunt_config(find_in_parent_folders("product.hcl"))
  env_vars      = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  product       = local.product_vars.locals.product_name
  prefix        = local.product_vars.locals.prefix
  account       = local.account_vars.locals.account_id
  env           = local.env_vars.locals.env
  pagerduty_key = yamldecode(sops_decrypt_file("${get_terragrunt_dir()}/sops/api-key.sops.yaml"))
  tags = merge(
    local.env_vars.locals.tags,
    local.additional_tags
  )

  # Customize if needed
  additional_tags = {

  }
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:adamwshero/terraform-pagerduty-escalation-policy.git//.?ref=1.0.1"
}

inputs = {
  token                    = local.pagerduty_key.key
  create_escalation_policy = true

  escalation_policies = [
    {
      name        = "TEST Engineering Escalation 1"
      description = "My TEST engineering escalation policy 1"
      teams       = ["AA1A6AA"]
      num_loops   = 2
      rules = [
        {
          escalation_delay_in_minutes = 15
          target = {
            type = "user_reference"
            id   = "BBBB1B1"
          }
        },
        {
          escalation_delay_in_minutes = 15
          target = {
            type = "user_reference"
            id   = "AAAA1A1"
          }
        }
      ]
    },
    {
      name        = "TEST Engineering Escalation 2"
      description = "My TEST engineering escalation policy 2"
      teams       = ["BB1B6BB"]
      num_loops   = 2
      rules = [
        {
          escalation_delay_in_minutes = 15
          target = {
            type = "user_reference"
            id   = "AAAA1A1"
          }
        },
        {
          escalation_delay_in_minutes = 15
          target = {
            type = "user_reference"
            id   = "BBBB1B1"
          }
        },
        {
          escalation_delay_in_minutes = 15
          target = {
            type = "user_reference"
            id   = "CCCC1C1"
          }
        }
      ]
    }
  ]
}
```