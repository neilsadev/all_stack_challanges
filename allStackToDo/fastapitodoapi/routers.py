from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from database import get_database
from models import Todo
from schemas import TodoCreate, TodoUpdate, TodoInDB

router = APIRouter()


@router.get("/todos", response_model=list[TodoInDB])
def get_todos(db: Session = Depends(get_database)):
    todos = db.query(Todo).all()
    return todos


@router.post("/todos", response_model=TodoInDB)
def create_todo(todo: TodoCreate, db: Session = Depends(get_database)):
    todo_obj = Todo(title=todo.title, completed=False)
    db.add(todo_obj)
    db.commit()
    db.refresh(todo_obj)
    return todo_obj


@router.put("/todos/{todo_id}", response_model=TodoInDB)
def update_todo(todo_id: int, todo: TodoUpdate, db: Session = Depends(get_database)):
    todo_obj = db.query(Todo).filter(Todo.id == todo_id).first()
    if not todo_obj:
        raise HTTPException(status_code=404, detail="Todo not found")
    todo_obj.title = todo.title
    todo_obj.completed = todo.completed
    db.commit()
    db.refresh(todo_obj)
    return todo_obj


@router.delete("/todos/{todo_id}")
def delete_todo(todo_id: int, db: Session = Depends(get_database)):
    todo_obj = db.query(Todo).filter(Todo.id == todo_id).first()
    if not todo_obj:
        raise HTTPException(status_code=404, detail="Todo not found")
    db.delete(todo_obj)
    db.commit()
    return {"message": "Todo deleted"}


@router.delete("/todos")
def delete_all_todos(db: Session = Depends(get_database)):
    db.query(Todo).delete()
    db.commit()
    return {"message": "All todos deleted"}
