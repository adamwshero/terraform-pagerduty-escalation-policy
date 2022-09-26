output "pagerduty_escalation_policy_id" {
  description = "Ids of PagerDuty Escalation Policies."
  value       = pagerduty_escalation_policy.this[0].id
}


output "pagerduty_escalation_policy_ids" {
  description = "Ids of PagerDuty Escalation Policies."
  value = tomap({
    for k, policies in pagerduty_escalation_policy.this : k => {
      name        = policies.name
      description = policies.description
      num_loops   = policies.num_loops
      teams       = policies.teams
      rules       = policies.rules
    }
  })
}
