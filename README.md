# MLOps
Simple modern open source mlops.

## Design
![Alt text](assets/mlops.png)

## Applications
- Data storage (MinIO & PostgreSQL)
- Vector store (Milvus)
- Data labeller (Label Studio)
- Experiment Tracking (MLflow)
- LLM Observability (Langfuse)
- Admin Tools:
    - pgAdmin: PostgreSQL
    - Attu: Milvus

## Getting started
This setup requires docker and docker compose. The easiest way to get started is to install [docker desktop](https://docs.docker.com/desktop/install/mac-install/).

Create a .env file with the following keys. Values below are only placeholders.
```
POSTGRES_DATABASE=postgres
POSTGRES_HOST=postgres
POSTGRES_PASSWORD=password
POSTGRES_PORT=5432

PGADMIN_DEFAULT_EMAIL=admin@pgadmin.com
PGADMIN_DEFAULT_PASSWORD=password

MINIO_ROOT_USER=minio
MINIO_ROOT_PASSWORD=password
```

Now run the following command:
```
docker-compose up -d
```

Once the applications have started and are ready, you can access the applications on the following urls:
- pgAdmin: [http://localhost:15432](http://localhost:15432)
- MLflow: [http://localhost:5001](http://localhost:5001)
- MinIO: [http://localhost:9001](http://localhost:9001)
- Label Studio: [http://localhost:8080](http://localhost:8080)
- Attu: [http://localhost:8099](http://localhost:8000)

## Updating images
The following commands will stop the containers, update images if new versions have been published and redeploy containers.
```
docker-compose stop
docker-compose pull
docker-compose up -d
```

## Roadmap
- [ ] Minikube / kind setup

## Resources
### Docker
- [PostgreSQL docker documentation](https://hub.docker.com/_/postgres/)
- [MinIO dockerhub](https://hub.docker.com/r/minio/minio/#!)
- [Milvus docker compose](https://milvus.io/docs/install_standalone-docker-compose.md)
- [Label Studio docker compose](https://labelstud.io/tutorials/segment_anything_model#Using-Docker-Compose-recommended)
- [MLflow docker image](https://github.com/mlflow/mlflow/pkgs/container/mlflow)
- [Langfuse repo](https://github.com/langfuse/langfuse)
- [pgAdmin docker documentation](https://www.pgadmin.org/docs/pgadmin4/8.8/container_deployment.html)
- [Attu github](https://github.com/zilliztech/attu)
### Kubernetes
TODO

## Troubleshooting
- Insufficient resources
    - Docker compose has been setup with minimum specs for my setup
    - Potential to run into out of memory exceptions on different setups / with newer version.
    - Remove deploy section under each service as a quick workaround
- Latest version may introduce breaking changes
    - Images all currently point at the latest version of each service, which may require additional changes not present yet.

## Clunky aspects
- MLflow: no official image containing psycopg2. Workaround of running `pip install psycopg2` prior to launching server. (Not enough benefits to create custom image).
- postgreSQL: Setting up multiple databases. Mounting init-db.sql to docker-entrypoint-initdb.d folder which is automatically run only if postgres volume is empty.
- Langfuse: no official image for arm.

## List of dependencies
- PostgreSQL: [repo (mirror)](https://github.com/postgres/postgres)
- MinIO: [repo](https://github.com/minio/minio)
- Milvus: [repo](https://github.com/milvus-io/milvus)
- Label Studio: [repo](https://github.com/HumanSignal/label-studio)
- MLflow: [repo](https://github.com/mlflow/mlflow)
- Langfuse: [repo](https://github.com/zilliztech/attu)
- pgAdmin: [repo](https://github.com/pgadmin-org/pgadmin4)
- Attu: [repo](https://github.com/zilliztech/attu)
