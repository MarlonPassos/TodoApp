import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/repositories/todo_repository.dart';
import 'package:todolist/widgets/dialog_box.dart';
import 'package:todolist/widgets/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  // list of todo tasks
  List<Task> toDoList = [];

  // Load tasks todolist
  @override
  void initState(){
    super.initState();
    todoRepository.getTodoList().then((value) {
      setState(() {
        toDoList = value;
      });
    });
  }

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index].completed = !toDoList[index].completed;
    });
    todoRepository.saveTodoList(toDoList);
  }

  // save new task
  void saveNewTask() {
    setState(() {
      Task todoItem = Task(
        name: _controller.text,
        createdAt: DateTime.now(),
        completed: false,
      );
      toDoList.add(todoItem);
      _controller.clear();
    });
    // add local storage
    todoRepository.saveTodoList(toDoList);
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
    todoRepository.saveTodoList(toDoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        centerTitle: true,
        title: toDoList.isEmpty
            ? const Text(
                'Sem tarefas',
              )
            : Text('${toDoList.length} Tarefas '),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: toDoList[index].name,
            taskComplete: toDoList[index].completed,
            taskCreate: toDoList[index].createdAt,
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
