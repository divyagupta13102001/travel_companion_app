import 'transaction.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Expense> recentTransaction;

  Chart(this.recentTransaction);

  Map<String, double> get groupedCategoryValues {
    final groupedTransactions =
        groupBy(recentTransaction, (Expense tx) => tx.category);
    final categorySum = <String, double>{};

    groupedTransactions.forEach((category, transactions) {
      final totalSum = transactions.fold(0.0, (sum, tx) => sum + tx.amount);
      categorySum[category] = totalSum;
    });

    return categorySum;
  }

  double get totalSpending {
    return groupedCategoryValues.values.fold(0.0, (sum, amount) {
      return sum + amount;
    });
  }
//   List<Map<String, dynamic>> get groupedTransactionValues {
//     return List.generate(7, (index) {
//       final weekDay = DateTime.now().subtract(
//         Duration(days: index),
//       );
//       double totalSum = 00;

//       for (var i = 0; i < recentTransaction.length; i++) {
//         if (recentTransaction[i].date.day == weekDay.day &&
//             recentTransaction[i].date.month == weekDay.month &&
//             recentTransaction[i].date.year == weekDay.year) {
//           totalSum += recentTransaction[i].amount;
//         }
//       }
//       // print(DateFormat.E().format(weekDay));
//       // print(totalSum);
//       return {
//         'day': DateFormat.E().format(weekDay).substring(0, 1),
//         'amount': totalSum,
//       };
//     });
//   }

//   double get totalSpending {
//     return groupedTransactionValues.fold(0.0, (sum, item) {
//       return sum + item['amount'];
//     });
//   }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedCategoryValues.keys.map((category) {
            final categoryAmount = groupedCategoryValues[category]!;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                category,
                categoryAmount,
                totalSpending == 0.0 ? 0.0 : categoryAmount / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
//     return //Container(
//         //   height: MediaQuery.of(context).size.height * 0.2,
//         Card(
//       elevation: 6,
//       margin: EdgeInsets.all(20),
//       child: Padding(
//         padding: EdgeInsets.all(10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: groupedTransactionValues.map((data) {
//             return Flexible(
//               fit: FlexFit.tight,
//               child: ChartBar(
//                 data['day'],
//                 data['amount'],
//                 totalSpending == 0.0
//                     ? 0.0
//                     : (data['amount'] as double) / totalSpending,
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
