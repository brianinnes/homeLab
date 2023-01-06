---
template: home.html
title: Home Lab
---

<!--- cSpell:ignore devfile Kustomize -->


This site will walk you through how to create your own home or office Lab environment, enabling you to explore Red Hat OpenShift, using oVirt and OKD.

This setup uses the simplest possible network configuration with a single physical workstation hosting the entire cluster.

There are other online resources which explain how to set up a multi-machine hosted installation with more complex network setup.  I've included a few links in the [resources](./resources.md) section of this site.

## Prerequisites

The following tools must be installed on your laptop or workstation

!!!Todo
    Create pipeline tasks or devfile for Che workspaces so nothing needs to be done on a local workstation

- [Operator SDK](https://github.com/operator-framework/operator-sdk)
- [Kustomize](https://github.com/kubernetes-sigs/kustomize)
- [controller-gen](https://github.com/kubernetes-sigs/controller-tools)
