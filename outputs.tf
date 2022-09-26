output "pagerduty_escalation_policies" {
  description = "Ids of PagerDuty Escalation Policies."
  value       = pagerduty_escalation_policy.this.* [0].*
}
