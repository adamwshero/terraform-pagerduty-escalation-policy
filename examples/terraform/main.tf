terraform {
  required_providers {
    pagerduty = {
      source  = "PagerDuty/pagerduty"
      version = "~>2.6.2"
    }
  }
}
provider "pagerduty" {
  token = var.token
}

module "escalation_policies" {
  source = "git@github.com:adamwshero/terraform-pagerduty-escalation-policy.git//.?ref=1.0.1"

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
