import 'dart:math';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'transaction.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String selectedValue = 'Food';
  // Initialize selected value

// List of values for the dropdown
  List<String> dropdownValues = [
    'Food',
    'Rent',
    'Tickets',
    'Transport',
    'shopping',
    'Miscellaneous'
  ];
  DateTime _selectedDate = DateTime.now();

  void submitData() {
    final expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);
    final id = _selectedDate;
    final enteredAmount = double.parse(amountController.text);
    final enteredTitle = titleController.text;
    final selectedCategory = selectedValue;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      id,
      enteredTitle,
      enteredAmount,
      _selectedDate,
      selectedValue,
    );
    expenseProvider.addExpense(
        enteredTitle, enteredAmount, selectedCategory, id);
    Navigator.of(context).pop();
  }

  void _presentdatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);

    expenseProvider.fetchExpenses();
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          height: 450,
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            bottom: 10,
          ), // right: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
                // onChanged: (val) {
                //   // titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
                // onChanged: (val) => amountInput = val,
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
              Row(
                children: <Widget>[
                  Text(_selectedDate == null
                      ? 'No Date Chosen!'
                      : DateFormat.yMd().format(_selectedDate)),
                  TextButton(
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentdatePicker)
                ],
              ),
              ElevatedButton(
                onPressed: submitData,
                child: Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
