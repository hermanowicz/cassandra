variable "region" {
  type        = string
  description = "Default region for this deployment"
  default     = "eu-west-1"
}

variable "p-name" {
  type        = string
  description = "Name for the project"
  default     = "cassandra-labs"
}
