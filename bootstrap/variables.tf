variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
  default     = "thompson-interviews"
}

variable "location" {
  description = "The GCP region to deploy to"
  type        = string
  default     = "us-central1"
}

variable "enabled_services" {
  description = "The list of services to enable for the project."
  type        = set(string)
  default     = ["pubsub.googleapis.com"]
}

variable "interviewees" {
  description = "The list of interviewees to be granted limited access to the project."
  type        = set(string)
  default     = ["mail@bradlet.com"]
}
