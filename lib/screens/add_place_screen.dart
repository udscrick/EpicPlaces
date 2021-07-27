import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  //  AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }
  void _savePlaceOnSubmit(){
    if(_titleController.text.isEmpty||_pickedImage==null){
      return;
    }
    Provider.of<PlacesProvider>(context,listen: false).addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                   TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                 const SizedBox(height: 10,),
                 ImageInput(_selectImage)
                ],
              ),
            ),
          )),
          // Padding(
            // padding: const EdgeInsets.all(8.0),
            // child: 
            ElevatedButton.icon(
              onPressed: _savePlaceOnSubmit,
              icon: const Icon(Icons.add),
              
              label: const Text('Add Place'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                primary: Theme.of(context).colorScheme.secondary
                
              ),
            ),
          // )
        ],
      ),
    );
  }
}
