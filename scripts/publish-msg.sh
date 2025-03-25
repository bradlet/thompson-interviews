#!/bin/bash

set -e

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <topic-name> '<json-payload>' [project-id]"
  # Example: ./publish_avro.sh test-topic '{"id": "123"}'
  exit 1
fi

TOPIC_NAME="$1"
JSON_PAYLOAD="$2"
PROJECT_ID=${3:-thompson-interviews}

# Validate that payload is valid JSON
if ! echo "$JSON_PAYLOAD" | jq empty 2>/dev/null; then
  echo "Invalid JSON payload."
  exit 1
fi

# Publish to the topic
echo "Publishing to topic '$TOPIC_NAME' with message: $JSON_PAYLOAD"
gcloud pubsub topics publish "$TOPIC_NAME" \
  --message="$JSON_PAYLOAD" \
  --project="$PROJECT_ID"

echo "Message published ✅"
