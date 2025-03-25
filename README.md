# thompson-interviews
Contains resources for interviewing with a focus on infrastructure. Pairs with my `thompson-interviews` gcp project.

## Pre-Interview Steps
For interviewees to perform.
1. Install the gcloud CLI: https://cloud.google.com/sdk/docs/install
2. Install the terraform CLI
    - (Recommended) Use [tfenv](https://github.com/tfutils/tfenv).
    - Or (on MacOS): `brew tap hashicorp/tap && brew install hashicorp/tap/terraform`.
2. Authenticate w/ your account for your application default credentials (ADC)
> gcloud auth application-default login
3. (Optional; If you want to use other bits of the gcloud CLI that you have IAM permissions to use):
> gcloud config set project thompson-interviews
