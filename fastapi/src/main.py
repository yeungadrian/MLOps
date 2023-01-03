import logging

import yaml
from dotenv import load_dotenv

with open("logging.yml", "r") as stream:
    config = yaml.load(stream, Loader=yaml.FullLoader)
    
logging.config.dictConfig(config)

load_dotenv()

from fastapi import FastAPI  # noqa
from src.api.api import api_router  # noqa

tags_metadata = [
    {
        "name": "Tabular",
        "description": "Tabular ML Models",
    },
]

app = FastAPI(openapi_tags=tags_metadata)

app.include_router(api_router)
