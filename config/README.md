# Kubernetes YAML Files

These files are used to deploy the Nodejs app.

The Deployment uses the local Image with tag `myapp:latest`. If the Nodejs app
was not built locally with the tag `myapp:latest`, then the Deployment will
fail.

## Build and run the Nodejs app using Kubernetes

Follow the instructions in the [tekton/](tekton/README.md) directory to build
and run the Nodejs app using a cloud native Tekton Pipeline.

If you do not want to use a Tekton Pipeline to build and run the app, then
execute the following in your cluster:

```bash
docker build -t myapp:latest .
kubectl apply -f config/
```

Open [http://localhost:3000/](http://localhost:3000/) in your web browser to
view the running app.

*If your Kubernetes environment does not support LoadBalancer services, then
change the Service type in the [service.yaml](https://github.com/ncskier/myapp/blob/master/config/service.yaml#L9) file.*
