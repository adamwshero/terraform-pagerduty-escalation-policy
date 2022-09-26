######################
# PagerDuty API Token
######################
variable "token" {
  type        = string
  description = "Pagerduty token"
}

##############################
# PagerDuty Escalation Policy
##############################
variable "create_escalation_policy" {
  description = "Decide to create a new escalation policy or use an existing one."
  type        = bool
  default     = false
}
variable "escalation_policies" {
  description = "List of escalation policies and rules to create."
  type        = any
}
variable "name" {
  description = "(Required) The name of the escalation policy."
  type        = string
  default     = null
}
variable "description" {
  description = "(Optional) A human-friendly description of the escalation policy. If not set, a placeholder of `Managed by Terraform` will be set."
  type        = string
  default     = null
}
variable "teams" {
  description = "(Optional) Teams associated with the policy. Account must have the teams ability to use this parameter."
  type        = list(string)
  default     = null
}
variable "num_loops" {
  description = "(Optional) The number of times the escalation policy will repeat after reaching the end of its escalation."
  type        = number
  default     = 1
}
variable "escalation_delay_in_minutes" {
  description = "(Required) The number of minutes before an unacknowledged incident escalates away from this rule."
  type        = number
  default     = 15
}
variable "type" {
  description = "(Optional) Can be `user_reference` or `schedule_reference`. Defaults to `user_reference`. For multiple users as example, repeat the target."
  type        = string
  default     = "user_reference"
}
variable "id" {
  description = "(Required) A target ID."
  type        = string
  default     = null
}
