# MLOps
Simple open source MLOps with docker compose.

## Design
![Alt text](assets/mlops.png)

## Applications
- [PostgreSQL (SQL)](https://github.com/postgres/postgres)
- [MinIO (object storage)](https://github.com/minio/minio)
- [Qdrant (vector search)](https://github.com/qdrant/qdrant)
- [Label Studio (data annotation)](https://github.com/HumanSignal/label-studio)
- [MLflow (experiment tracking & model registry)](https://github.com/mlflow/mlflow)
- [Langfuse (LLM observability)](https://github.com/langfuse/langfuse)

## Getting started
This setup requires docker and docker compose. The easiest way to get started is to install [docker desktop](https://docs.docker.com/desktop/install/mac-install/).

Create a .env file with the following keys. Values below are only placeholders and can be freely changed.
```
POSTGRES_DATABASE=postgres
POSTGRES_HOST=postgres
POSTGRES_PASSWORD=password
POSTGRES_PORT=5432

MINIO_ROOT_USER=minio
MINIO_ROOT_PASSWORD=password
```

Now run the following command:
```
docker-compose up -d
```

Once the applications have started and are ready, you can access them on the following urls:
- MLflow: [http://localhost:5001](http://localhost:5001)
- MinIO: [http://localhost:9001](http://localhost:9001)

## Updating images
The following commands will stop the containers, update images if new versions have been published and redeploy containers.
```
docker-compose stop
docker-compose pull
docker-compose up -d
```




## List of components
- PostgreSQL: [repo (mirror)](https://github.com/postgres/postgres)
- MinIO: [repo](https://github.com/minio/minio)
- Qdrant: [repo](https://github.com/qdrant/qdrant)
- Label Studio: [repo](https://github.com/HumanSignal/label-studio)
- MLflow: [repo](https://github.com/mlflow/mlflow)
- Langfuse: [repo](https://github.com/langfuse/langfuse)

## Clunky aspects
- MLflow: no official image containing psycopg2. Workaround of running `pip install psycopg2` prior to launching server. (Not enough benefits to create custom image).
- postgreSQL: Setting up databases per application. Mounting init-db.sql to docker-entrypoint-initdb.d folder which is automatically run only if postgres volume is empty. (Run commands in pgAdmin)
- Langfuse: no official image for arm. (works fine for now)

## Troubleshooting
- Insufficient resources
    - Docker compose has been setup with minimum specs for my setup
    - Potential to run into out of memory exceptions on different setups / with newer version.
    - Remove deploy section under each service as a quick workaround
- Latest version may introduce breaking changes
    - Images all currently point at the latest version of each service, which may require additional changes not present yet.
