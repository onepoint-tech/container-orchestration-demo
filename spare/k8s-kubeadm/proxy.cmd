more generated-conf\admin-user-token.txt

@echo http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy

kubectl --kubeconfig ./generated-conf/admin.conf proxy
