import express, { json } from "express";
import mongoose, { connect } from "mongoose";
import cors from "cors";
import dotenv from "dotenv";

import Todo from "./models/todo.js";

dotenv.config(); // Load environment variables from .env file
const app = express();

app.use(json());
app.use(cors());

const PORT = process.env.PORT || 6001;

mongoose
  .connect(process.env.MONGO_URL, {
    useNewUrlParser: true, // Use the new URL parser
    useUnifiedTopology: true, // Use the new server discovery and monitoring engine
  })
  .then(() => {
    // Start the server and listen on the specified port
    app.listen(PORT, () => console.log(`Server Port: ${PORT}`));
  })
  .catch((error) => console.log(`${error} did not connect`));

app.get("/todos", async (req, res) => {
  const todos = await Todo.find();
  res.json(todos);
});

app.post("/todo/new", (req, res) => {
  const todo = new Todo({
    text: req.body.text,
  });

  todo
    .save()
    .then((savedTodo) => {
      res.json(savedTodo);
    })
    .catch((error) => {
      res.status(500).json({
        message: "An error occurred while saving the todo.",
        error: error,
      });
    });
});

app.delete("/todo/delete/:id", async (req, res) => {
  const result = await Todo.findByIdAndDelete(req.params.id);

  res.json(result);
});

app.delete("/todo/delete", async (req, res) => {
  try {
    const result = await Todo.deleteMany({});
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: "An error occurred while deleting todos." });
  }
});

app.put("/todo/complete/:id", async (req, res) => {
  const todo = await Todo.findById(req.params.id);

  todo.complete = !todo.complete;
  todo.save();
  res.json(todo);

  res.json(result);
});
