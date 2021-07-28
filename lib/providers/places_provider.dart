import 'dart:io';

import 'package:flutter/material.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        placeName: title,
        location: null);
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.placeName,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _places = dataList
        .map((item) => Place(
              id: item["id"],
              placeName: item["title"],
              image: File(item["image"]),
              location: null
            ))
        .toList();
      notifyListeners();
  }
}
