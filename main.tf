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

resource "pagerduty_escalation_policy" "this" {
  for_each = {
    for policy in var.escalation_policies : policy.name => {
      name        = policy.name
      description = policy.description
      num_loops   = policy.num_loops
      teams       = policy.teams
      rules       = policy.rules
    }
    if var.create_escalation_policy == true
  }
  name        = each.value.name
  description = each.value.description
  num_loops   = each.value.num_loops
  teams       = each.value.teams
  dynamic "rule" {
    for_each = each.value.rules
    content {
      escalation_delay_in_minutes = rule.value.escalation_delay_in_minutes
      target {
        type = rule.value.target.type
        id   = rule.value.target.id
      }
    }
  }
}
