import 'package:epicplaces/providers/places_provider.dart';
import 'package:epicplaces/screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Epic Places List!'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Consumer<PlacesProvider>(
          child: const Center(
            child: Text('No places yet, start adding.'),
          ),
          builder: (ctx, placesData, ch) => placesData.places.length <= 0
              ? ch
              : ListView.builder(
                  itemCount: placesData.places.length,
                  itemBuilder: (ctx, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          FileImage(placesData.places[index].image),
                    ),
                    title: Text(placesData.places[index].placeName),
                    onTap: (){},
                  ),
                ),
        ));
  }
}
