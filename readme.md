## Install minikube
```
brew install minikube
```

## Install argocd 
1. Create a new namespace 

```
kubectl create namespace argocd
```

2. Install argocd by using helm chart

```
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

3. Get default admin password

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d;
```

4. Edit the argocd server to run without TLS
+ Running bellow statement: 

```
kubectl -nargocd edit configmap argocd-cmd-params-cm
```

+ Add the following data then save and rollout the argocd-server again.
```
data:
    server.insecure: "true"
```
+ Restart the argocd server

```
kubectl -nargocd rollout restart deployment argocd-server
```

5. Expose the argocd to localhost

```
kubectl port-forward svc/argocd-server -n argocd 8085:443
```
They you can access the ArgoCD UI by open browser at : `http://localhost:8085` by using the password got above

6. Add SSH to github to make sure 

## Install Kong gateway 
1. Firstly, Create an ingress namespace and we will install our Kong Gateway into this ns.
```
kubectl create namespace ingress
```

2. Secondly, you need to download all the dependencies by using
```
 helm dependency build
```

3. Thirdly, you install Kong by using helm with the default value 
```
helm -n ingress install -f ./local-cluster/kong/values.yaml kong ./kong   
```

4. Export Kong proxy to your host to test your service by using the following command:
```
minikube service -n ingress kong-proxy --url | head -1
```

5. In additional, you can review what exactly helm install by using the helm dry-run for above command:
```
helm -n ingress install -f ./local-cluster/kong/values.yaml test ./kong --dry-run --debug
```

## Visual your minikube with dashboard
You can easily manage your cluster with a built in dashboard installed in minikube (like Rancher) by the command:
```
minikube dashboard
```
