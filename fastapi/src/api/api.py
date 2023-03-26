from src.api.endpoints import iris

from fastapi import APIRouter

api_router = APIRouter()

api_router.include_router(iris.router, prefix="/iris")
