#!/bin/bash

set -e

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <subscription-name> [project-id]"
  # Example: ./consume-msg.sh test-subscription
  exit 1
fi

SUBSCRIPTION_NAME="$1"
PROJECT_ID=${2:-thompson-interviews}

echo "Pulling messages from subscription '$SUBSCRIPTION_NAME'..."

gcloud pubsub subscriptions pull "$SUBSCRIPTION_NAME" \
  --limit=10 \
  --auto-ack \
  --format=json \
  --project="$PROJECT_ID" \
  | jq -r '.[].message.data' \
  | while read encoded; do
      if [ -n "$encoded" ]; then
        decoded=$(echo "$encoded" | base64 --decode)
        echo "📩 $decoded"
      fi
    done
