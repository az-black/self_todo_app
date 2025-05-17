import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  void Function({required String todoText}) addTodo;

  AddTodo({super.key, required this.addTodo});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text('Add Todo:'),
        Container(
          padding: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onSubmitted: (value) {
                if (todoText.text.isNotEmpty) {
                  widget.addTodo(todoText: todoText.text);
                }
                todoText.text = todoText.text;
              },
              autofocus: true,
              controller: todoText,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.clean_hands_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (todoText.text.isNotEmpty) {
              widget.addTodo(todoText: todoText.text);
            }
            todoText.text = todoText.text;
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
