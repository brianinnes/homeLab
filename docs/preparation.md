# Getting ready for the installation

<!--- cSpell:ignore  glusterfs  -->

Before starting to install oVirt and OKD you need to ensure you have the necessary environment available.  This includes:

- Having sufficient compute, memory and storage available for the cluster
- Having the required networking infrastructure and services available and configured

## Hardware requirements

The [OKD documentation](https://docs.okd.io/latest/installing/installing_rhv/installing-rhv-default.html){: target=blank} describes an OKD production environment on oVirt, which specifies hardware requirements of:

- Minimum 28 vCPUs
- 112 GiB RAM
- min 230 GiB storage (non-prod) or 840 GiB (prod)

The documentation also assumes that oVirt will be installed over multiple physical hosts, to provide a more resilient environment.  However, for this home lab setup a single machine will be used.

However, for a Home Lab environment the oVirt environment can be configured to over commit memory, to allow a cluster to be setup with a minimum of 56 GiB memory, but then you will be constrained on what you can deploy into the cluster.

!!!todo
    When SNO docs is available fix 

There is also the option to not deploy a fault tolerant OKD cluster and reduce the number of Master nodes, details of how to create a single node installation can be found in the `[OKD documentation](https://docs.okd.io/latest/installing/installing_sno/install-sno-preparing-to-install-sno.html){target=_blank}`, which needs 8 vCPU cores and 32GB RAM.  An alternate option may be to use [Code-Ready Containers](https://www.okd.io/crc/){target=_blank}

### Storage setup

A fault tolerant version of OKD needs fast storage to keep the nodes synchronised via the etcd key-value store.  Traditional spinning disks are not fast enough for this purpose so Solid State Drives (SSD) are needed to host the system nodes.

oVirt includes [glusterfs](https://www.gluster.org){target=_blank} to provide host storage to the virtual machines.  The SSD storage needs to be exposed via gluster so oVirt can use it as the storage for the OKD cluster nodes

## Network Requirements

To run oVirt and OKD you need some local network infrastructure to provide:

- DHCP IP allocation
- DNS name resolution

- each physical host you will use to host the oVirt nodes will need an IP address
- the oVirt virtualization manager VM will need an IP address, with DNS resolution on the local network
- OKD needs 2 IP addresses allocated for the API endpoint and the cluster ingress, again DNS resolution is needed for the 2 IP addresses
- the local network DNS resolution must be configured to resolve certain FQDN (Fully Qualified Domain Name).  This includes resolving all names matching  `*.apps.<cluster-name>.<base-domain>`, which will resolve all deployed application on OKD exposed using the ingress.
