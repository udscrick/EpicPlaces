import 'package:epicplaces/models/place.dart';
import 'package:epicplaces/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function _selectPlace;
  LocationInput(this._selectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  LocationData locData;

  void _showPreview(double lat, double long) {
    final staticMapImageUrl =
        LocationHelper.generateLocPreviewImage(latitude: lat, longitude: long);
    widget._selectPlace(lat, long);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> selectOnMap() async {
    try {
      locData = await Location().getLocation();

//We store the data that we receive on closing/popping the map route on save of location
      final LatLng selectedLocation = await Navigator.of(context).push(
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  initialLocation: PlaceCoOrds(
                      latitude: locData.latitude, longitude: locData.longitude),
                  isSelecting: true,
                )),
      );
      if (selectedLocation == null) {
        return;
      }
      _showPreview(selectedLocation.latitude, selectedLocation.longitude);
      print(selectedLocation.latitude);
    } catch (error) {
      return error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 170,
            alignment: Alignment.center,
            width: double.infinity,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            child: _previewImageUrl == null
                ? const Text(
                    'No Location chosen',
                    textAlign: TextAlign.center,
                  )
                : Image.network(
                    _previewImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary),
              ),
            ),
            TextButton.icon(
              onPressed: selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select On Map'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary),
              ),
            ),
          ],
        )
      ],
    );
  }
}
