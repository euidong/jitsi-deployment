# Jitsi Meet

Scalable video conferencing on Kubernetes.

## Run

```bash
# gen secrets
./secrets.sh .env production

```

```bash
# install add-on
kubectl create -k overlays/addon
# or
kubectl apply -k https://github.com/metacontroller/metacontroller/manifests/production
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.6.0/cert-manager.yaml
kubectl -n kube-system apply -f https://github.com/emberstack/kubernetes-reflector/releases/latest/download/reflector.yaml
kubectl -n kube-system apply -f https://github.com/prometheus-operator/prometheus-operator/releases/latest/download/bundle.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.5/deploy/static/provider/cloud/deploy.yaml
```

```bash
# gcloud setting
kubectl apply -f gke/compute-address.yaml

# run jitsi code
kubectl create namespace jitsi
kubectl apply -k overlays/production



# run jitsi loadbalancer
kubectl apply -k base/ops/ingress-nginx
kubectl apply -k overlays/production-loadbalancer

```

```bash
# dashboard
kubectl apply -k base/ops/monitoring/dashboard

# get token
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

# run server
kubectl proxy
```

```bash
# install prometheus operator
# refer prometheus-operator
kubectl create -f base/ops/prometheus-operator/prometheus-operator.yaml

# run monitor code
kubectl apply -k overlays/production-monitoring
```
