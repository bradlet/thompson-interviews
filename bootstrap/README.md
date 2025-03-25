# bootstrap
This module contains some foundational bootstrapping infrastructure
applied to prepare the environment for infrastructure testing.

State is stored locally, all applies are assumed to run locally,
and it is assumed that all authentication is handled via application 
default credentials.

---

Aside from the bootstrapping performed here, I also manually added my
work user principal as an owner on the project, so that I could interact
with it seamlessly using personal or professional credentials.

--

# Steps to onboard a new interviewee

1. Add an email that they have associated with a Google account to `variables.tf`
 in the default list input of `interviewees`.
    - Or, supply a '*.auto.tfvars' file with the list containing the expected interviewee.
2. Apply bootstrap module to create IAM bindings for their access -- allow 1-2 mins
 for the changes to propagate.
