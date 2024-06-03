import '../models/todo_models.dart';
import '../services/todo_http_services.dart';

class TodoControllers {
  final todoHttpServices = TodoHttpServices();
  List<TodoModels> _list = [];

  Future<List<TodoModels>> get list async {
    _list = await todoHttpServices.getTodos();
    return [..._list];
  }

  void add(String name, String date, bool isDone) async {
    final newTodoModels = await todoHttpServices.addTodos(name, date, isDone);
    _list.add(newTodoModels);
    print(_list);
  }

  void delete(String id) {
    todoHttpServices.deleteTodos(id);
    // _list.removeAt(index);
  }

  void edit(String id, String name, String date) {
    todoHttpServices.editTodos(id, name, date);
    // _list[index].name = name;
    // _list[index].date = date;
  }

  Map<String, String> todoChecks() {
    int exerciseTrue = 0;
    int exerciseFalse = 0;
    for (var element in _list) {
      if (element.isDone) {
        exerciseTrue++;
      } else {
        exerciseFalse++;
      }
    }
    return {
      'bajarilgan': exerciseTrue.toString(),
      'bajarilmagan': exerciseFalse.toString()
    };
  }
}
