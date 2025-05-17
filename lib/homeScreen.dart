import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/addTodo.dart';
import 'package:todoapp/widgets/drawer.dart';
import 'package:todoapp/widgets/todoList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isBottomSheetOpen = false;

  String text = '';

  List<String> todoList = [];

  void addTodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Data Sudah Ada'),
            content: Text('Data ini sudah ada'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
      todoList.insert(0, todoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todoList', todoList);
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final loadedList = (prefs.getStringList("todoList") ?? []).toList();

    setState(() {
      todoList = loadedList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void FloatButton() {
    setState(() {
      _isBottomSheetOpen = true;
    });
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AddTodo(addTodo: addTodo),
        );
      },
    ).whenComplete(() {
      setState(() {
        _isBottomSheetOpen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerList(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo App', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        color: Colors.blueGrey[900],
        padding: EdgeInsets.all(15),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: TodoList(
                todoList: todoList,
                updateLocalData: updateLocalData,
              ),
            ),
            Text('$text'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: FloatButton,
        child: Icon(_isBottomSheetOpen ? Icons.close : Icons.add),
      ),
    );
  }
}
