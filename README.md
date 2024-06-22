# MLOps
Simple modern open source mlops.
Set of core tools that can be reused across projects.

### Requirements for modern mlops
- Free and open source
- Simple to deploy

### Components
- [x] Data stores (MinIO / PostgreSQL)
- [x] Vector Store (Milvus)
- [x] Data labeller (Label Studio)
- [x] Experiment Tracking (MLflow)
- [x] LLM Observability (Langfuse)
- [x] Admin Tools 
    - pgAdmin: postgreSQL 
    - attu: Milvus

### Design
![Alt text](assets/mlops.png)

### Setup .env file
```
POSTGRES_DATABASE=postgres
POSTGRES_HOST=postgres
POSTGRES_PASSWORD=password
POSTGRES_PORT=5432
POSTGRES_USER=postgres

PGADMIN_DEFAULT_EMAIL=admin@pgadmin.com
PGADMIN_DEFAULT_PASSWORD=password

MINIO_ROOT_USER=minio
MINIO_ROOT_PASSWORD=password

```

### Run locally
```
docker-compose up -d
```

### Roadmap
- [ ] Minikube / kind setup

### Resources:
- [PostgreSQL docker documentation](https://hub.docker.com/_/postgres/)
- [pgAdmin docker documentation](https://www.pgadmin.org/docs/pgadmin4/8.8/container_deployment.html)
- [Label studio docker compose](https://labelstud.io/tutorials/segment_anything_model#Using-Docker-Compose-recommended)
- [MLflow docker image](https://github.com/mlflow/mlflow/pkgs/container/mlflow)
- [Langfuse repo](https://github.com/langfuse/langfuse)

### Clunky aspects
- MLflow: image does not contain psycopg2. Workaround of running `pip install psycopg2` prior to launching server.
- postgreSQL: Setting up multiple databases. Mounting init-db.sql to docker-entrypoint-initdb.d folder which is automatically run only if postgres volume is empty.
- MinIO: separate container created to create bucket for MLflow
- Langfuse: no official image for arm

### Troubleshooting
- #### Deploy resources:
    - Docker compose has been setup with minimum specs for my local
    - May run into out of memory exceptions. Single workers may cause crashing. Consider increasing cpu ,memory and workers.
    - Remove deploy section under each service as a quick workaround