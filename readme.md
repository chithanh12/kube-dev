## Install minikube
```
brew install minikube
```

## Install argocd 
1. Start your minikube cluster & wait few minutes to check it already started
```
minikube start
```

View minikube status:
```
[0] % minikube status

minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

2. Create a new namespace 

```
kubectl create namespace argocd
```

3. Install argocd by using helm chart

```
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

4. Get default admin password

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d;
```

5. Edit the argocd server to run without TLS
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

6. Expose the argocd to localhost

```
kubectl port-forward svc/argocd-server -n argocd 8085:443
```
They you can access the ArgoCD UI by open browser at : `http://localhost:8085` by using the password got above

7. Add SSH to github to make sure 

## Install Kong gateway 
1. Firstly, Create an ingress namespace and we will install our Kong Gateway into this namespace.
```
kubectl create namespace ingress
```

2. Secondly, download all the dependencies by using
```
 helm dependency build ./local-cluster/kong
```

3. Thirdly, install Kong by using helm with the default value 
```
helm -n ingress install -f ./local-cluster/kong/values.yaml kong ./kong   
```

4. Next. export Kong proxy to your host to test your service by using the following command:
```
minikube service -n ingress kong-proxy --url | head -1
```

The output is similar this:
```
[0] % minikube service -n ingress kong-proxy --url | head -1
http://127.0.0.1:64191
❗  Because you are using a Docker driver on darwin, the terminal needs to be open to run it.
```
| Note: Remember the port from the output because we will use it later.

5. In additional, you can review what exactly helm install by using the helm dry-run for above command:
```
helm -n ingress install -f ./local-cluster/kong/values.yaml test ./kong --dry-run --debug
```

## Visual your minikube with dashboard
You can easily manage your cluster with a built in dashboard installed in minikube (like Rancher) by the command:
```
minikube dashboard
```
