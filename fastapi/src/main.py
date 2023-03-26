import logging

import yaml
from dotenv import load_dotenv
from prometheus_fastapi_instrumentator import Instrumentator

with open("logging.yml", "r") as stream:
    config = yaml.load(stream, Loader=yaml.FullLoader)

logging.config.dictConfig(config)

load_dotenv()


from src.api.api import api_router  # noqa

from fastapi import FastAPI  # noqa

tags_metadata = [
    {
        "name": "Tabular",
        "description": "Tabular ML Models",
    },
]

app = FastAPI(openapi_tags=tags_metadata)

app.include_router(api_router)

Instrumentator().instrument(app).expose(app)
