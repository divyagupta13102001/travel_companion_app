import 'package:flutter/material.dart';
import 'task_list.dart';
import 'task.dart';
import 'new_task.dart';

// void main() {
//   runApp(MyApp());
// }

class MyListPage extends StatefulWidget {
  @override
  State<MyListPage> createState() => _MyListPageState();
  static const routeName = '/packingList';
}

class _MyListPageState extends State<MyListPage> {
  final List<Task> _userTask = [];

  void _addNewTask(String tstitle, String Tscategory) {
    final newTs = Task(
      id: DateTime.now().toString(),
      title: tstitle,
      category: Tscategory,
    );
    setState(() {
      _userTask.add(newTs);
    });
  }

  void _startNewTask(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTask(_addNewTask),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TaskList(_userTask),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (() => _startNewTask(context)),
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
