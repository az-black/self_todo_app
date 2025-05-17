import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  List<String> todoList;
  void Function() updateLocalData;

  TodoList({super.key, required this.todoList, required this.updateLocalData});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  void onItemClicked({required int index}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                widget.todoList.removeAt(index);
              });
              widget.updateLocalData();
              Navigator.pop(context);
            },
            child: Text('Marks as Done'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return (widget.todoList.isEmpty)
        ? Center(
          child: Text(
            'Tidak Ada Kegiatan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
        : ListView.builder(
          itemCount: widget.todoList.length,
          itemBuilder: (BuildContext, int index) {
            return Material(
              color: Colors.transparent,
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.green,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.check_rounded),
                      ),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    widget.todoList.removeAt(index);
                  });
                  widget.updateLocalData();
                },
                child: ListTile(
                  onTap: () {
                    onItemClicked(index: index);
                    print("OK");
                  },
                  title: Text(widget.todoList[index]),
                ),
              ),
            );
          },
        );
  }
}
