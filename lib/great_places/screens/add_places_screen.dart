import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/greatplacesprovider.dart';
import '../widgets/location_input.dart';
import 'dart:io';
import '../widgets/image_input.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<greatPlaces>(context)
        .addPlace(_titleController.text, _pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 20,
                    ),
                    LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Place'),
              onPressed: () {
                _savePlace;
                Navigator.of(context).pop();
              } // elevation: 0,
              // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
        ],
      ),
    );
  }
}
