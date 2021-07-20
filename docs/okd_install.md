# OKD Install

<!--- cSpell:ignore  ovirtmgmt Fzcwo openshift ully ualified omain mkdir kubeadmin kubeconfig htpasswd -->

When you have your oVirt environment up and running you can install OKD.

## Preparing required information

To help with the installation here is a list of information you will need during the install:

| item   | description|
|--------|------------|
| Engine FQDN | This is the Fully Qualified Domain Name of the virtual engine.  This is the value you entered in step 1 in oVirt setup section [Install the Hosted Engine](./ovirt.md#install-the-hosted-engine){: target=_blank} |
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

Alternatively you can download one of the [nightly builds](https://amd64.origin.releases.ci.openshift.org){: target=_blank}.  These builds contain recent updates and fixes, but aren't an official release, so may contain unresolved issues.  Click on a build to get information about the build and also the command to download and unpack the build to your local system

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

!!!Warning
    It is important that you keep the install directory after the installation has finished, as if you ever shut your cluster down for a length of time, then the certificates used within the system may expire whilst the system is down.  The only way to access the cluster to renew the certificates is the the auth credentials contained within the install directory.  You also need the install directory if you want to uninstall the cluster.

## Connecting to the cluster

Now your cluster has been installed you want to be able to access it.  There are 2 ways to access it:

- Web Console
- Command line

### Web UI

After installation your cluster web console should be accessible at the URL displayed when the openshift-install command completes.  The URL is  of the form ```https://console-openshift-console.apps.<cluster name>.<base domain>```.

You can use the kubeadmin command, with the password displayed when the openshift-install command completed.  This is the temporary cluster admin account.  You should add an identity provider and create your own admin account.   Instructions to complete this task are provided below.

### Command lined

You can access the cluster from the command line using the **oc** command line tool.  Please ensure the version of OC is up to date.  The correct version of **oc** for your cluster can be downloaded from the web console.  Select the question mark (?) icon next to your user name in the top menu, then select **Command line tools** from the menu.  Then you can select the appropriate binary version of the tool for your operating system.

Once you have the oc tool install you can connect to the cluster.  There are 2 ways to connect to the cluster:

#### Connecting using the kubeconfig file

During installation a kubeconfig file was created.  This content needs to be kept safe, as it can be the only way o log in if the cluster has been shutdown for a while and certificates have expired.  It also provides an admin login.  To use the file set the environment variable KUBECONFIG to point to the config file.  The location was provided as part of the openshift-install completion message, such as :

```shell
export KUBECONFIG=/Users/brian/projects/okd/4.7/install/auth/kubeconfig
```

you can now use the oc command and be connected as an administrator.

#### Connect as a specific user

You can specify a user on the command line.  Ensure the KUBECONFIG environment variable is not set, then login using:

```shell
oc login -u <user> --server=https://api.<cluster name>.<base domain>:6443
```

If you are logged into the web console as the user you wish to use on the command line, then you can get the login command using the drop down menu shown when you click your username in the top menu.  Select **Copy login command** from the menu, you will be prompted for your password, then you can select **Display Token** to see a login command.  This uses a generated token rather than your username and password.

## Post install tasks

!!!Info
    If you are getting warnings that your cluster is unable to retrieve available updates because ```https://origin-release.svc.ci.openshift.org``` host cannot be found, then you have an out of date URL in the update service.  You can fix this by running the following command as an admin user on the command line:

    ```text
    oc patch clusterversion/version --patch '{"spec":{"upstream":"https://amd64.origin.releases.ci.openshift.org/graph"}}' --type=merge
    ```

### Adding an Identity provider

You need a system to authenticate users to the system.  OKD supports a number of different options for authenticating users.  Here we will use the basic htpasswd authentication method, which is a simple list of users with encrypted passwords, held in a Kubernetes secrets object.  Details of other authentication methods can be found in the [OKD documentation](https://docs.okd.io/latest/authentication/understanding-identity-provider.html){: target=_blank}

Full instructions for the HTPasswd identity provider can be found in the [OKD documentation](https://docs.okd.io/latest/authentication/identity_providers/configuring-htpasswd-identity-provider.html){: target=_blank}

#### Creating the users and passwords

You need access to the [htpasswd](http://httpd.apache.org/docs/2.4/programs/htpasswd.html){: target=_blank} utility.  This comes with most Linux distributions and MacOS.  Windows users may need to get it from an apache HTTP server distribution.

Create the user file and add the first user with command:

```shell
htpasswd -c -B -b users.htpasswd <user_name> <password>
```

the file **users.htpasswd** will be created in the current directory.

Add additional users with command (this command expects to find file **users.htpasswd** in the current working directory):

```shell
htpasswd -B -b users.htpasswd <user_name> <password>
```

#### Creating the secret from the users file

Once you have the users.htpasswd file created and populated with all the users you want on to be able to access the system, then you need to create a secret from the file with command (this command expects to find the **users.htpasswd** file in the current working directory):

```shell
oc create secret generic htpass-secret --from-file=htpasswd=users.htpasswd -n openshift-config
```

#### Creating identity provider configuration

You can now create the identity provider using command:

=== "Linux & Max OS"

    ```shell
    cat <<EOF | kubectl apply -f -
    apiVersion: config.openshift.io/v1
    kind: OAuth
    metadata:
    name: cluster
    spec:
    identityProviders:
    - name: my_htpasswd_provider
        mappingMethod: claim
        type: HTPasswd
        htpasswd:
        fileData:
            name: htpass-secret
    EOF
    ```

=== "Windows"

    !!!Todo
        Add Windows equiv of the command

### Creating an administrator account

After adding the identity provider, you want to make one of the accounts added to the identity provider an administrator user.  

Before proceeding you should log into the cluster from the Web Console, using the user account you want to make an admin user.

On the command line you can make the user an admin user with the following command (replacing **<user>** with a valid user name created for your configured identity provider):

```shell
oc adm policy add-cluster-role-to-user cluster-admin <user>
```

#### Remove the kubeadmin user

The **kubeadmin** user is created during installation and should only be thought of as a temporary users.  Once you have configured an identity provider and made at least one of the users an administrator on the cluster then the kubeadmin user account can be removed.  Use the following command to remove the user:

```shell
oc delete secrets kubeadmin -n kube-system
```
