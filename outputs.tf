# output "pagerduty_escalation_policy_ids" {
#   description = "Ids of PagerDuty Escalation Policies."
#   value = tomap({
#     for k, policies in pagerduty_escalation_policy.this : k => {
#       name                        = policies.name
#       num_loops                   = policies.num_loops
#       teams                       = policies.teams
#       escalation_delay_in_minutes = policies.escalation_delay_in_minutes
#       type                        = policies.type
#       id                          = policies.id
#     }
#   })
# }

output "pagerduty_escalation_policies" {
  description = "Ids of PagerDuty Escalation Policies."
    value = {
        for pagerduty_escalation_policies in keys(var.escalation_policies):
          pagerduty_escalation_policies => pagerduty_escalation_policy.this[pagerduty_escalation_policies].*[0].*
  }
}
