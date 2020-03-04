# Tekton CI/CD on OpenShift

The [Tekton Pipelines](https://github.com/tektoncd/pipeline) project provides
Kubernetes-style resources for declaring CI/CD-style pipelines.

## Build and run Nodejs app on OpenShift using a cloud native Tekton Pipeline

### Install Tekton Pipelines on your OpenShift environment

```bash
oc apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
```

If you would like more detailed install instructions, or if you are installing
on OpenShift, then read [these instructions](https://github.com/tektoncd/pipeline/blob/master/docs/install.md#installing-tekton-pipelines) from the Tekton Pipelines documentation.

### Install the Tekton resources on your OpenShift environment

The Tekton resources are in this `openshift/tekton/` directory.

```bash
oc apply -f openshift/tekton/
```

#### (Optional) You might need to give your ServiceAccount the proper permissions

```bash
cat << EOF | oc apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: default
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
EOF
```

### Run the Tekton Pipeline

Run the Pipeline by creating a PipelineRun resource such as the following:

```bash
NAMESPACE=myapp
cat << EOF | oc apply -f -
apiVersion: tekton.dev/v1alpha1
kind: PipelineRun
metadata:
  name: myapp-openshift
spec:
  pipelineRef:
    name: myapp-openshift
  resources:
    - name: source
      resourceSpec:
        type: git
        params:
          - name: revision
            value: master
          - name: url
            value: https://github.com/ncskier/myapp
    - name: image
      resourceSpec:
        type: image
        params:
          - name: url
            value: image-registry.openshift-image-registry.svc:5000/${NAMESPACE}/myapp:latest
EOF
```

### View the deployed Nodejs app

Get the URL for your route with `oc get route myapp`, and open the route URL in your web browser.

If you would like to view the PipelineRun logs, then read [these instructions](https://github.com/tektoncd/pipeline/blob/master/docs/logs.md) from the Tekton Pipelines
documentation.
