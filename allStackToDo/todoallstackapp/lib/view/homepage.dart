import 'package:flutter/material.dart';
import 'package:todoallstackapp/view/todotile.dart';

import '../model/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> taskList = [
    Todo(taskName: "sample task", taskCompleted: false),
    Todo(taskName: "Sample Task1", taskCompleted: false),
    Todo(taskName: "Sample task 3", taskCompleted: false),
  ];
  void completeTask(bool? value, int index) {
    //Complete Task
  }

  // create a new task
  void createNewTask() {
    //Implement Create Task
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return DialogBox(
    //       controller: _controller,
    //       onSave: saveNewTask,
    //       onCancel: () => Navigator.of(context).pop(),
    //     );
    //   },
    // );
  }

  // delete task
  void deleteTask(int index) {
    //Implement delete task
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            task: taskList[index],
            onChanged: (value) => completeTask(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
