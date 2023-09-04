import 'package:trip_planner/expense_planner/dbhelper.dart';

import 'chart.dart';
import 'new_transaction.dart';
import 'transaction.dart';
import 'user_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'transaction_list.dart';
import 'new_transaction.dart';
import 'transaction.dart';

// void main() {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // SystemChrome.setPreferredOrientations([
//   //   DeviceOrientation.portraitUp,
//   //   DeviceOrientation.portraitDown,
//   // ]);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Personal Expenses',
//       theme: ThemeData(
//           primarySwatch: Colors.purple,
//           // accentColor: Colors.amber,
//           fontFamily: 'Quicksand',
//           textTheme: ThemeData.light().textTheme.copyWith(
//                 titleSmall: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       fontFamily: 'OpenSans',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//               ),
//           appBarTheme: AppBarTheme(
//             textTheme: ThemeData.light().textTheme.copyWith(
//                   titleSmall: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         fontFamily: 'OpenSans',
//                         fontSize: 20,
//                       ),
//                 ),
//           )),
//       home: MyHomePage(),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  static const routeName = '/addExpense';
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final List<Transaction> transactions = [];
  final now = DateTime.now();
  final List<Expense> _userTransaction = [];

  bool _showChart = true;

  List<Expense> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate,
      String selectCategory) {
    final newTx = Expense(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      category: selectCategory,
    );

    setState(() {
      _userTransaction.add(newTx);
      DBHelperT.insertTransaction(newTx.toMap()); // Convert to Map
    });
  }

  void _starAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text(
        'Personal Expenses',
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () => _starAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (landscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (!landscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!landscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: ExpenseScreen(),
                // child: transactionlist(_userTransaction, _deleteTransaction),
              ),
            if (landscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          1,
                      child: Chart(_recentTransactions),
                      // Container(
                      //   width: double.infinity,
                      //   child: Card(
                      //     color: Theme.of(context).primaryColor,
                      //     child: Text('CHART'),
                      //     elevation: 5,
                      //   ),
                    )
                  : Container(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: ExpenseScreen(),
                      // child:
                      //     transactionlist(_userTransaction, _deleteTransaction),
                    ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: (() => _starAddNewTransaction(context)),
          child: Icon(Icons.add)),
    );
  }
}
