import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/Documents_add/screens_/add_document_screen.dart';
import 'package:trip_planner/expense_planner/expensePlanner.dart';
import 'package:trip_planner/expense_planner/home_transaction.dart';
import 'package:trip_planner/expense_planner/transaction.dart';
import 'package:trip_planner/great_places/providers/location.dart';
import 'package:trip_planner/packing_list/list_items.dart';
import 'package:trip_planner/packing_list/packing_home.dart';
import 'package:trip_planner/tripPlan/providers/trip.dart';
import 'package:trip_planner/tripPlan/screens/home_screen.dart';
import 'great_places/providers/greatplacesprovider.dart';

import 'package:trip_planner/great_places/screens/add_places_screen.dart';
import 'package:trip_planner/tripPlan/screens/add_trip.dart';
import 'package:trip_planner/great_places/screens/places_list_screen.dart';
// import 'package:trip_planner/Screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => greatPlaces()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => ExpenseProvider()),
        ChangeNotifierProvider(create: (context) => TripProvider()),
      ],
      child: MaterialApp(
        title: 'Travel Planner',
        theme: ThemeData(
            // primarySwatch: Colors.purple,
            // accentColor: Colors.orange,
            ),
        home: homeScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          addTrip.routeName: (ctx) => addTrip(),
          MyHomePage.routeName: (ctx) => MyHomePage(),
          MyListPage.routeName: (ctx) => MyListPage(),
          MyList.routeName: (ctx) => MyList(),
          // MyExpense.routeName: (ctx) => MyExpense(),
          // AddExpenseScreen.routeName: (ctx) => AddExpenseScreen(),
          MyDocuments.RouteNmae: (ctx) => MyDocuments()
        },
      ),
    );
  }
}
