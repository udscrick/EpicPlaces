

import 'package:epicplaces/providers/places_provider.dart';
import 'package:epicplaces/screens/add_place_screen.dart';
import 'package:epicplaces/screens/place_detail_screen.dart';
import 'package:epicplaces/screens/places_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlacesProvider(),
      child: MaterialApp(
        title: 'Great Places',
        debugShowCheckedModeBanner: false,
        // showPerformanceOverlay: true,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName:(ctx)=>AddPlaceScreen(),
          PlaceDetail.routeName:(ctx)=>PlaceDetail()
        },
      ),
    );
  }
}
