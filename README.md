[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

![Terraform](https://cloudarmy.io/tldr/images/tf_aws.jpg)
<br>
<br>
<br>
<br>
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/adamwshero/terraform-pagerduty-escalation-policy?color=lightgreen&label=latest%20tag%3A&style=for-the-badge)
<br>
<br>
# terraform-pagerduty-escalation-policy

[Pagerduty Escalation Policies](https://support.pagerduty.com/docs/escalation-policies) are used to automate incident assignment and they connect services to individual users and/or schedules. They are designed to notify a single target at a time until one individual acknowledges the incident. By adding rules to your escalation policy, you can ensure that each incident has a thorough response plan in the event that initial responders cannot acknowledge. Services in PagerDuty can only be associated with one escalation policy. An escalation policy, however, can be associated with as many services as you like.
<br>
<br>
Escalation policies are available on all pricing plans, although the Free plan is limited to a single escalation policy. All other plans may have unlimited escalation policies.

## Module Capabilities
  * Creates one or many PagerDuty Escalation Policies
  * Creates one or many Escalation Rules/Targets for each Escalation Policy.
<br>

## Examples
Look at our complete [Terraform examples](latest/examples/terraform/) where you can get a better context of usage. The Terragrunt example can be viewed directly from GitHub.
<br>

## Assumptions
You already have a PagerDuty API key to use for this deployment.
<br>

## Usage
  * Toggle the `create_escalation_policies` value to `true` or `false` to create or destroy those resources.
<br>

### Complete Terraform Example
```
module "escalation_policies" {
  source = "git@github.com:adamwshero/terraform-pagerduty-escalation-policy.git//.?ref=1.0.0"

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

### Complete Terragrunt Example
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
  source = "git@github.com:adamwshero/terraform-pagerduty-escalation-policy.git//.?ref=1.0.0"
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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 
| <a name="requirement_terragrunt"></a> [terragrunt](#requirement\_terragrunt) | >= 0.28.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_pagerduty"></a> [pagerduty](#provider\_pagerduty) | >= 2.6.2 |

## Resources

| Name | Type |
|------|------|
| [pagerduty_escalation_policy.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/escalation_policy) | resource |

## Available Inputs

| Name               | Resource                      | Variable                      | Data Type      | Default | Required? |
| ------------------ | ------------------------------|------------------------------ | -------------- | ------- | ----------|
| Policy Name        | pagerduty_escalation_policy   | `name`                        | `string`       | `null`  | No        |
| Policy Description | pagerduty_escalation_policy   | `description`                 | `string`       | `null`  | Yes       |
| Number of Loops    | pagerduty_escalation_policy   | `num_loops `                  | `number`       | `1 `    | No        |
| Teams              | pagerduty_escalation_policy   | `teams`                       | `list(string)` | `null`  | No        | 
| Escalation Delay   | pagerduty_escalation_policy   | `escalation_delay_in_minutes` | `number`       | `null`  | No        | 
| Escalation Type    | pagerduty_escalation_policy   | `type`                        | `string`       | `null`  | No        |
| Id                 | pagerduty_escalation_policy   | `id`                          | `string`       | `null`  | Yes       |

## Predetermined Inputs

| Name                 | Resource               | Property   | Data Type | Default | Required?
| -------------------- | ---------------------- | ---------- | --------- | ------- | -------- |
|                      |                        |            |           |         |          |

## Outputs

| Name                                     | Description                                |
|------------------------------------------|------------------------------------------- | 
| pagerduty_escalation_policy.name         | Name of the escalation policy.             |
| pagerduty_escalation_policy.description  | Description of the escalation policy.      |
| pagerduty_escalation_policy.num_loops    | Number of loops for the escalation policy. |
| pagerduty_escalation_policy.teams        | Teams the escalation policy applies to.    |
| pagerduty_escalation_policy.rules        | Rulesof the escalation policy.             |

## Supporting Articles & Documentation
  * PagerDuty Developer Guide (Escalation Policy)
    * https://developer.pagerduty.com/api-reference/b3A6Mjc0ODEyNQ-create-an-escalation-policy