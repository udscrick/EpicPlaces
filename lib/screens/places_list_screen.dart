import 'package:epicplaces/screens/add_place_screen.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class PlacesListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Epic Places List!'),
      actions: [
        IconButton(onPressed: (){
          Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
        }, icon: const Icon(Icons.add))
        ],),
      body:const CircularProgressIndicator(),
    );
  }
}