import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  final Function addtask;
  NewTask(this.addtask);

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final titlecontroller = TextEditingController();
  String selectedValue = 'To pack';
  List<String> dropdownValues = ['To pack', 'Already Packed', 'To Buy'];

  void submitdata() {
    final enterdTitle = titlecontroller.text;
    final enteredCategory = selectedValue;
    final id = DateTime.now().toString();

    // if (selectedValue == 'To Pack') {
    //   isCompleted = false;
    // }
    if (enterdTitle.isEmpty) {
      return;
    }
    widget.addtask(id, enterdTitle, enteredCategory);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Task Title'),
              controller: titlecontroller,
              onSubmitted: (_) => submitdata(),
            ),
            DropdownButton<String>(
              value: selectedValue,
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: dropdownValues.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextButton(
              onPressed: submitdata,
              child: Text('Add task'),
            )
          ],
        ),
      ),
    );
  }
}
