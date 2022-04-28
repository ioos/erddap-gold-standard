---
title: "Kubernetes ERDDAP deployment"
keywords: kubernetes
tags: [kubernetes]
toc: true
summary: How-to deploy ERDDAP on Kubernetes.
---

# Kubernetes development for ERDDAP (as of 2.18 and the 2022 IOOS Code Sprint)

Assuming you've performed the [Docker installation of ERDDAP](), start by [installing Minikube](https://minikube.sigs.k8s.io/docs/start/).

We will be generating what can be called 'manifest' files for a Kubernetes pod that will contain the ERDDAP instance. The manifest will need to reference the docker-erddap image from a registry. In this case, the registry will reside locally. [Follow this guide precisely](https://hasura.io/blog/sharing-a-local-registry-for-minikube-37c7240d0615/). [Be sure to grab the latest version](https://gist.github.com/coco98/b750b3debc6d517308596c248daf3bb1) of the `kube-registry.yaml` file, and edit as necessary to be compliant with the latest kubernetes APIs. 

*If you are using Linux*, there are a couple of commands that will need to be executed to avoid having to run Docker as root:

```shell
sudo usermod -aG docker $USER && newgrp docker
sudo chmod 0777 /var/run/docker.sock
```

With Minikube installed:

```shell
minikube start
```

Once that is booted:

```shell
kubectl create -f ./kube-registry.yaml` # Had to change `DaemonSet` `apiVersion` to `apps/v1` as of 2022/04/28
kubectl get pods -A
kubectl port-forward --namespace kube-system kube-registry-xx-xxxxx 5001:5000 # Check pod ID. Check ports too
sudo ss -lptn 'sport = :5000' # Way to check ports, correct the above command as necessary, I went with port 5001
```

Make a new terminal. Associate Docker with Minikube and the registry, pull in the Docker ERDDAP image

```shell
eval $(minikube -p minikube docker-env)
docker pull axiom/docker-erddap
docker tag axiom/docker-erddap:latest localhost:5001/axiom/docker-erddap:latest
```

As we've been using Docker Compose, there's an app called [Kompose that should be installed.](https://kubernetes.io/docs/tasks/configure-pod-container/translate-compose-kubernetes/) This will enable the generation of Kubernetes manifests to establish an ERDDAP Kubernetes pod. For the mounts to local files, we'll want a type of `hostPath`:

```shell
kompose convert --volumes hostPath
```
If things went alright, two files should have been generated, and should be referenced in a file named `kustomization.yaml`:

```yaml
resources:
  - erddap-service.yaml
  - erddap-deployment.yaml
```

Working from the project directory, you can change the main directory of minikube via, for example:

```shell
minikube mount /home/jpthesmithe/Desktop/GLOS_System_Map/erddap-code-sprint/erddap-gold-standard:/erddap-gold-standard
```

Correct the `erddap-deployment.yaml` file to read something like:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    kompose.cmd: kompose convert --volumes hostPath
    kompose.version: 1.26.0 (40646f47)
  creationTimestamp: null
  labels:
    io.kompose.service: erddap
  name: erddap
spec:
  replicas: 1
  selector:
    matchLabels:
      io.kompose.service: erddap
  strategy:
    type: Recreate
  template:
    metadata:
      annotations:
        kompose.cmd: kompose convert --volumes hostPath
        kompose.version: 1.26.0 (40646f47)
      creationTimestamp: null
      labels:
        io.kompose.service: erddap
    spec:
      containers:
        - env:
            - name: ERDDAP_MAX_MEMORY
              value: 2G
            - name: ERDDAP_MIN_MEMORY
              value: 1G
          image: axiom/docker-erddap:2.18
          name: erddap-gold-standard
          ports:
            - containerPort: 8080
          resources: {}
          volumeMounts:
            - mountPath: /usr/local/tomcat/bin/config.sh
              name: erddap-hostpath0
            - mountPath: /usr/local/tomcat/webapps/ROOT/robots.txt
              name: erddap-hostpath1
            - mountPath: /usr/local/tomcat/content/erddap/
              name: erddap-hostpath2
            - mountPath: /erddapData/
              name: erddap-hostpath3
            - mountPath: /datasets/
              name: erddap-hostpath4
            - mountPath: /usr/local/tomcat/temp/
              name: erddap-hostpath5
      restartPolicy: Always
      volumes:
        - hostPath:
            path: /erddap-gold-standard/erddap/conf/config.sh
          name: erddap-hostpath0
        - hostPath:
            path: /erddap-gold-standard/erddap/conf/robots.txt
          name: erddap-hostpath1
        - hostPath:
            path: /erddap-gold-standard/erddap/content/
            type: Directory
          name: erddap-hostpath2
        - hostPath:
            path: /erddap-gold-standard/erddap/data/
            type: Directory
          name: erddap-hostpath3
        - hostPath:
            path: /erddap-gold-standard/datasets/
            type: Directory
          name: erddap-hostpath4
        - hostPath:
            path: /tmp/
            type: Directory
          name: erddap-hostpath5
status: {}
```

Make a new terminal. Then:

```shell
kubectl apply -k ./
kubectl get pods
kubectl port-forward erddap-7c94b648f8-ljxhs 8080:8080 # Correct to the appropriate pod name
```

[localhost should have it](http://localhost:8080/erddap/index.html). You may need to use `kubectl describe pod [pod name]` to diagnose problems

## Future work

From here, with a successful local development environment, we can interact with the `datasets.xml` file via commands like `kubectl cp` ([ref](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#cp)) or get into the container itself via `kubectl exec` ([ref](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec)). In deploying this to a live Kubernetes cluster, arrangements should be made to replace the `hostpath`s with [better volume types](https://kubernetes.io/docs/concepts/storage/volumes/) and transferring the files to those, hopefully persistent, volumes. Service accounts and load balancers are also to be considered.
