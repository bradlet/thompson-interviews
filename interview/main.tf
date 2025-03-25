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

// Create a schema resource for each configured topic
resource "google_pubsub_schema" "managed" {
  for_each = local.managed_topic_config
  name = format("%s-schema", each.key)
  type = "AVRO"
  definition = file(each.value)
}

// Create the topic resource itself
resource "google_pubsub_topic" "managed" {
  for_each = local.managed_topic_config
  name = each.key

  schema_settings {
    schema = format("projects/%s/schemas/%s-schema", var.project_id, each.key)
    encoding = "JSON"
  }
}

// Create a subscription for each topic -- allow us to test msg ingestion
resource "google_pubsub_subscription" "managed" {
  for_each = local.managed_topic_config
  name = format("%s-sub", each.key)
  topic = format("projects/%s/topics/%s", var.project_id, each.key)
  message_retention_duration = "600s" // 10 minutes
  ack_deadline_seconds = 10
}

locals {
  // Map of topic name to schema path
  managed_topic_config = {
    "test-topic" = "schemas/test-topic.avsc"
  }

  CONSUMER_ROLE = "roles/pubsub.subscriber"
  PRODUCER_ROLE = "roles/pubsub.publisher"
  READ_WRITE_ROLE = "roles/pubsub.editor"
}