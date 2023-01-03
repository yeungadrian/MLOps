import logging
from typing import Any

import mlflow
import numpy as np
from fastapi import APIRouter, HTTPException

from src.api.schemas import Iris, IrisPrediction

router = APIRouter()

iris_map = {0: "setosa", 1: "versicolor", 2: "virginica"}

logging.info("Loading iris classification model")
import os
print(os.environ.get("AWS_ACCESS_KEY_ID"))
model = mlflow.sklearn.load_model("models:/iris_classifer/Production")


@router.post(
    "/",
    tags=["Tabular"],
    response_model=IrisPrediction,
    summary="Predict species of iris flower",
)
async def classify_iris(item: Iris) -> Any:
    """
    Classify iris flower type based off sepal and petal dimensions
    """
    logging.info("Preprocessing input")
    sepal_length = item.dict()["sepal_length"]
    sepal_width = item.dict()["sepal_width"]
    petal_length = item.dict()["petal_length"]
    petal_width = item.dict()["petal_width"]
    input = np.array(
        [sepal_length, sepal_width, petal_length, petal_width]
    ).reshape(-1, 4)
    logging.info("Running prediction of iris type")
    try:
        pred = int(model.predict(input)[0])
        species = iris_map[pred]
    except Exception:
        logging.error("Error while making prediction")
        raise HTTPException(
            status_code=404, detail="Error while making prediction"
        )
    return {"species": species}
