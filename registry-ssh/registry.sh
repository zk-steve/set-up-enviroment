helm repo add twuni https://helm.twun.io
helm repo update
helm install docker-registry twuni/docker-registry --set service.nodePort=30500,service.type=NodePort
