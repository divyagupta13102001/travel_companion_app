import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transaction.dart';
import 'package:intl/intl.dart';

class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch expenses when the screen is initialized
    final expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);
    expenseProvider.fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Expense List')),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, _) {
          final expenses = provider.expenses;
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return ListTile(
                title: Text(expense.title),
                subtitle: Text('${expense.amount} \$'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteExpense(expense.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}


// class transactionlist extends StatelessWidget {
//   final List<Transaction> transactions;
//   final Function deleteTx;

//   transactionlist(this.transactions, this.deleteTx);
//   @override
//   Widget build(BuildContext context) {
//     final expenseProvider =
//         Provider.of<ExpenseProvider>(context, listen: false);
//     expenseProvider.fetchExpenses();
//     return
//         //   height: MediaQuery.of(context).size.height * 0.6,
//         transactions.isEmpty
//             ? LayoutBuilder(builder: (ctx, constraints) {
//                 return Column(
//                   children: <Widget>[
//                     Text('No transaction yet'),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       height: 300,
//                       child: Image.network(
//                         'https://cdni.iconscout.com/illustration/premium/thumb/no-transaction-7359562-6024630.png',
//                         fit: BoxFit.cover,
//                       ),
//                     )
//                   ],
//                 );
//               })
//             : ListView.builder(
//                 itemBuilder: (ctx, index) {
//                   return Card(
//                     elevation: 5,
//                     margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
//                     child: ListTile(
//                       leading: Container(
//                         // radius: 30,

//                         child: Text(
//                           'Rs.${transactions[index].amount}',
//                           style: TextStyle(fontSize: 20, color: Colors.blue),
//                         ),
//                       ),
//                       title: Text(
//                         transactions[index].title,
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       subtitle: Text(
//                         (transactions[index].category),
//                       ),
//                       trailing: MediaQuery.of(context).size.width > 360
//                           ? TextButton.icon(
//                               icon: Icon(Icons.delete),
//                               onPressed: () => deleteTx(transactions[index].id),
//                               label: Text('Delete'),
//                             )
//                           : IconButton(
//                               icon: Icon(Icons.delete),
//                               color: Theme.of(context).errorColor,
//                               onPressed: () => deleteTx(transactions[index].id),
//                             ),
//                     ),
//                   );

//                   // return Card(
//                   //   child: Row(
//                   //     children: <Widget>[
//                   //       Container(
//                   //         margin: EdgeInsets.symmetric(
//                   //           vertical: 10,
//                   //           horizontal: 15,
//                   //         ),
//                   //         decoration: BoxDecoration(
//                   //           border: Border.all(
//                   //             color: Colors.purple,
//                   //             width: 2,
//                   //           ),
//                   //         ),
//                   //         padding: EdgeInsets.all(10),
//                   //         child: Text(
//                   //           'Rs.${transactions[index].amount.toStringAsFixed(2)}',
//                   //           style: TextStyle(
//                   //             fontWeight: FontWeight.bold,
//                   //             fontSize: 20,
//                   //             color: Colors.purple,
//                   //           ),
//                   //         ),
//                   //       ),
//                   //       Column(
//                   //         crossAxisAlignment: CrossAxisAlignment.start,
//                   //         children: <Widget>[
//                   //           Text(
//                   //             transactions[index].title,
//                   //             style: TextStyle(
//                   //               fontWeight: FontWeight.bold,
//                   //               fontSize: 17,
//                   //             ),
//                   //           ),
//                   //           Text(
//                   //             DateFormat('yyyy-MM-dd')
//                   //                 .format(transactions[index].date),
//                   //             style: TextStyle(
//                   //               color: Colors.grey,
//                   //             ),
//                   //           ),
//                   //         ],
//                   //       ),
//                   //     ],
//                   //   ),
//                 },
//                 itemCount: transactions.length,
//               );
//   }
// }
