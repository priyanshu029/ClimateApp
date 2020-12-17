import 'package:location/location.dart';

class myLocation {

  double latitude;
  double longitude;

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData locationData;

 Future<void> getLocation() async {
   try{
     _serviceEnabled = await location.serviceEnabled();
     if (!_serviceEnabled) {
       _serviceEnabled = await location.requestService();
       if (!_serviceEnabled) {
         return;
       }
     }

     _permissionGranted = await location.hasPermission();
     if (_permissionGranted == PermissionStatus.denied) {
       _permissionGranted = await location.requestPermission();
       if (_permissionGranted != PermissionStatus.granted) {
         return;
       }
     }

     locationData = await location.getLocation();
     longitude=locationData.longitude;
     latitude= locationData.latitude;

   }
   catch(e){
     print(e);
   }
 }
}