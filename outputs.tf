output "pagerduty_escalation_policy_ids" {
  description = "Ids of PagerDuty Escalation Policies."
  value = tomap({
    for k, policies in pagerduty_escalation_policy.this : k => {
      name                        = policies.name
      description                 = policies.description
      num_loops                   = policies.num_loops
      teams                       = policies.teams
      escalation_delay_in_minutes = policies.escalation_delay_in_minutes
      type                        = policies.type
      id                          = policies.id
    }
  })
}
