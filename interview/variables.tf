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