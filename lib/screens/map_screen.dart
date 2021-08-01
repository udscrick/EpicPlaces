import 'package:epicplaces/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceCoOrds initialLocation;

  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceCoOrds(latitude: 37.422, longitude: -122.084),
      this.isSelecting});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 13,
            target: LatLng(widget.initialLocation.latitude,
                widget.initialLocation.longitude,
                
                )),
      ),
    );
  }
}
