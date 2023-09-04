import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// import '../great_places/helpers/db_helpers.dart';
import 'dbhelper.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(date),
      'category': category,
    };
  }
}

class ExpenseProvider extends ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  // Fetch expenses from the database and update the expenses list
  Future<void> fetchExpenses() async {
    final transactionData = await DBHelperT.getTransactions();

    _expenses = transactionData
        .map((transactionMap) => Expense(
              id: transactionMap['id'].toString(),
              title: transactionMap['title'],
              amount: transactionMap['amount'],
              date: DateTime.parse(transactionMap['date']),
              category: transactionMap['category'],
            ))
        .toList();

    notifyListeners();
  }

  // Method to add a new expense.
  Future<void> addExpense(
      String title, double amount, String category, DateTime chosenDate) async {
    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
      category: category,
    );
    final expenseMap = newExpense.toMap();

    await DBHelperT.insertTransaction(expenseMap);
    _expenses.add(newExpense);
    notifyListeners();
  }

  // Future<void> fetchExpenses() async {
  //   final db = await DBHelper.database();
  //   final expenseMaps = await db.query('transactions');

  //   _expenses = expenseMaps.map((expenseMap) {
  //     return Expense(
  //       id: expenseMap['id'] as String,
  //       title: expenseMap['title'] as String,
  //       amount: expenseMap['amount'] as double,
  //       category: expenseMap['category'] as String,
  //     );
  //   }).toList();

  //   notifyListeners();
  // }

  // Method to delete an expense.
  void deleteExpense(String expenseId) {
    _expenses.removeWhere((expense) => expense.id == expenseId);
    notifyListeners();
  }
}

// class Transaction {
//   final String id;
//   final String title;
//   final double amount;
//   final DateTime date;
//   final String category;

//   Transaction(
//       {required this.id,
//       required this.title,
//       required this.amount,
//       required this.date,
//       required this.category});
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'amount': amount,
//       'date': DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(date),
//       'category': category,
//     };
//   }

