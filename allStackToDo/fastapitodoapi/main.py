from fastapi import FastAPI
from app import create_app

app = FastAPI()
app = create_app()
