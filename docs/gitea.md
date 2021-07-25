# Gitea

<!--- cSpell:ignore  Gitea OpenSource Brancz -->

[Gitea](https://gitea.io){: target=_blank} is an opensource git server that will be used to provide a local git server.

There is a RedHat provided operator available as an Operator Hub catalog source on [GitHub](https://github.com/redhat-gpte-devopsautomation/gitea-operator){: target=_blank}, however, this will not work on OKD as it relies on a container registry.redhat.io/openshift4/ose-kube-rbac-proxy, which requires an OpenShift pull secret to access.

An kube RBAC proxy is available here : [https://github.com/brancz/kube-rbac-proxy](https://github.com/brancz/kube-rbac-proxy){: target=_blank} - is this an equivalent replacement?  Container is available also [here](quay.io/brancz/kube-rbac-proxy){: target=_blank}
