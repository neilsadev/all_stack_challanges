import mongoose from "mongoose";

const { Schema } = mongoose;

const ToDoSchema = new Schema({
  text: {
    type: String,
    require: true,
  },
  complete: {
    type: Boolean,
    default: false,
  },
  timestamp: {
    type: String,
    default: Date.now(),
  },
});

export default mongoose.model("Todo", ToDoSchema);
