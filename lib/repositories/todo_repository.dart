import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/models/task.dart';

const String todoStringKey = 'todo_string_key';

class TodoRepository {
  late SharedPreferences sharedPreferences;

  Future<List<Task>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String todoString =
        sharedPreferences.getString(todoStringKey) ?? '[]';
    final List jsonDecode = json.decode(todoString) as List;
    return jsonDecode.map((e) => Task.fromJson(e)).toList();
  }

  void saveTodoList(List<Task> todos) {
    final todoString = json.encode(todos);
    sharedPreferences.setString(todoStringKey, todoString);
  }
}
