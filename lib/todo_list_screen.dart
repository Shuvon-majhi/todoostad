import 'package:flutter/material.dart';
import 'package:todoostad/Todo.dart';
import 'package:todoostad/add_new_todo_screen.dart';
import 'package:todoostad/edit_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // list
  List<Todo> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todos',
        ),
      ),
      // body
      body: Visibility(
        visible: todoList.isNotEmpty,
        replacement: const Center(
          child: Text('Your Todo List is Empty!!'),
        ),
        child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return buildTodoCard(index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTabTodoAddFAB,
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }

  Card buildTodoCard(int index) {
    return Card(
      child: ListTile(
        title: Text(todoList[index].title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todoList[index].description),
            Text(todoList[index].time.toString()),
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(
              onPressed: () => showDeleteConfirmationDialog(index),
              icon: const Icon(Icons.delete_forever),
            ),
            IconButton(
              onPressed: () => _onTabEditTodo(index),
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTabEditTodo(int index) async {
    final Todo? Updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => editTodoScreen(
          todo: todoList[index],
        ),
      ),
    );
    if (Updated != null) {
      todoList[index] = Updated;
    }
    setState(() {});
  }

  Future<void> _onTabTodoAddFAB() async {
    final Todo? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const addNewTodoscreen(),
      ),
    );
    if (result != null) {
      todoList.insert(0, result);
      setState(() {});
    }
  }

  void showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Todo'),
          content: const Text('Are you sure want to delete!!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                removeTodo(index);
                Navigator.pop(context);
              },
              child: const Text(
                'Yes, Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }

  void removeTodo(int index) {
    todoList.removeAt(index);
    setState(() {});
  }
}
