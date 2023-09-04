import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../helper/db___helpers.dart';
import 'image_input1.dart';

class Document {
  final String name;
  final String category;
  final String path;

  Document({
    required this.name,
    required this.category,
    required this.path,
  });
}

class MyDocuments extends StatelessWidget {
  static const RouteNmae = '/documents';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Save Documents Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DocumentScreen(),
    );
  }
}

class DocumentScreen extends StatefulWidget {
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  CameraController? _cameraController;
  bool _isCameraReady = false;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    await _cameraController!.initialize();

    if (!mounted) return;

    setState(() {
      _isCameraReady = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    fetchDocuments();
  }

  // Rest of the code...
  Future<void> _takePicture() async {
    if (!_cameraController!.value.isInitialized) {
      return;
    }

    final XFile pictureFile = await _cameraController!.takePicture();

    final document = Document(
      name: _documentNameController.text,
      category: selectedCategory,
      path: pictureFile.path,
    );

    final documentMap = {
      'name': document.name,
      'category': document.category,
      'path': document.path,
    };

    await DBHelperD.insertDocument(documentMap);
    savedDocuments.add(document);
    setState(() {});
  }

  Future<void> fetchDocuments() async {
    final documentData = await DBHelperD.getDocuments();

    savedDocuments = documentData
        .map((documentMap) => Document(
              name: documentMap['name'],
              category: documentMap['category'],
              path: documentMap['path'],
            ))
        .toList();

    setState(() {});
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchDocuments();
  // }

  Future<void> _deleteDocument(int index) async {
    final document = savedDocuments[index];
    await DBHelperD.deleteDocument(document.path); // Delete from database
    savedDocuments.removeAt(index);
    setState(() {});

    if (savedDocuments.isEmpty) {
      selectedCategory = 'ID'; // Reset selected category
    }

    setState(() {});
  }

  final TextEditingController _documentNameController = TextEditingController();
  String selectedCategory = 'ID';
  List<String> documentCategories = [
    'ID',
    'Tickets',
    'Bookings',
    'Miscellaneous'
  ];
  List<Document> savedDocuments = [];
  //
  void _pickImg() async {
    final result = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (result != null) {
      final file = File(result.path);
      final document = Document(
        name: _documentNameController.text,
        category: selectedCategory,
        path: file.path,
      );

      final documentMap = {
        'name': document.name,
        'category': document.category,
        'path': document.path,
      };

      await DBHelperD.insertDocument(documentMap);
      savedDocuments.add(document);
      setState(() {});
    }
  }

  void _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      final document = Document(
        name: _documentNameController.text,
        category: selectedCategory,
        path: file.path,
      );

      final documentMap = {
        'name': document.name,
        'category': document.category,
        'path': document.path,
      };

      await DBHelperD.insertDocument(documentMap);
      savedDocuments.add(document);
      setState(() {});
    }

    if (result != null) {
      File file = File(result.files.single.path!);
      savedDocuments.add(Document(
        name: _documentNameController.text,
        category: selectedCategory,
        path: file.path,
      ));
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Save Documents')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Document Name'),
              controller: _documentNameController,
            ),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: documentCategories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _pickDocument,
                  child: Text('Upload Document'),
                ),
                ElevatedButton(
                  onPressed: _pickImg,
                  child: Text('Take Picture'),
                ),
              ],
            ),
            // ImageInput(_selectImage),

            Expanded(
              child: ListView.builder(
                itemCount: savedDocuments.length,
                itemBuilder: (context, index) {
                  final document = savedDocuments[index];
                  return ListTile(
                    title: Text(document.name),
                    subtitle: Text(document.category),
                    leading: IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () {
                        // Implement logic to open the document based on its type
                        // For simplicity, this example opens images using an Image widget
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Image.file(File(document.path)),
                            );
                          },
                        );
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                height: 100,
                                child: Column(children: [
                                  Text('Do you want to delete the document?'),
                                  Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            _deleteDocument(index);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('No'))
                                    ],
                                  )
                                ]),
                              ),
                            );
                          },
                        );
                        // Call the delete method
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
