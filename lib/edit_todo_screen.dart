import 'package:flutter/material.dart';
import 'package:todoostad/Todo.dart';

class editTodoScreen extends StatefulWidget {
  const editTodoScreen({super.key, required this.todo});

  final Todo todo;

  @override
  State<editTodoScreen> createState() => _editTodoScreenState();
}

class _editTodoScreenState extends State<editTodoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  @override
  void initState() {
    _titleTEController.text = widget.todo.title;
    _descriptionTEController.text = widget.todo.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit todo',
        ),
      ),
      // body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleTEController,
                validator: (String? value) {
                  final temp = value ?? '';
                  if (temp.trim().isEmpty) {
                    return 'Enter the Title';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _descriptionTEController,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter the Description';
                  } else {
                    return null;
                  }
                },
                maxLength: 100,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                //width: double.infinity,
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Todo todo = Todo(
                        _titleTEController.text.trim(),
                        _descriptionTEController.text.trim(),
                        DateTime.now(),
                      );
                      Navigator.pop(context,todo);
                    }
                  },
                  child: const Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
