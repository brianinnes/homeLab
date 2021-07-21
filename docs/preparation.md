# Getting ready for the installation

Before starting to install oVirt and OKD you need to ensure you have the necessary environment available.  This includes:

- Having sufficient compute, memory and storage available for the cluster
- Having the required networking infrastructure and services available and configured

## Hardware requirements

The [OKD documentation](https://docs.okd.io/latest/installing/installing_rhv/installing-rhv-default.html){: target=blank} describes an OKD production environment on oVirt, which specifies hardware requirements of:

- Minimum 28 vCPUs
- 112 GiB RAM
- min 230 GiB storage (non-prod) or 840 GiB (prod)

The documentation also assumes that oVirt will be installed over multiple physical hosts, to provide a more resilient environment.  However, for this home lab setup a single machine will be used.

!!! Todo
    Checkout the memory requirements mentioned below

However, for a Home Lab environment the oVirt environment can be configured to over commit memory, to allow a cluster to be setup with a minimum of 56 GiB memory, but then you will be constrained on what you can deploy into the cluster.

There is also the option to not deploy a fault tolerant OKD cluster and reduce the number of Master nodes, however, if going down that route **CodeReady Containers** may be a better option.

### Storage setup

!!!ToDo
    Complete this section

- Storage
  - partition for Gluster
  - split disk usage

## Network Requirements

!!!Todo
    Complete this section

- IP Addresses and DNS resolution needed
  - oVirt host
  - virtual Engine
  - OKD
