# Overview

Getting skills in Cloud Native Development and maintaining those skills can be challenging for a developer.  The technology is evolving very quickly, so having an environment where a developer can update,  explore and learn new features as they emerge is a valuable resource.

Managed cloud based environments are usually a shared resource across a development team, where it is not appropriate to upgrade to the latest emerging technology. as the development environment needs to be a managed, stable environment.

Costs can also be an inhibitor to allow developers to have the environments they want to explore and keep up to date, especially when doing so at home.

This project documents my cloud native development home lab.  I wanted to only use freely available open source technology, but also technology where there is a route into a production environment.

Although the project doesn't use any managed cloud resources, it does require a certain amount of hardware - which may not be appropriate for all developers.  I purchased a reconditioned workstation with a large amount of memory and Intel Xeon processors, to have sufficient hardware resources to run a cloud environment.  This environment will not run on a typical home computer.

This project is based on 2 open source projects :

- [oVirt](https://ovirt.org){: target=_blank} - which is an upstream community run project contributing in to [Red Hat Virtualization](https://www.redhat.com/en/technologies/virtualization/enterprise-virtualization){: target=_blank}
- [OKD](https://okd.io){: target=_blank} - which is a community run sibling project to [Red Hat OpenShift](https://www.openshift.com){: target=_blank}, taking the same source code as a starting point, then applying some customisations to create the deliverables.

## oVirt

**oVirt** is an open-source virtualization solution based on the KVM hypervisor.  It offers an open-source solution similar to the enterprise products from VMWare, to run a distributed, virtualization solution.  

In this projects, for a home lab only a single oVirt instance will be used.

## OKD

**OKD** is an open-source distribution of Kubernetes, that delivers enhanced capabilities over a standard Kubernetes platform.  With additional security features and an integrated user interface with both admin and developer features.
