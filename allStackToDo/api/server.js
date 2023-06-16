import express from "express"; // Importing the express module
import mongoose from "mongoose"; // Importing the mongoose module
import cors from "cors"; // Importing the cors module
import dotenv from "dotenv"; // Importing the dotenv module

import Todo from "./models/todo.js"; // Importing the Todo model

dotenv.config(); // Loading environment variables from .env file

const app = express(); // Creating an instance of the Express application
app.use(express.json()); // Middleware to parse request body as JSON
app.use(cors()); // Enable Cross-Origin Resource Sharing

const PORT = process.env.PORT || 6001; // Setting the port for the server to listen on

mongoose
  .connect(process.env.MONGO_URL, {
    useNewUrlParser: true, // Use the new URL parser
    useUnifiedTopology: true, // Use the new server discovery and monitoring engine
  })
  .then(() => {
    // Connection to MongoDB successful
    app.listen(PORT, () => {
      console.log(`Server listening on port ${PORT}`); // Start the server and listen on the specified port
    });
  })
  .catch((error) => {
    console.error("MongoDB connection error:", error); // Log the MongoDB connection error
    process.exit(1); // Terminate the application if the connection fails
  });

// Get all todos
app.get("/todos", async (req, res) => {
  try {
    const todos = await Todo.find(); // Fetch all todos from the database
    res.json(todos); // Send the todos as a JSON response
  } catch (error) {
    console.error("Error fetching todos:", error); // Log the error if fetching todos fails
    res.status(500).json({
      message: "An error occurred while fetching todos.", // Send an error response with a descriptive message
      error: error.message,
    });
  }
});

// Create a new todo
app.post("/todos", async (req, res) => {
  try {
    const { text } = req.body; // Extract the todo text from the request body
    const todo = new Todo({ text }); // Create a new todo instance
    const savedTodo = await todo.save(); // Save the todo to the database
    res.json(savedTodo); // Send the saved todo as a JSON response
  } catch (error) {
    console.error("Error saving todo:", error); // Log the error if saving todo fails
    res.status(500).json({
      message: "An error occurred while saving the todo.", // Send an error response with a descriptive message
      error: error.message,
    });
  }
});

// Delete a todo by ID
app.delete("/todos/:id", async (req, res) => {
  try {
    const { id } = req.params; // Extract the todo ID from the request parameters
    const result = await Todo.findByIdAndDelete(id); // Find and delete the todo by ID
    res.json(result); // Send the deletion result as a JSON response
  } catch (error) {
    console.error("Error deleting todo:", error); // Log the error if deleting todo fails
    res.status(500).json({
      message: "An error occurred while deleting the todo.", // Send an error response with a descriptive message
      error: error.message,
    });
  }
});

// Delete all todos
app.delete("/todos", async (req, res) => {
  try {
    const result = await Todo.deleteMany({}); // Delete all todos from the database
    res.json(result); // Send the deletion result as a JSON response
  } catch (error) {
    console.error("Error deleting todos:", error); // Log the error if deleting todos fails
    res.status(500).json({
      message: "An error occurred while deleting todos.", // Send an error response with a descriptive message
      error: error.message,
    });
  }
});

app.put("/todos/:id", async (req, res) => {
  try {
    const { id } = req.params; // Get the id parameter from the request URL
    const todo = await Todo.findById(id); // Find the todo by id using Mongoose

    if (!todo) {
      // If todo is not found, return a 404 response with an error message
      return res.status(404).json({ message: "Todo not found" });
    }

    todo.complete = !todo.complete; // Toggle the 'complete' property of the todo
    await todo.save(); // Save the updated todo to the database
    res.json(todo); // Return the updated todo as a JSON response
  } catch (error) {
    console.error("Error updating todo:", error); // Log the error to the console
    res.status(500).json({
      // Return a 500 response with an error message
      message: "An error occurred while updating the todo.",
      error: error.message,
    });
  }
});
