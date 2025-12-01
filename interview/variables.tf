variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
  default     = "thompson-interviews-480021"
}

variable "location" {
  description = "The GCP region to deploy to"
  type        = string
  default     = "us-central1"
}

variable "pubsub_accessors" {
  description = "The list of members to be granted limited access to the pubsub topics"
  type        = set(string)
  default     = []
}
