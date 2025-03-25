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
  name = format("%s-topic", each.key)

  # Also acceptable but less ideal when implicit dependences are possible
  # depends_on = [google_pubsub_schema.example]
  schema_settings {
    schema = google_pubsub_schema.managed[each.key].id
    # schema = format("projects/%s/schemas/%s", var.project_id, each.key)
    encoding = "JSON"
  }
}

// Provide IAM access for each member expected to access each topic
resource "google_pubsub_topic_iam_member" "managed_topic_access" {
  for_each = {
    for combo in flatten([
      for member in var.pubsub_accessors : [
        for topic in keys(local.managed_topic_config) : {
          member = member
          topic  = topic
        }
      ]
    ]) :
    // Need to give each object a unique key in the map
    "${combo.member}-${combo.topic}" => combo
  }

  topic = google_pubsub_topic.managed[each.value.topic].name // NOTE: name might not be a thing...
  role  = local.READ_WRITE_ROLE // TODO: use one or the other
  member = each.value.member 
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