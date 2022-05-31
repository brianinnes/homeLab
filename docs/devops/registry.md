# Container Registry

<!--- cSpell:ignore noobaa dockerhub objectstorage -->

There are many public containers registries available with [dockerhub](https://hub.docker.com) being the most popular.  However, dockerhub as download limits which can cause issues for home lab environments.  Without a paid subscription dockerhub can limit the number of daily container pulls from a single IP address, which can prevent a Kubernetes platform from accessing images.

To overcome the dockerhub limits a local container registry will be setup that also provides a pull through cache, so containers on public registries can be fetched from the public and cached and served from the local registry to overcome the daily limit.  It also provides local registry functionality rather than having to push images to a public registry for development projects.

[Project Quay](https://www.projectquay.io) is a community distribution of RedHat Quay.  It provides a fully functional container registry with build in scanning using Clair and a pull through cache (from version 3.7)

## Installing project Quay

The OperatorHub installed in OKD contains the community Project Quay operator, which will install Project Quay in your OKD cluster.

Install the Project Quay operator and wait for it to be ready (accept all the default settings), then from the Installed Operators panel in the OKD web UI select the Quay operator then switch to the **Quay Registry** tab.

Select the **Create Quay Registry* button then :

- give the registry a name
- Expand the **Advanced configuration** section, then the **Components** section
    - remove the tick from the managed checkbox for the objectstorage service
- press the create button to start the Quay registry creation

The Quay registry will not complete at this stage as there is some configuration missing.

The operator uses a secret to control the configuration of the registry.  

Open the Quay Registry entry (in the Installed Operators -> Quay operator -> Quay Registry section of the OKD UI).  You will see a link to the configuration secret displayed.  Select it to open the secret then press the Reveal values link to show the configuration document.  

You need to change the secret to:

- include the object storage config (covered in the next section)
- turn on the caching feature (which is disabled by default in Project Quay 3.7) by adding `FEATURE_PROXY_CACHE: true` to the config secret
- give admin access to a user (covered in later section)

### Configuring Quay storage

Quay uses ObjectStorage so will use the [noobaa installation](objectStorage.md) installation.  In the noobaa management console login and select the **Buckets** icon from the side menu, then create a new bucket for use by quay.  

Whilst in the noobaa management console, select the Overview icon from the side menu then the **Connect Application** button.  This will display a window containing the connection details needed to communicate with noobaa.  If you have created multiple accounts you can use the Target Account field to select the account to connect as.  You will need the connection settings in the next step.

Add the Object Store configuration to the Quay configuration secret:

```yaml
DISTRIBUTED_STORAGE_CONFIG:
    local_us:
        - RHOCSStorage
        - access_key: <access key>
          bucket_name: <bucket name>
          hostname: <hostname>
          is_secure: false
          port: "80"
          secret_key: <secret key>
          storage_path: /datastorage/registry
```

where:

- `<access key>` is the access key from the noobaa connection details
- `<bucket name>` is the storage bucket created for quay to use
- `<hostname>` is the S3 API endpoint for noobaa.
- `<secret key>` is the secret key from the noobaa connection details

### Configuration secret

The Project Quay documentation has more details about the configuration secret, but your secret should look something like this:

```yaml
ALLOW_PULLS_WITHOUT_STRICT_LOGGING: false
AUTHENTICATION_TYPE: Database
DEFAULT_TAG_EXPIRATION: 2w
DISTRIBUTED_STORAGE_CONFIG:
    local_us:
        - RHOCSStorage
        - access_key: xxxx
          bucket_name: lab-quay
          hostname: s3-noobaa.apps.xxxxxx
          is_secure: false
          port: "80"
          secret_key: xxxx
          storage_path: /datastorage/registry
ENTERPRISE_LOGO_URL: /static/img/quay-horizontal-color.svg
FEATURE_BUILD_SUPPORT: true
FEATURE_PROXY_CACHE: true
FEATURE_DIRECT_LOGIN: true
FEATURE_MAILING: false
REGISTRY_TITLE: Quay
REGISTRY_TITLE_SHORT: Quay
SETUP_COMPLETE: true
SUPER_USERS:
- brian
TAG_EXPIRATION_OPTIONS:
- 2w
TEAM_RESYNC_STALE_TIME: 60m
TESTING: false
```

You will see there is a section for SUPER_USERS.  Entries in this section define which users have access to the Admin Panel.  You need to create the user first.

Once you have edited the secret (either using the OKD Web UI or from the command line) your ProjectQuay instance should complete, which will allow you to access the Project Quay web UI.

Get the URL by looking at the Routes in the networking section of the OKD Web UI in project **openshift-operators** or by using the OKD command line `oc get routes -n openshift-operators`.  There are 2 or 3 endpoints associated with quay:

- the main UI (`<registry name>-quay-openshift-operators.apps.<cluster base domain>`)
- the builder (if this feature is enabled - `<registry name>-quay-builder-openshift-operators.apps.<cluster base domain>`)
- the config editor (`<registry name>-quay-config-editor-openshift-operators.apps.<cluster base domain>`)

Open the main UI URL.  This will present the login screen for Quay, which also allows you to create an account.  If you want the account to have admin privileges add the username to the SUPER_USERS section of the config secret.
