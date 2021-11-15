```bash
# gen secrets
./secrets.sh .env production

# install add-on
kubectl create -k overlays/addon

# run jitsi code
kubectl apply -k overlays/production

# run jitsi loadbalancer
kubectl apply -k overlays/production-loadbalancer

```

```bash
# dashboard
kubectl apply -k base/ops/dashboard

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
