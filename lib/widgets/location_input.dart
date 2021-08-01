import 'package:epicplaces/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';
class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  Future<void> _getCurrentUserLocation() async{
final locData = await Location().getLocation();
final staticMapImageUrl = LocationHelper.generateLocPreviewImage(
  latitude: locData.latitude,longitude: locData.longitude
  );
  setState(() {
    _previewImageUrl = staticMapImageUrl;
  });
  }

  Future<void> selectOnMap() async{
   final selectedLocation = await Navigator.of(context).push(
     MaterialPageRoute(
       fullscreenDialog: true,
       builder: (ctx)=>MapScreen(isSelecting: true,)),);
   if(selectedLocation==null){
     return;
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
            decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey)),
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
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                ),
            ),
            TextButton.icon(
                onPressed: selectOnMap,
                icon: const Icon(Icons.map),
                label: const Text('Select On Map'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                ),
            ),
          ],
        )
      ],
    );
  }
}
