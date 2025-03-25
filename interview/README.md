# Event-Driven-Architecture Supporting Infrastructure

## Context
"Company Blank is undergoing a transition from a monolithic architecture to a more modular, service-oriented design, and its engineering organization is reinforcing its event-driven architecture principles. Imagine you're joining a small, focused team tasked with extracting a well-defined piece of functionality from the monolith into a standalone domain service. This new service will operate within an isolated environment (a separate GCP project) and will communicate via Google Pub/Sub. While the long-term goal is to establish a fully decoupled event ecosystem, the immediate priority is to integrate with a set of existing Pub/Sub topics—while extending the system with new topics to support evolving product requirements."

## Interacting with remote resources
Before starting the interview, the interviewer should have been provided an email associated with your Google
account. Assuming they have performed some initial bootstrapping, you should have all the necessary permissions
to interact with remote state and create any resources relevant to the scope of this technical problem.

### Applying Terraform
It's assumed that you have installed the `terraform` cli at this point.

If you used `tfenv`, it's recommended to run `tfenv use` in the repo root.

Run the following to apply this terraform module, supplying your user principal as a "pubsub_accessor":
> terraform apply -var='pubsub_accessors=["user:your_google_account@email.com"]'

Note: Can also supply a tfvars file: `terraform.tfvars`, `interview.auto.tfvars`, etc.
