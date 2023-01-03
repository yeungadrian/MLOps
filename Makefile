deploy-cluster:
	kind create cluster --name local-dev --config k8s-cluster-config.yaml

delete-cluster:
	kind delete cluster --name local-dev

# deletes all the services and k8s cluster
delete-all:
	helm delete $(shell helm list -aq)
	kind delete cluster --name local-dev 

# loads the image and installs the service with overrides
deploy:
	@helm install argo-workflows ./charts/argo-workflows
	kubectl port-forward deployment/argo-workflows-server 2746:2746


undeploy:
	helm delete argo-workflows

node_port=$(shell kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services argo-workflows)
node_ip=$(shell kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")

# returns the node url to access from external world	
node-url:
	@echo "http://${node_ip}:${node_port}" 
	@ echo "[[ NOTE: If using macOS, use http://localhost:8080 , made possible by k8s-cluster-config.yaml extraPortMappings ]]"

status:
	@kubectl get pods
