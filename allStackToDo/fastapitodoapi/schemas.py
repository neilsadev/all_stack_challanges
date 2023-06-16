from pydantic import BaseModel


class TodoCreate(BaseModel):
    title: str


class TodoUpdate(BaseModel):
    title: str
    completed: bool


class TodoInDB(BaseModel):
    id: int
    title: str
    completed: bool

    class Config:
        orm_mode = True
