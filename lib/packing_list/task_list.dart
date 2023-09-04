import 'package:flutter/material.dart';
import 'task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  TaskList(this.tasks);

  @override
  Widget build(BuildContext context) {
    final List<Task> toBePackedTasks =
        tasks.where((task) => task.category == 'To Pack').toList();
    final List<Task> toBuyTasks =
        tasks.where((task) => task.category == 'To Buy').toList();
    final List<Task> alreadyPackedTasks =
        tasks.where((task) => task.category == 'Already Packed').toList();

    return Container(
      height: 300,
      child: tasks.isEmpty
          ? Column(
              children: <Widget>[
                Text('No Tasks To Complete'),
              ],
            )
          : ListView(
              children: [
                _buildCategorySection('To Pack', toBePackedTasks),
                _buildCategorySection('To Buy', toBuyTasks),
                _buildCategorySection('Already Packed', alreadyPackedTasks),
              ],
            ),
    );
  }

  Widget _buildCategorySection(String category, List<Task> categoryTasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(),
        Column(
          children: categoryTasks.map((task) => _buildTaskItem(task)).toList(),
        ),
      ],
    );
  }

  Widget _buildTaskItem(Task task) {
    return Card(
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 18,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (newValue) {
            // Update the task's completion status
            // and move between categories if needed
          },
        ),
      ),
    );
  }
}
