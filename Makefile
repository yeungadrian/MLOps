deploy-cluster:
	kind create cluster --name local-dev --config k8s-cluster-config.yaml

delete-cluster:
	kind delete cluster --name local-dev

upload-prefect-image:
	docker build ./prefect -t prefect
	kind load --name local-dev docker-image prefect:latest	

setup-prefect-ns:
	kubectl create namespace prefect
	kubectl create secret generic prefect --from-env-file=.env  -n prefect	

deploy-prefect:
	make setup-prefect-ns
	make upload-prefect-image
	kubectl apply -f prefect/orion.yaml

undeploy-prefect:
	kubectl delete deployment prefect-agent
	kubectl delete namespace prefect

# loads the image and installs the service with overrides
deploy-argo:
	@helm install argo-workflows ./charts/argo-workflows
	kubectl port-forward deployment/argo-workflows-server 2746:2746

undeploy-argo:
	helm delete argo-workflows

# deletes all the services and k8s cluster
delete-all:
	helm delete $(shell helm list -aq)
	kind delete cluster --name local-dev 

node_port=$(shell kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services argo-workflows)
node_ip=$(shell kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")

# returns the node url to access from external world	
node-url:
	@echo "http://${node_ip}:${node_port}" 
	@ echo "[[ NOTE: If using macOS, use http://localhost:8080 , made possible by k8s-cluster-config.yaml extraPortMappings ]]"

status:
	@kubectl get pods

poetry-packages-file:
	poetry export -f requirements.txt --without-hashes > ./fastapi/requirements.txt