const GOOGLE_API_KEY = 'AIzaSyBe-Tho_LNfWIPtXXlGisDOlysqL7DNXJI';

class LocationHelper{
  static String generateLocPreviewImage({double latitude, double longitude}){
    return 
    "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }
}