```
kubectl create configmap docker-demo-env-file --from-env-file=docker-demo-env-file.properties -n projeta-int-default-ns
kubectl apply -f docker-demo-config-map.yaml -n projeta-int-default-ns
kubectl exec docker-demo-69644cdc8d-2gr7x env
kubectl exec docker-demo-69644cdc8d-2gr7x sh
wget -qO- http://localhost:8080/ping
{"instance":"docker-demo-69644cdc8d-2gr7x","version":"1.0-config-map"}
kubectl apply -f docker-demo-service-ClusterIP.yaml
kubectl apply -f docker-demo-ingress.yaml 
```