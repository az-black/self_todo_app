import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  void Function({required String todoText}) changeText; 

  AddTodo({super.key, required this.changeText});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {

  TextEditingController todoText = TextEditingController();
  String currentText = '';
  

  @override
  void initState() {
    super.initState();
    todoText.addListener((){
      setState(() {
        currentText = todoText.text;
      });
    });
  }

  @override 
  void dispose(){
    todoText.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Column(
    
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(currentText), //dari sini
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Actions(
                    actions: WidgetsApp.defaultActions,
                    child: InkWell(
                      splashColor: Color.fromARGB(255, 245, 0, 0),
                      highlightColor: Colors.red,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: TextField(
                                    controller: todoText,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.chat),
                                      label: Text('Isikan Uneg-uneg'),
                                      border: OutlineInputBorder(
                                        gapPadding:
                                            BorderSide.strokeAlignOutside,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        borderSide: BorderSide(width: 50),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    print(todoText);
                                    widget.changeText(todoText: todoText.text);
                                    todoText.text = currentText;
                                  },
                                  child: Text('Add'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(Icons.add, size: 50, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
