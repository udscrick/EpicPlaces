import 'dart:io';

import 'package:epicplaces/helpers/location_helper.dart';
import 'package:epicplaces/models/place.dart';
import 'package:epicplaces/providers/places_provider.dart';
import 'package:epicplaces/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends StatelessWidget {
  static const routeName = '/place-detail';
  String getImageUrl(double lat, double long) {
    return LocationHelper.generateLocPreviewImage(
        latitude: lat, longitude: long);
  }

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context).settings.arguments;
    final placeInfo = Provider.of<PlacesProvider>(context, listen: false)
        .getPlaceByIndex(placeId);
    return Scaffold(
      appBar: AppBar(
        title: Text(placeInfo.placeName),
      ),
      body: Column(
        children: [
          Container(
              height: 200,
              width: double.infinity,
              child: Image(
                image: FileImage(placeInfo.image),
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(placeInfo.location.address),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
              child: Image.network(getImageUrl(
                  placeInfo.location.latitude, placeInfo.location.longitude)),
                onTap: (){
                  Navigator.of(context).push(
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  initialLocation: PlaceCoOrds(
                      latitude: placeInfo.location.latitude, longitude: placeInfo.location.longitude),
                  isSelecting: false,
                )),
      );
                },
                  
                  )
        ],
      ),
    );
  }
}
