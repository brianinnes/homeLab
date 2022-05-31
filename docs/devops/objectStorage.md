# Object Storage

<!--- cSpell:ignore noobaa -->

Object storage is a popular storage technology on cloud, with all major cloud providers offering an Object Storage service.  The Amazon Web Services S3 API has become the de facto API to use to access Object Service.

[noobaa](https://www.noobaa.io) is an Open Source project that offers AWS S3 compatibility and offers a private cloud Object Storage capability with the ability to aggregate private and public object storage services.

## Installing noobaa

Installing noobaa on OKD is simple, using the [NooBaa Operator](https://github.com/noobaa/noobaa-operator).  Simply follow the instructions in the project README

!!!Todo
    Are there Windows instructions or should Windows users use the Windows Linux integration?

## Managing noobaa

Once noobaa is installed you can access the management console and the S3 API.  To get the URLs you can use the OKD command line `oc get routes -n noobaa` or the noobaa command line `noobaa status` or use the web console to look at the routes in the noobaa project

!!!Note
    The noobaa management console only runs in the Chrome browser

To log into the management console you can use the details from the **noobaa-admin** secret in the **noobaa** project.  Once logged onto the management console you can create your own user account and create buckets, backing stores or add other public cloud providers
