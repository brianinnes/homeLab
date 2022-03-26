# Pipelines

<!--- cSpell:ignore  tekton -->

Tekton is the upstream project for OpenShift Pipelines.  

The upstream project includes the integration with the OpenShift and OKD consoles, however the upstream project doesn't include the cluster wide tasks that are included in the OpenShift Pipelines operator.

## Installing the Tekton Operator

The Tekton operator source can be found on [github](https://github.com/tektoncd/operator){: target=_blank} and the README.md file contains the install instructions:

```shell
kubectl apply -f https://storage.googleapis.com/tekton-releases/operator/latest/release.yaml
kubectl apply -f https://raw.githubusercontent.com/tektoncd/operator/main/config/crs/kubernetes/config/all/operator_v1alpha1_config_cr.yaml
```

!!!Warning
    This process will not work as the OpenShift Security Context will not permit the Tekton operator to run as a specific user

!!!Todo
    Build operator from [RedHat source repo](https://github.com/openshift/tektoncd-operator){: target=_blank}

## Tekton Hub

There is a [community hub](https://hub.tekton.dev/){: target=_blank} of tasks available, which is the source of the content installed by the OpenShift Pipelines operator.  The hub allows you to search for tasks then provides the command to install the task to your cluster.
