import { useEffect, useState } from "react";

const apiBase = "http://localhost:3001";

function App() {
  // State variables
  const [todos, setTodos] = useState([]); // Holds the list of todos
  const [popupActive, setPopupActive] = useState(false); // Controls the visibility of the popup
  const [newTodo, setNewTodo] = useState(""); // Holds the text for a new todo

  useEffect(() => {
    // Fetch todos when the component mounts
    getTodos();
  }, []);

  const getTodos = () => {
    // Fetch todos from the API
    fetch(apiBase + "/todos")
      .then((res) => {
        if (!res.ok) {
          throw new Error("Failed to fetch todos");
        }
        return res.json();
      })
      .then((data) => setTodos(data))
      .catch((err) => console.error("Error:", err.message));
  };

  const completeTodo = async (id) => {
    try {
      // Update the completion status of a todo
      const response = await fetch(apiBase + "/todos/" + id, {
        method: "PUT",
      });

      if (!response.ok) {
        throw new Error("Failed to complete todo");
      }

      const data = await response.json();

      setTodos((todos) =>
        todos.map((todo) => {
          if (todo._id === data._id) {
            todo.complete = data.complete;
          }
          return todo;
        })
      );
    } catch (error) {
      console.error("Error:", error.message);
    }
  };

  const addTodo = async () => {
    try {
      // Add a new todo
      const response = await fetch(apiBase + "/todos", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          text: newTodo,
        }),
      });

      if (!response.ok) {
        throw new Error("Failed to add todo");
      }

      const data = await response.json();

      setTodos([...todos, data]);
      setPopupActive(false);
      setNewTodo("");
    } catch (error) {
      console.error("Error:", error.message);
    }
  };

  const deleteTodo = async (id) => {
    try {
      // Delete a todo
      const response = await fetch(apiBase + "/todos/" + id, {
        method: "DELETE",
      });

      if (!response.ok) {
        throw new Error("Delete request failed");
      }

      const data = await response.json();

      setTodos((todos) => todos.filter((todo) => todo._id !== data?._id));
    } catch (error) {
      console.error("Error deleting todo:", error);
      // Handle the error as needed
    }
  };

  return (
    <div className="App">
      <h1>Welcome, Tyler</h1>
      <h4>Your tasks</h4>

      <div className="todos">
        {todos.length > 0 ? (
          todos.map((todo) => (
            <div
              className={"todo" + (todo.complete ? " is-complete" : "")}
              key={todo._id}
              onClick={() => completeTodo(todo._id)}
            >
              <div className="checkbox"></div>
              <div className="text">{todo.text}</div>
              <div className="delete-todo" onClick={() => deleteTodo(todo._id)}>
                x
              </div>
            </div>
          ))
        ) : (
          <p>You currently have no tasks</p>
        )}
      </div>

      <div className="addPopup" onClick={() => setPopupActive(true)}>
        +
      </div>

      {popupActive && (
        <div className="popup">
          <div className="closePopup" onClick={() => setPopupActive(false)}>
            X
          </div>
          <div className="content">
            <h3>Add Task</h3>
            <input
              type="text"
              className="add-todo-input"
              onChange={(e) => setNewTodo(e.target.value)}
              value={newTodo}
            />
            <div className="button" onClick={addTodo}>
              Create Task
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

export default App;
