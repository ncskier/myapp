# Tekton CI/CD

The [Tekton Pipelines](https://github.com/tektoncd/pipeline) project provides
Kubernetes-style resources for declaring CI/CD-style pipelines.

## Build and run Nodejs app on Kubernetes using a cloud native Tekton Pipeline

### Install Tekton Pipelines on your Kubernetes environment

```bash
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
```

If you would like more detailed install instructions, or if you are installing
on OpenShift, then read [these instructions](https://github.com/tektoncd/pipeline/blob/master/docs/install.md#installing-tekton-pipelines) from the Tekton Pipelines documentation.

### Install the Tekton resources on your Kubernetes environment

The Tekton resources are in this `tekton/` directory.

```bash
kubectl apply -f tekton/
```

### Run the Tekton Pipeline

Run the Pipeline by creating a PipelineRun resource such as the following:

```bash
cat << EOF | kubectl apply -f -
apiVersion: tekton.dev/v1alpha1
kind: PipelineRun
metadata:
  name: myapp
spec:
  pipelineRef:
    name: myapp
  resources:
    - name: source
      resourceSpec:
        type: git
        params:
          - name: revision
            value: master
          - name: url
            value: https://github.com/ncskier/myapp
EOF
```

### View the deployed Nodejs app

Open [http://localhost:3000/](http://localhost:3000/) in your web browser.

If you would like to view the PipelineRun logs, then read [these instructions](https://github.com/tektoncd/pipeline/blob/master/docs/logs.md) from the Tekton Pipelines
documentation.

*If your Kubernetes environment does not support LoadBalancer services, then
change the Service type in the [service.yaml](https://github.com/ncskier/myapp/blob/master/config/service.yaml#L9) file.*
