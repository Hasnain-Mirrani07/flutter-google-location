// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// const String P_LATITUDE = "latitude";
// const String P_LONGITUDE = "longitude";
// String P_Address = "address";

// class GetLocation {
//   String location = 'Null, Press Button';

//   static Future<Position> getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   static Future<String> GetAddressFromLatLong(position) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     print(placemarks);
//     Placemark place = placemarks[0];
//     P_Address =
//         '${place.street},${place.subLocality},${place.locality},${place.country}';

  

//     //from coordinateds to adress
//     // final coordinates = Coordinates(position.latitude, position.longitude);
//     // final addresses =
//     //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     // final first = addresses.first;
//     print(" current adress  =>$P_Address:");

//     // var box = Hive.box("hivebox");
//     // box.put("currentAdr", currentAdr);
//     // print("current adress  =>${placemarks[0]}");
//     // ' ${place.postalCode},
//     //   '${place.subLocality};
//     // P_Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
//     // log("address $P_Address");
//     return P_Address;
//   }

//   static DistanceInMeters(double a, double b, double x, double z) {
//     return Geolocator.distanceBetween(a, b, x, z);
//   }
// }
