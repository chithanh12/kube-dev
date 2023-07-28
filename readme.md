## Install minikube
```brew install minikube```

## Install argocd 
1. Create a new namespace 
```kubectl create namespace argocd```

2. Install argocd by using helm chart
```kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml```

3. Get default admin password
```kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo```

4. Edit the argocd server to run without TLS
 Running bellow statement: 
```kubectl -nargocd edit configmap argocd-cmd-params-cm```

Add the following data then save and rollout the argocd-server again.
```
data:
    server.insecure: "true"
```
Restart the argocd server
```kubectl -nargocd rollout restart deployment argocd-server```

5. Expose the argocd to localhost
```kubectl port-forward svc/argocd-server -n argocd 8080:443```

## Install Kong gateway 
