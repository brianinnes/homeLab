# OKD Install

<!--- cSpell:ignore  ovirtmgmt Fzcwo openshift ully ualified omain mkdir -->

When you have your oVirt environment up and running you can install OKD.

## Preparing required information

To help with the installation here is a list of information you will need during the install:

| item   | description|
|--------|------------|
| Engine FQDN | This is the Fully Qualified Domain Name of the virtual engine.  This is the value you entered in step 1 in oVirt setup section [Install the Hosted Engine](./ovirt.md/#install-the-hosted-engine){: target=_blank} |
| Engine user | This should be admin |
| Engine password | This is the value entered at ovirt install time, and the password you use to access the ovirt admin console |
| oVirt Cluster name | Should be **Default**.  This can be verified in the oVirt Administration console, select **Compute** from the side menu then **Clusters**.  By default there is a single cluster defined with **Default** as the name |
|  Storage Domain | Select the storage domain with fast storage, ideally Solid State Disk (SSD) should be used |
| Network | Select the oVirt network to place the OKD cluster hosts on.  By default a single network named **ovirtmgmt** is created at oVirt install |
| IP address for the API endpoint for the OKD cluster | The IP address on your network you previously allocated for the OKD cluster API Endpoint |
| IP address for the Ingress for the OKD cluster | The IP address on your network you previously allocated for the OKD Cluster Ingress |
| OKD Cluster base domain | The base domain your cluster will use for all exposed endpoints - This cannot be changed after installation |
| Cluster Name | The name for the OKD cluster, this will be prepended to the base domain to form the URLs for application and API endpoints. (e.g. ```api.<cluster name>.<base domain>```) |
| Enter a valid Red Hat pull secret | This is the pull secret to the Red Hat image registries where Open Shift images are stored.  You don't need to use a valid pull secret as OKD does not need access to the registries, but providing a valid secret will allow Red Hat applications to be installed on the cluster.  The pull secret must pass a validation check.  A valid fake secret is ```{"auths":{"fake":{"auth":"aWQ6cGFzcwo="}}}```.  If you have a Red Hat account a valid secret can be downloaded from [here](https://cloud.redhat.com/openshift/install/pull-secret){: target=_blank}|

## Install OKD

Complete the following steps to install OKD on your cluster

### Download the installer

- To find the latest version of the OKD installer, visit the [releases](https://github.com/openshift/okd/releases){: target=_blank} page and download the latest openshift-install image for the platform where you plan to run the installer from (this is typically your local laptop, but could be a virtual machine you run on the ovirt cluster).  
- Expand the downloaded archive to allow access to the openshift-install binary.

### Create the install config

- Open a command or terminal window and switch to the directory containing the openshift-install binary
- run command ```./openshift-install create install-config```
    - select oVirt as the Platform
    - enter the engine **F**ully **Q**ualified **D**omain **N**ame
    - accept the suggested engine username (admin@internal) by pressing enter
    - enter the engine password
    - accept the default Cluster name, which should be set as **Default** unless you have changed oVirt configuration
    - select the appropriate storage domain to store the OKD cluster host disk images
    - select the Network to use
    - input IP address allocated to OKD cluster API endpoint
    - input IP address allocated to OKD cluster Ingress

### Run the installer

!!!Note
    The default install will download the required content from the internet.  It is assumed that the machine running the **openshift-install** application and the machine hosting **oVirt** and the **OKD** cluster have a good internet connection to be able to download the required content.

- create an install directory ```mkdir install```
- copy the configuration into the install directory - don't move it, copy it as it gets deleted during the install, so it is good to have a backup copy. ```cp install-config.yaml install```
- create the cluster with command ```./openshift-install create cluster --dir=./install --log-level=info```
- wait until the setup completes, this can take quite a while, 30-60 minutes is not uncommon
- when the install completes you will see a message similar to this:

    ```text
    INFO Install complete!                            
    INFO To access the cluster as the system:admin user when using 'oc', run 'export KUBECONFIG=/Users/brian/projects/okd/4.7/install/auth/kubeconfig' 
    INFO Access the OpenShift web-console here: https://console-openshift-console.apps.okd.lab.home 
    INFO Login to the console with user: "kubeadmin", and password: "xxxxx-xxxxx-xxxxx-xxxxx"
    ```

## Connecting to the cluster

### Web UI

### Command line

## Post install tasks

!!!Info
    If you are getting warnings that your cluster is unable to retrieve available updates because ```https://origin-release.svc.ci.openshift.org``` host cannot be found, then you have an out of date URL in the update service.  You can fix this by running the followin command as an admin user on the command line:

    ```text
    oc patch clusterversion/version --patch '{"spec":{"upstream":"https://amd64.origin.releases.ci.openshift.org/graph"}}' --type=merge
    ```
