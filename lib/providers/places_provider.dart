import 'dart:io';

import 'package:flutter/material.dart';
import '../models/place.dart';

class PlacesProvider with ChangeNotifier{
  List<Place> _places = [];

  List<Place> get places{
    return [..._places];
  }

  void addPlace(String title,File image){
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      placeName: title,
      location: null

    );
    _places.add(newPlace);
    notifyListeners();
  }
}