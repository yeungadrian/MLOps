# mlops
Simple modern mlops for individuals

### Requirements for modern mlops
- Free and open source
- Simple to deploy

### Components
- [x] Data Store (Minio / PostgreSQL / Feast?) 
- [x] Experiment Tracking (MLFlow) https://mlflow.org/docs/latest/tracking.html#amazon-s3-and-s3-compatible-storage
- [x] Workflow & Dataflow (Prefect)
- [ ] Model Serving (FastAPI? / Seldon?)

### Architecture
![Alt text](architecture.png)

### Requirements:
- Docker
- Change .env_template to .env and use your own secrets

### Commands to run 

```
docker-compose up --build
```

Manually create mlflow bucket in mlflow at localhost:5001

### Limitations
- Question mark on docker-compose for production
- Use docker swarm or k8s instead

### Roadmap
- [x] Move secrets to .env
- [ ] Feast
- [ ] MLServer
- [ ] More complex k8s setup
- [ ] Cloud provider, e.g. GCP