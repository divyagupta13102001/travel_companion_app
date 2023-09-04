import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/expense_planner/transaction.dart';

class ExpenseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context).expenses;
    return Center();
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(AddExpenseScreen.routeName);
//               },
//               icon: Icon(Icons.add))
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: expenses.length,
//         itemBuilder: (context, index) {
//           final expense = expenses[index];
//           return ListTile(
//             title: Text(expense.title),
//             subtitle: Text(expense.category),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () {
//                 Provider.of<ExpenseProvider>(context, listen: false)
//                     .deleteExpense(expense.id);
//                 Navigator.of(context).pop();
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class AddExpenseScreen extends StatefulWidget {
//   static const routeName = '/addExpens';
//   @override
//   _AddExpenseScreenState createState() => _AddExpenseScreenState();
// }

// class _AddExpenseScreenState extends State<AddExpenseScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   double _amount = 0;
//   String _selectedCategory = 'Food';

//   @override
//   Widget build(BuildContext context) {
//     final expenseProvider =
//         Provider.of<ExpenseProvider>(context, listen: false);

//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           TextField(
//             controller: _titleController,
//             decoration: InputDecoration(labelText: 'Expense Title'),
//           ),
//           TextField(
//             keyboardType: TextInputType.number,
//             onChanged: (value) => _amount = double.parse(value),
//             decoration: InputDecoration(labelText: 'Amount'),
//           ),
//           DropdownButton<String>(
//             value: _selectedCategory,
//             onChanged: (newValue) {
//               setState(() {
//                 _selectedCategory = newValue!;
//               });
//             },
//             // Populate with your categories
//             items: [
//               'Food',
//               'Transport',
//               'Tickets',
//               'Rent',
//               'Accommodation',
//               'Miscellaneous'
//             ].map((category) {
//               return DropdownMenuItem<String>(
//                 value: category,
//                 child: Text(category),
//               );
//             }).toList(),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_titleController.text.isNotEmpty && _amount > 0) {
//                 expenseProvider.addExpense(
//                   _titleController.text,
//                   _amount,
//                   _selectedCategory,

//                 );
//                 _titleController.clear();
//                 _amount = 0;
//               }
//             },
//             child: Text('Add Expense'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyExpense extends StatelessWidget {
//   static const routeName = '/Expense';
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ExpenseProvider(),
//       child: Scaffold(
//         body: ExpenseListScreen(),
//       ),
//     );
  }
}
