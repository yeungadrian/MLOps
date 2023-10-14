pre-commit:
	pre-commit run --show-diff-on-failure --color=always --all-files

compose:
	docker compose -f docker-compose.yaml up -d --build

fix-label-studio:
	sudo chmod -R 777 mydata/
