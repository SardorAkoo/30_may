import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/todo_models.dart';

class TodoHttpServices {
  Future<List<TodoModels>> getTodos() async {
    Uri url =
        Uri.parse('https://lesson-46-default-rtdb.firebaseio.com/product.json');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<TodoModels> todosList = [];
    if (data != null) {
      data.forEach((key, value) {
        value['id'] = key;
        todosList.add(TodoModels.fromJson(value));
      });
    }
    return todosList;
  }

  Future<TodoModels> addTodos(String name, String date, bool isDone) async {
    Uri url =
        Uri.parse('https://lesson-46-default-rtdb.firebaseio.com/product.json');
    Map<String, dynamic> todoData = {
      'name': name,
      'date': date,
      'isDone': isDone,
    };
    final response = await http.post(url, body: jsonEncode(todoData));
    final data = jsonDecode(response.body);
    todoData['id'] = data['name'];
    TodoModels newTodoModels = TodoModels.fromJson(todoData);
    return newTodoModels;
  }

  Future<void> editTodos(String id, String name, String date) async {
    Uri url = Uri.parse(
        'https://lesson-46-default-rtdb.firebaseio.com/product$id.json');
    Map<String, dynamic> todoData = {
      'name': name,
      'date': date,
    };
    final response = await http.patch(url, body: jsonEncode(todoData));
    final data = await jsonDecode(response.body);
    print(data);
  }

  Future<void> deleteTodos(String id) async {
    Uri url = Uri.parse(
        'https://lesson-46-default-rtdb.firebaseio.com/product$id.json');
    Map<String, dynamic> todoData = {};
    final response = await http.delete(url, body: jsonEncode(todoData));
  }

  Future<void> isDoneTodos(String id) async {
    Uri url = Uri.parse(
        'https://lesson-46-default-rtdb.firebaseio.com/product$id.json');
    final response1 = await http.get(url);
    final data1 = jsonDecode(response1.body);
    // bool check = false;
    // if (data1 != null) {
    //   data1.forEach((key, value) {
    //     if(key)
    //   });
    // }
    // print(data1);
    Map<String, dynamic> todoData = {'isDone': !data1['isDone']};
    final response = await http.patch(url, body: jsonEncode(todoData));
    final data = await jsonDecode(response.body);
    print(data);
  }
}
