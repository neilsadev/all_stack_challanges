from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from dotenv import dotenv_values

config = dotenv_values(".env")
database_url = config.get("DATABASE_URL")

engine = create_engine(database_url)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


def get_database():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
