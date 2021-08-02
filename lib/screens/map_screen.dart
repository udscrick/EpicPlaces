import 'package:epicplaces/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceCoOrds initialLocation;

  final bool isSelecting;//False=>Read Only Mode

  MapScreen(
      {this.initialLocation =
          const PlaceCoOrds(latitude: 37.422, longitude: -122.084),
      this.isSelecting});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
LatLng _pickedLocation;

// @override
//   void initState() {
//     // TODO: implement initState
//     if(widget.isSelecting==false){
//       setState(() {
//         _pickedLocation= LatLng(widget.initialLocation.latitude,widget.initialLocation.longitude);
//       });
//     }
//     super.initState();
//   }
void _selectLocation(LatLng position){
  setState(() {
    _pickedLocation = position;
  });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          if(widget.isSelecting) IconButton(onPressed:_pickedLocation==null?null: (){
            Navigator.of(context).pop(_pickedLocation);
          }, icon: const Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 13,
            target: LatLng(widget.initialLocation.latitude,
                widget.initialLocation.longitude,
                
                )),
                onTap: widget.isSelecting?_selectLocation:null,
                markers: (_pickedLocation==null&&widget.isSelecting)?{}:{
                  Marker(markerId: MarkerId('m1'),position: _pickedLocation??LatLng(widget.initialLocation.latitude,widget.initialLocation.longitude))//If picked location is null
                },
      ),
    );
  }
}
