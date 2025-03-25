terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.12.0"
    }
  }

  // Local state backend
}

provider "google" {
  project = var.project_id
  region  = var.location
}

resource "google_storage_bucket" "project_bucket" {
  name          = format("%s-state", var.project_id)
  location      = var.location
  force_destroy = true

  uniform_bucket_level_access = true
}

resource "google_project_iam_member" "interviewee_state_access" {
  for_each = var.interviewees

  project = var.project_id
  role    = "roles/storage.objectUser"
  member  = format("user:%s", each.value)
}

resource "google_project_service" "enabled_services" {
  for_each = var.enabled_services

  project = var.project_id
  service = each.key
}

resource "google_project_iam_member" "interviewee_pubsub_access" {
  for_each = var.interviewees

  project = var.project_id
  role    = "roles/pubsub.editor"
  member  = format("user:%s", each.value)
}

resource "google_project_iam_member" "interviewee_viewer" {
  for_each = var.interviewees

  project = var.project_id
  role    = "roles/viewer"
  member  = format("user:%s", each.value)
}

// Need to explicitly grant ability to form IAM binding, but don't want to give delete access
resource "google_project_iam_custom_role" "iam_write_access_role" {
  role_id = "WriteOnlyIAMAccess"
  title   = "Write Only IAM Access"
  permissions = [
    "resourcemanager.projects.createPolicyBinding",
    "resourcemanager.projects.get",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.searchPolicyBindings",
    "resourcemanager.projects.setIamPolicy",
    "resourcemanager.projects.updatePolicyBinding",
    // Specific pubub topic IAM policy access:
    "pubsub.topics.getIamPolicy",
    "pubsub.topics.setIamPolicy",
    "pubsub.subscriptions.getIamPolicy",
    "pubsub.subscriptions.setIamPolicy",
    "pubsub.schemas.getIamPolicy",
    "pubsub.schemas.setIamPolicy",
    "pubsub.snapshots.getIamPolicy",
    "pubsub.snapshots.setIamPolicy",
  ]
}

resource "google_project_iam_member" "interviewee_iam_write_access" {
  for_each = var.interviewees

  project = var.project_id
  role    = google_project_iam_custom_role.iam_write_access_role.name
  member  = format("user:%s", each.value)
}
