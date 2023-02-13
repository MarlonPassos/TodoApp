import 'package:flutter/material.dart';
import 'package:todolist/models/todo_item.dart';
import 'package:todolist/widgets/dialog_box.dart';
import 'package:todolist/widgets/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  // list of todo tasks
  List<TodoItem> toDoList = [
    TodoItem(
      title: 'Maker tutorial',
      dateTime: DateTime.now(),
      completed: false,
    ),
  ];

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index].completed = !toDoList[index].completed;
    });
  }

  // save new task
  void saveNewTask() {
    setState(() {
      TodoItem todoItem = TodoItem(
        title: _controller.text,
        dateTime: DateTime.now(),
        completed: false,
      );
      toDoList.add(todoItem);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () {
            Navigator.of(context).pop();
            _controller.clear();
          },
          onSave: saveNewTask,
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'To Do',
          style: TextStyle(),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: toDoList[index].title,
            taskComplete: toDoList[index].completed,
            taskCreate: toDoList[index].dateTime,
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
