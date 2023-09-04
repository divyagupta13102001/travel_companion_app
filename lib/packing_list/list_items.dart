import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'db_helpers.dart';

class Task {
  final String id;
  final String title;
  String category;

  Task({required this.id, required this.title, required this.category});
  setCategory(String newCategory) {
    category = newCategory;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
    };
  }
}

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> addTask(String title, String category) async {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      category: category,
    );

    await DBHelper.insertTask(newTask);
    _tasks.add(newTask);
    notifyListeners();
  }

  void toggleTaskStatus(String id, String newCategory) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.setCategory(newCategory); // Use the setter to update the category
    notifyListeners();
  }

  Future<void> deleteTaskFromDatabase(String id) async {
    final db = await DBHelper.database();
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  void deleteTask(String id) async {
    await deleteTaskFromDatabase(id);
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  Future<void> fetchTasks() async {
    final db = await DBHelper.database();
    final taskMaps = await db.query('tasks');

    _tasks = taskMaps.map((taskMap) {
      return Task(
        id: taskMap['id'] as String,
        title: taskMap['title'] as String,
        category: taskMap['category'] as String,
      );
    }).toList();

    notifyListeners();
  }
}

class MyList extends StatelessWidget {
  static const routeName = '/list';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        title: 'Packing List Creator',
        home: PackingListScreen(),
      ),
    );
  }
}

class PackingListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    // Fetch tasks when the screen is built
    taskProvider.fetchTasks();
    return Scaffold(
      appBar: AppBar(title: Text('Packing List Creator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AddTaskForm(),
            Expanded(child: TaskList()),
          ],
        ),
      ),
    );
  }
}
// Add the following code to the TaskProvider class
// void deleteTask(String id) {
//   _tasks.removeWhere((task) => task.id == id);
//   notifyListeners();
// }

// Update the TaskList class
class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text(task.category),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: task.category == 'Already Packed',
                onChanged: (newValue) {
                  taskProvider.toggleTaskStatus(
                      task.id, newValue! ? 'Already Packed' : 'To Pack');
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  taskProvider.deleteTask(task.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class AddTaskForm extends StatefulWidget {
  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final TextEditingController _titleController = TextEditingController();
  String _selectedCategory = 'To Buy';

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(labelText: 'Item Title'),
        ),
        DropdownButton<String>(
          value: _selectedCategory,
          onChanged: (newValue) {
            setState(() {
              _selectedCategory = newValue!;
            });
          },
          items: ['To Buy', 'To Pack', 'Already Packed'].map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty) {
              taskProvider.addTask(_titleController.text, _selectedCategory);
              _titleController.clear();
            }
          },
          child: Text('Add Task'),
        ),
      ],
    );
  }
}
