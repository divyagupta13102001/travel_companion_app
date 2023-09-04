import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/greatplacesprovider.dart';
import '../screens/add_places_screen.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPlaceScreen()),
            );
          },
          icon: Icon(Icons.add),
        )
      ]),
      body: FutureBuilder(
        future: Provider.of<greatPlaces>(context).fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: Text('No Data Yet'),
                  )
                : Consumer<greatPlaces>(
                    child: Center(child: Text('No data!')),
                    builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                        ? ch!
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[index].image!),
                              ),
                              title: Text(greatPlaces.items[index].name),
                            ),
                          ),
                  ),
      ),
    );
  }
}
