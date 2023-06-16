import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:todoallstackapp/controller/connection_helper.dart';
import 'package:todoallstackapp/model/constant.dart';
import 'package:todoallstackapp/model/message.dart';

import '../model/todo.dart';

class DataFetcher {
  final ConnectionHelper helper = ConnectionHelper();

  Future<List<Todo>> fetchAllTasks() async {
    List<Todo> taskList = [];
    Response<dynamic>? response = await helper.fetchData("GET", API.baseUrl);
    if (response != null) {
      if (response.statusCode == 200) {
        var data = response.data;
        try {
          for (var task in data) {
            taskList.add(
              Todo(
                  taskName: task["text"],
                  taskCompleted: task["complete"],
                  id: task["_id"]),
            );
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
      }
    } else {
      if (kDebugMode) {
        print(response);
      }
    }
    return taskList;
  }

  Future<MessageModule> createTask({
    required String task,
  }) async {
    MessageModule message =
        MessageModule(code: 000, message: "api wasnt called");
    dynamic data = {"text": task};
    Response<dynamic>? response =
        await helper.fetchData("POST", API.baseUrl, data: data);
    if (response != null) {
      if (response.statusCode == 200) {
        message = MessageModule(code: 201, message: "Task Created");
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
      }
    } else {
      if (kDebugMode) {
        print(response);
      }
    }
    return message;
  }

  Future<MessageModule> deleteOneTask({
    required String id,
  }) async {
    MessageModule message =
        MessageModule(code: 000, message: "api wasnt called");
    Response<dynamic>? response =
        await helper.fetchData("DELETE", "${API.baseUrl}/$id");
    if (response != null) {
      if (response.statusCode == 200) {
        message = MessageModule(code: 200, message: "Task Deleted");
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
      }
    } else {
      if (kDebugMode) {
        print(response);
      }
    }
    return message;
  }

  Future<MessageModule> deleteAllTask() async {
    MessageModule message =
        MessageModule(code: 000, message: "api wasnt called");
    Response<dynamic>? response = await helper.fetchData("DELETE", API.baseUrl);
    if (response != null) {
      if (response.statusCode == 200) {
        message = MessageModule(code: 200, message: "All Task Deleted");
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
      }
    } else {
      if (kDebugMode) {
        print(response);
      }
    }
    return message;
  }

  Future<MessageModule> completeTask({
    required String id,
  }) async {
    MessageModule message =
        MessageModule(code: 000, message: "api wasnt called");
    Response<dynamic>? response =
        await helper.fetchData("PUT", "${API.baseUrl}/$id");
    if (response != null) {
      if (response.statusCode == 200) {
        message = MessageModule(code: 200, message: "Action Completed");
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
      }
    } else {
      if (kDebugMode) {
        print(response);
      }
    }
    return message;
  }
}
