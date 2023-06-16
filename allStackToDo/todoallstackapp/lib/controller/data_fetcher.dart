import 'package:todoallstackapp/controller/connection_helper.dart';
import 'package:todoallstackapp/model/message.dart';

import '../model/todo.dart';

class DataFetcher {
  final ConnectionHelper helper = ConnectionHelper();

  Future<List<Todo>> fetchAllTasks() async {
    List<Todo> taskList = [];
    return taskList;
  }

  Future<MessageModule> createTask() async {
    MessageModule message =
        MessageModule(code: 000, message: "api wasnt called");
    return message;
  }

  Future<MessageModule> deleteOneTask() async {
    MessageModule message =
        MessageModule(code: 000, message: "api wasnt called");
    return message;
  }

  Future<MessageModule> deleteAllTask() async {
    MessageModule message =
        MessageModule(code: 000, message: "api wasnt called");
    return message;
  }

  Future<MessageModule> completeTask() async {
    MessageModule message =
        MessageModule(code: 000, message: "api wasnt called");
    return message;
  }
}
