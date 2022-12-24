deploy-cluster:
	kubectl create namespace argo
	kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.3.10/install.yaml

argo-patch:
	kubectl patch deployment \
	argo-server \
	--namespace argo \
	--type='json' \
	-p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [ \
	"server", \
	"--auth-mode=server" \
	]}]' \

argo-port-forward:
	kubectl -n argo port-forward deployment/argo-server 2746:2746

# deletes all the services and k8s cluster
delete-all:
	helm delete $(shell helm list -aq)
	kind delete cluster --name local-dev 

build-image:
	docker build . -t model-serve

# Load image to local kind registry
upload-image:
	kind load --name local-dev docker-image model-serve:latest

# loads the image and installs the service with overrides
deploy:
	make upload-image
	@helm install argo-workflows ./argo-workflows

undeploy:
	helm delete model-serve

node_port=$(shell kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services argo-workflows)
node_ip=$(shell kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")

# returns the node url to access from external world	
node-url:
	@echo "http://${node_ip}:${node_port}" 
	@ echo "[[ NOTE: If using macOS, use http://localhost:8080 , made possible by k8s-cluster-config.yaml extraPortMappings ]]"

status:
	@kubectl get pods
