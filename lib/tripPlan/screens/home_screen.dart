import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/Documents_add/screens_/add_document_screen.dart';
import 'package:trip_planner/expense_planner/expensePlanner.dart';
import 'package:trip_planner/expense_planner/home_transaction.dart';
import 'package:trip_planner/packing_list/packing_home.dart';
import 'package:trip_planner/tripPlan/providers/trip.dart';
import '../../packing_list/list_items.dart';
import 'add_trip.dart';
import '../../great_places/screens/places_list_screen.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  Map<String, String> categoryBackgrounds = {
    'Select Value':
        'https://img.freepik.com/free-vector/planning-summer-vacation-leisure-trip-suitcase-map-plane-tickets-top-view-travel-tourism-illustration_1284-52974.jpg?w=2000',
    'Beach':
        'https://img.freepik.com/premium-vector/summer-tropical-sea-beach-background-vector-illustration_175838-2393.jpg',
    'Mountains':
        'https://img.freepik.com/premium-vector/lake-mountain-landscape-free-vector-flat-design_506973-4.jpg?w=2000',
    'Forest':
        'https://img.freepik.com/premium-photo/2d-blank-nature-forest-landscape-scene-cartoon-background_947967-417.jpg',
    'City':
        'https://i.pinimg.com/736x/ca/ab/7b/caab7be087ef0782f307f8971319df64.jpg',
    'Pilgrim':
        'https://img.freepik.com/free-vector/people-with-face-mask-hajj-pilgrimage-illustration_23-2148971411.jpg?w=2000',
  };
  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
    final mostRecentTrip = tripProvider.mostRecentTrip;
    bool TripNull = false;
    final backgroundUrl;
    if (mostRecentTrip == null) {
      TripNull = true;
      backgroundUrl =
          'https://img.freepik.com/free-vector/planning-summer-vacation-leisure-trip-suitcase-map-plane-tickets-top-view-travel-tourism-illustration_1284-52974.jpg?w=2000';
    } else
      backgroundUrl = categoryBackgrounds[mostRecentTrip.type];

    return Scaffold(
      // appBar: AppBar(actions: []),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(backgroundUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(
                  0.4), // Set the desired opacity (0.4 in this case)

              child: Center(
                child: mostRecentTrip == null
                    ? Text(
                        'No Trips Yet',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            mostRecentTrip.title.toUpperCase(),
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Start Date: ${DateFormat.yMd().format(mostRecentTrip.startDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight
                                  .bold, // Set the font weight to bold
                              color: Colors.white, // Set the text color
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'End Date: ${DateFormat.yMd().format(mostRecentTrip.endDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          // ... other trip details ...
                        ],
                      ),
              ),
            ),
          ),
          // Container(
          //   height: 200,
          //   decoration: BoxDecoration(),
          //   child: Image.network(
          //     'https://cdn.vectorstock.com/i/preview-1x/99/33/app-for-tourism-vector-44889933.jpg',
          //     fit: BoxFit.fill,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              // padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                child: Text(
                  'Add Trip',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => addTrip()),
                  );
                  //add trip details page
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
                padding: EdgeInsets.all(10),
                height: 300,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 50,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove default padding
                        fixedSize: Size(100, 80),
                        primary: null, // Set a fixed size for the button
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/4776/4776981.png',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Expense Planner'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyList()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            8), // Adjust padding to reduce button size
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/305/305100.png',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Packing List'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add your logic here
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (ctx) => MyDocuments()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            8), // Adjust padding to reduce button size
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/4136/4136043.png',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Save Documents'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PlacesList()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            8), // Adjust padding to reduce button size
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/223/223120.png',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Save Pictures'),
                        ],
                      ),
                    ),
                  ],
                )),
          )
        ],
      )),
    );
  }
}
