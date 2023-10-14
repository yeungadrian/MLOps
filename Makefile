pre-commit:
	pre-commit run --show-diff-on-failure --color=always --all-files

deploy-all:
	docker compose -f docker-compose.milvus.yaml -f docker-compose.label.yaml up -d

deploy-all:
	docker compose -f docker-compose.yaml up -d --build

fix-label-studio:
	sudo chmod -R 777 mydata/
