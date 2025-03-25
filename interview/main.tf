terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.12.0"
    }
  }

  backend "gcs" {
    bucket  = "thompson-interviews-state"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.location
}

resource "google_pubsub_schema" "managed" {
  for_each = local.managed_topic_config
  name = each.key
  type = "AVRO"
  definition = file(each.value)
}

resource "google_pubsub_topic" "managed" {
  for_each = local.managed_topic_config
  name = format("%s-topic", each.key)

  # depends_on = [google_pubsub_schema.example]
  schema_settings {
    # schema = "projects/my-project-name/schemas/example"
    # Note: just leaving this in to remind myself how to do this incorrectly.
    schema = format("projects/%s/schemas/%s", var.project_id, each.key)
    encoding = "JSON"
  }
}

locals {
  // Map of topic name to schema path
  managed_topic_config = {
    "test-topic" = "schemas/test.avro"
  }
}