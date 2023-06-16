import 'package:flutter/material.dart';
import 'package:todoallstackapp/controller/data_fetcher.dart';
import 'package:todoallstackapp/view/todotile.dart';

import '../model/message.dart';
import '../model/todo.dart';
import 'dialogue.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  final DataFetcher dataFetcher = DataFetcher();
  final TextEditingController controller = TextEditingController();
  List<Todo> taskList = [];

  void fetchTasks() async {
    setState(() {
      isLoading = true;
    });
    List<Todo> data = await dataFetcher.fetchAllTasks();
    if (data.isNotEmpty) {
      setState(() {
        taskList = data;
        isLoading = false;
      });
    }
  }

  void completeTask(bool? value, int index) {
    //Complete Task
  }

  // create a new task
  void createNewTask() {
    //Implement Create Task
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: controller,
          onSave: () async {
            MessageModule message =
                await dataFetcher.createTask(task: controller.text);
            if (message.code == 201) {
              controller.clear();
              fetchTasks();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message.message),
                ),
              );
            }
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) async {
    MessageModule message =
        await dataFetcher.deleteOneTask(id: taskList[index].id);
    if (message.code == 200) {
      fetchTasks();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message.message),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('All Stack To Do', textDirection: TextDirection.ltr),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: taskList.isEmpty
          ? isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const Center(
                  child: Text("You have no tasks right now, add one"),
                )
          : ListView.builder(
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
