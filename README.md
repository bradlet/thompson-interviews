# thompson-interviews
Contains resources for interviewing with a focus on infrastructure. Pairs with my `thompson-interviews` gcp project.

# Instructions

## Pre-Interview Workstation Setup
1. Install the gcloud CLI: https://cloud.google.com/sdk/docs/install
2. Install the terraform CLI
    - (Recommended) Use [tfenv](https://github.com/tfutils/tfenv).
    - Or (on MacOS): `brew tap hashicorp/tap && brew install hashicorp/tap/terraform`.
3. Authenticate w/ your account for your application default credentials (ADC)
> gcloud auth application-default login
4. (Optional; If you want to use other bits of the gcloud CLI that you have IAM permissions to use):
> gcloud config set project thompson-interviews

## Action Items
These are the only two things expected of you ahead of the interview.
- Please respond with an email associated with a valid Google account. Your interviewer needs to
have this in advance in order to setup basic permissioning allowing you to interact with GCP.
- If your personal GitHub is associated with a different email, please provide that is well.

# Technical Problem 

## Context
"Company Blank is undergoing a transition from a monolithic architecture to a more modular,
service-oriented design, and its engineering organization is reinforcing its event-driven
architecture principles. Imagine you're joining a small, focused team tasked with extracting a 
well-defined piece of functionality from the monolith into a standalone domain service. 
This new service will operate within an isolated environment (a separate GCP project) 
and will communicate via Google Pub/Sub. While the long-term goal is to establish a 
fully decoupled event ecosystem, the immediate priority is to integrate with a set of 
existing Pub/Sub topics—while extending the system with new topics to support evolving 
product requirements."

## Assets
You will be granted access to a git repository in the interview, in which you'll implement
a solution to the technical problem.
- `/interview` -- A terraform module that is already seeded with a portion of the implementation
needed to satisify the product requirement.
- `/scripts` -- Provide scripts which act as a 'unit test' to determine the functionality of the infrastructure
 provisioned.
    - If you can successfully run the scripts to interact with a pubsub topic provisioned, you've met the
    product requirement and completed the technical problem.
