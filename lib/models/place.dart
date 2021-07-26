



import 'dart:io';

class PlaceCoOrds{
  final double latitude;
  final double longitude;
  final String address;
  PlaceCoOrds({required this.latitude,required this.longitude,this.address=''});
}

class Place{
  final String id;
  final String placeName;
  final PlaceCoOrds location;
  final File image; //SInce we will be loading images from the device and not any web url
  Place(
    {
      required this.id,
      required this.placeName,
      required this.location,
      required this.image
      });

  

}