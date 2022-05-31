# ArgoCD

<!--- cSpell:ignore Argo -->

Argo CD is a GitOps continuous delivery tool for Kubernetes.  It allows you to declaratively define kubernetes and application configuration in a source code management tool and will ensure ensure the cluster remains in sync with the declared desired state.

## Installation

ArgoCD is in the community operator catalog, so can be easily installed.  Install the operator, accepting all the defaults.

When the operator is installed, create an ArgoCD instance accepting all defaults.

## Accessing ArgoCD

In the ArgoCD overview panel of the deployed instance (Installed Operators -> ArgoCD (ensure **All Projects** is the active project) -> ArgoCD -> select your instance) you will see the project that your ArgoCD instance is installed in (default should be openshift-operators).

- Switch to the project that ArgoCD is installed in
- open the secrets panel (Workloads -> Secrets) and find the secret `<ArgoCD instance name>-cluster`.  This secret contains the admin password for your ArgoCD instance.
- The URL for the cluster can be found in the routes (Networking -> Routes)