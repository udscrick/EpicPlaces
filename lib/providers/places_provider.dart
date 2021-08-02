import 'dart:io';

import 'package:flutter/material.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addPlace(String title, File image,PlaceCoOrds pickedLocation)async {
   final address = await LocationHelper.getCoordAddress(pickedLocation.latitude, pickedLocation.longitude);
   final updatedLocation = PlaceCoOrds(latitude: pickedLocation.latitude, longitude: pickedLocation.longitude,address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        placeName: title,
        location: updatedLocation);
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.placeName,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng':newPlace.location.longitude,
      'address':newPlace.location.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _places = dataList
        .map((item) => Place(
              id: item["id"],
              placeName: item["title"],
              image: File(item["image"]),
              location: PlaceCoOrds(latitude: item["loc_lat"], longitude: item["loc_lng"],address: item["address"])
            ))
        .toList();
      notifyListeners();
  }

  Place getPlaceByIndex(index){
    return places[index];
  }
}
