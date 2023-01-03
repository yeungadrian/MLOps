from fastapi import APIRouter

from src.api.endpoints import iris

api_router = APIRouter()

api_router.include_router(iris.router, prefix="/iris")
