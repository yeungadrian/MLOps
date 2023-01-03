from enum import Enum

from pydantic import BaseModel


class IrisSpecies(str, Enum):
    setosa = "setosa"
    versicolor = "versicolor"
    virginica = "virginica"


class Iris(BaseModel):
    sepal_length: float
    sepal_width: float
    petal_length: float
    petal_width: float

    class Config:
        schema_extra = {
            "example": {
                "sepal_length": 5.9,
                "sepal_width": 3.0,
                "petal_length": 4.2,
                "petal_width": 1.5,
            }
        }


class IrisPrediction(BaseModel):
    species: IrisSpecies
