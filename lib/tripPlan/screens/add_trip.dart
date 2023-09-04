import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/trip.dart';

// import 'package:show_date_picker/date_picker.dart'; // Import the package

class addTrip extends StatefulWidget {
  static const routeName = '/add-trip';
  @override
  State<addTrip> createState() => _addTripState();
}

class _addTripState extends State<addTrip> {
  // const addTrip({super.key});
  final _titleController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String selectedValue = 'Select Value'; // Initialize selected value

// List of values for the dropdown
  List<String> dropdownValues = [
    'Select Value',
    'Beach',
    'Mountains',
    'Forest',
    'City',
    'Pilgrim'
  ];
  // Define a map to map categories to background colors
  Map<String, String> categoryColors = {
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
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          selectedStartDate = picked;
        } else {
          selectedEndDate = picked;
        }
      });
    }
  }

  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: selectedTime,
  //   );
  //   if (picked != null && picked != selectedTime)
  //     setState(() {
  //       selectedTime = picked;
  //     });
  // }
  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context, listen: false);

    final selectedBackgroundColor = categoryColors[selectedValue] ??
        'https://img.freepik.com/free-vector/planning-summer-vacation-leisure-trip-suitcase-map-plane-tickets-top-view-travel-tourism-illustration_1284-52974.jpg?w=2000';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(selectedBackgroundColor),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: SingleChildScrollView(
            // Wrap with SingleChildScrollView
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.7),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Enter Destination',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          controller: _titleController,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Choose Start Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _selectDate(context, true);
                              },
                              child: Text(
                                selectedStartDate == null
                                    ? 'Select Start Date'
                                    : DateFormat.yMd()
                                        .format(selectedStartDate),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Choose End Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _selectDate(context, false);
                              },
                              child: Text(
                                selectedEndDate == null
                                    ? 'Select End Date'
                                    : DateFormat.yMd().format(selectedEndDate),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Select type',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                              ),
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
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 180,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_titleController.text.isNotEmpty) {
                                    final tripProvider =
                                        Provider.of<TripProvider>(context,
                                            listen: false);
                                    tripProvider.addTrip(
                                      _titleController.text,
                                      selectedStartDate,
                                      selectedEndDate,
                                      selectedValue,
                                    );
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text('Add trip'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
