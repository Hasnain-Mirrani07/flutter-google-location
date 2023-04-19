// import 'dart:async';
// import 'dart:convert';

// import 'package:delivery_app/src/widgets/custom_app_bar.dart';
// import 'package:delivery_app/src/widgets/custom_button.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:hive/hive.dart';
// import 'package:provider/provider.dart';

// import '../../../provider/sender_providers/location_provider.dart';
// import '../../../utils/app_colors.dart';
// import '../../../utils/asset_images.dart';
// import '../../../utils/constants.dart';
// import 'component/searchL_location_reveiver.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// import 'google_search_places_api.dart';

// class SenderLocationSelector extends StatefulWidget {
//   const SenderLocationSelector({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<SenderLocationSelector> createState() => _SenderLocationSelectorState();
// }

// class _SenderLocationSelectorState extends State<SenderLocationSelector> {
//   String address1 = 'sender';
//   String address2 = 'receiver';
//   final Completer<GoogleMapController> _controller = Completer();

//   Future<Position> _getUserCurrentLocation() async {
//     await Geolocator.requestPermission()
//         .then((value) {})
//         .onError((error, stackTrace) {
//       print(error.toString());
//     });

//     return await Geolocator.getCurrentPosition();
//   }

//   final List<Marker> _markers = <Marker>[];

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(33.6844, 73.0479),
//     zoom: 14,
//   );
//   LatLng origin = const LatLng(123, 123);
//   allMarkers(
//     double startLat,
//     double startLong,
//     double endtLat,
//     double endLong,
//   ) async {
//     print(
//         "Marker Funct click  start lat=$startLat lng=$startLong endlat  $endtLat  end lng $endLong");
//     _markers.add(Marker(
//         markerId: const MarkerId('1'),
//         position: LatLng(startLat, startLong),
//         infoWindow: InfoWindow(title: address1)));
//     _markers.add(Marker(
//         markerId: const MarkerId('2'),
//         position: LatLng(endtLat, endLong),
//         infoWindow: InfoWindow(title: address2)));

//     polylineList.add(
//       Polyline(
//           polylineId: const PolylineId("polylineId"),
//           color: Colors.red,
//           width: 3,
//           points: points!
//               .map((point) => LatLng(point.latitude, point.longitude))
//               .toList()),
//     );
//     final GoogleMapController controller = await _controller.future;
//     CameraPosition kGooglePlex = CameraPosition(
//       target: LatLng(startLat, startLong),
//       zoom: 14,
//     );
//     controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
//     setState(() {});
//   }

//   loadData() {
//     _getUserCurrentLocation().then((value) async {
//       // _markers.add(Marker(
//       //     markerId: const MarkerId('current location'),
//       //     position: LatLng(value.latitude, value.longitude),
//       //     infoWindow: const InfoWindow(title: "My Current Location")));

//       final GoogleMapController controller = await _controller.future;
//       CameraPosition kGooglePlex = CameraPosition(
//         target: LatLng(value.latitude, value.longitude),
//         zoom: 14,
//       );
//       controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));

//       setState(() {});
//     });
//   }

//   String senderAdress = '';
//   String receiverAdress = '';

//   // double senderLat = 0.0;
//   // double senderLong = 0.0;
//   // double receiverLat = 0.0;
//   // double receiverLong = 0.0;
//   var box = Hive.box("hivebox");

//   //Data Get from search places Api
//   void hiveinit() async {
//     senderAdress = await box.get("adress1");
//     receiverAdress = await box.get("adress2") ?? "";
//     // senderLat = await box.get("senderLat");
//     // senderLong = await box.get("senderLong");
//     // receiverLat = await box.get("receiverLat");
//     // receiverLong = await box.get("receiverLong");
//     // origin = await box.get("location");
//   }

//   @override
//   void initState() {
//     loadData();
//     hiveinit();

//     super.initState();
//   }

//   List<Polyline> polylineList = [];

//   @override
//   Widget build(BuildContext context) {
//     final locationProvider = Provider.of<LocationProvider>(context);

//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Location Selection',
//       ),
//       body: Container(
//         padding: const EdgeInsets.only(left: 0),
//         height: h,
//         width: w,
//         child: Stack(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height * .7,
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(40)),
//               child: GoogleMap(
//                 onTap: (argument) => loadData(),
//                 buildingsEnabled: true,
//                 compassEnabled: true,
//                 polylines: Set.of(polylineList),
//                 mapType: MapType.normal,
//                 initialCameraPosition: _kLake,
//                 markers: Set<Marker>.of(_markers),
//                 onMapCreated: (GoogleMapController controller) {
//                   _controller.complete(controller);
//                 },
//               ),
//             ),

//             Positioned(
//               left: 20,
//               top: 20,
//               child: SizedBox(
//                 width: w * 0.9,
//                 height: 130,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 0),
//                   child: Container(
//                     padding: const EdgeInsets.only(left: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Stack(children: [
//                       Positioned(
//                         left: 4,
//                         top: 13,
//                         child: Image.asset(
//                           AssetImages.MY_LOCATION,
//                           height: 14,
//                           width: 14,
//                         ),
//                       ),
//                       const Positioned(
//                         left: 10,
//                         top: 34,
//                         child: DottedLine(
//                           direction: Axis.vertical,
//                           dashLength: 4,
//                           lineThickness: 1.5,
//                           dashColor: AppColors.SCAFFOLD_COLOR,
//                           lineLength: 50,
//                         ),
//                       ),
//                       Positioned(
//                         left: 4,
//                         bottom: 30,
//                         child: Image.asset(
//                           AssetImages.YOUR_LOCATION,
//                           height: 15,
//                           width: 15,
//                         ),
//                       ),
//                       Positioned(
//                         left: 35,
//                         top: 10,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const GoogleSearchPlacesApi()),
//                             );
//                           },
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 overflow: TextOverflow.ellipsis,
//                                 senderAdress == ''
//                                     ? '88 Zurab Gorgiladze St'
//                                     : senderAdress,
//                                 style: Theme.of(context).textTheme.bodyLarge,
//                               ),
//                               const SizedBox(
//                                 height: 7,
//                               ),
//                               Text(
//                                 overflow: TextOverflow.ellipsis,
//                                 senderAdress == ''
//                                     ? 'Georgia, Batumi'
//                                     : senderAdress,
//                                 style: Theme.of(context).textTheme.bodyMedium,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         left: 35,
//                         bottom: 10,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const SearchLocationReveiver()),
//                             );
//                           },
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 receiverAdress == ''
//                                     ? '5 Noe Zhordania St'
//                                     : receiverAdress,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: Theme.of(context).textTheme.bodyLarge,
//                               ),
//                               const SizedBox(
//                                 height: 7,
//                               ),
//                               Text(
//                                 overflow: TextOverflow.ellipsis,
//                                 receiverAdress == ''
//                                     ? '5 Noe Zhordania St'
//                                     : receiverAdress,
//                                 style: Theme.of(context).textTheme.bodyMedium,
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ]),
//                   ),
//                 ),
//               ),
//             ),
//             // Positioned(
//             //     bottom: 100,
//             //     // right: 0,
//             //     width: w,
//             //     // left: w * 0.1,

//             //     child: Center(
//             //       child: Container(
//             //         width: w * 0.6,
//             //         // alignment: Alignment.center,
//             //         padding: const EdgeInsets.only(
//             //             top: 5, bottom: 5, left: 15, right: 15),
//             //         decoration: BoxDecoration(
//             //           color: AppColors.WHITE_COLOR,
//             //           borderRadius: BorderRadius.circular(5),
//             //         ),
//             //         child: Row(
//             //           mainAxisAlignment: MainAxisAlignment.center,
//             //           children: [
//             //             Container(
//             //               height: 10,
//             //               width: 10,
//             //               decoration: const BoxDecoration(
//             //                 color: Color(0xffEB5757),
//             //                 shape: BoxShape.circle,
//             //               ),
//             //             ),
//             //             const SizedBox(
//             //               width: 5,
//             //             ),
//             //             Expanded(
//             //               child: RichText(
//             //                 text: const TextSpan(
//             //                   text: 'Busy Area with ',
//             //                   style: TextStyle(
//             //                       fontWeight: FontWeight.w500,
//             //                       fontSize: 14,
//             //                       color: Color(0xff616161)),
//             //                   children: <TextSpan>[
//             //                     TextSpan(
//             //                         text: 'x1.3 ',
//             //                         style: TextStyle(
//             //                             fontWeight: FontWeight.w700,
//             //                             fontSize: 14,
//             //                             color: AppColors.SCAFFOLD_COLOR)),
//             //                     TextSpan(
//             //                       text: 'Factor',
//             //                       style: TextStyle(
//             //                           fontWeight: FontWeight.w500,
//             //                           fontSize: 14,
//             //                           color: Color(0xff616161)),
//             //                     ),
//             //                   ],
//             //                 ),
//             //               ),
//             //             ),

//             //           ],
//             //         ),
//             //       ),
//             //     )),

//             Positioned(
//               bottom: 30,
//               right: 0,
//               left: 0,
//               child: CustomButton(
//                   // marginLeft: 25,

//                   onPress: () {
//                     var maxDistance =
//                         int.parse("${box.get("maxDistanceAllowedInKm")}");

//                     if (senderAdress != '' && receiverAdress != '') {
//                       //convert distance string to double
//                       var extracted =
//                           distance.replaceAll(RegExp(r'[^0-9-.]'), '');
//                       extractedDistance = double.parse(extracted.toString());

//                       if (extractedDistance > maxDistance) {
//                         customSnackBar(context,
//                             "Distance exceds limit dilevery Not be possibile ");
//                       } else {
//                         Constants.senderMainNavKey.currentState
//                             ?.pushNamed('/senderRecieverAddressInfo');
//                       }
//                     } else {}
//                     setState(() {});
//                   },
//                   text: 'Next'),
//             ),

//             Positioned(
//               top: h * .68,
//               child: FloatingActionButton.extended(
//                 onPressed: () async {
//                   var currentLocation = box.get("currentAdr");
//                   loadData();
//                   await directions(currentLocation);
//                   allMarkers(
//                     startlat,
//                     startlng,
//                     endtlat,
//                     endlng,
//                   );

//                   setState(() {});
//                 },
//                 label: const Text('My Current Location'),
//                 icon: const Icon(Icons.location_searching_sharp),
//               ),
//             ),
//             Positioned(
//               top: h * .6,
//               child: FloatingActionButton.extended(
//                 onPressed: () async {
//                   await directions(senderAdress);
//                   // print("function click  start lat=$startlat lng=$startlng ");

//                   allMarkers(
//                     startlat,
//                     startlng,
//                     endtlat,
//                     endlng,
//                   );

//                   setState(() {});
//                 },
//                 label: const Text('Lets Start '),
//                 icon: const Icon(Icons.location_searching_sharp),
//               ),
//             ),
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton.extended(
//       //   onPressed: _goToTheLake,
//       //   label: const Text('To the lake!'),
//       //   icon: const Icon(Icons.directions_boat),
//       // ),
//     );
//   }

//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(28.668977299999998, 77.22930819999999),
//       tilt: 59.440717697143555,
//       zoom: 5);

// //polylines
//   double startlat = 1;
//   double startlng = 1;
//   double endtlat = 1;
//   double endlng = 1;
//   String distance = '';
//   double extractedDistance = 1.0;
//   List<PointLatLng>? points;
//   PolylinePoints polylinePoints = PolylinePoints();
//   Future<void> directions(senderAdr) async {
//     print("sender adress =>$senderAdr  reciver adress =>$receiverAdress");

//     //API method call
//     String kplacesApiKey = "AIzaSyD5VL5sp3UUsOJgl8BvLWJrjw-uIGspu7w";
//     String baseURL = 'https://maps.googleapis.com/maps/api/directions/json';
//     String request =
//         '$baseURL?destination=$receiverAdress&origin=$senderAdr&key=$kplacesApiKey';
//     var response = await http.get(Uri.parse(request));
//     var data = json.decode(response.body);
//     print("directions ========> $data");

// //list of points for dynamic and curve polylines not straight
//     points = polylinePoints
//         .decodePolyline(data['routes'][0]['overview_polyline']['points']);

//     startlat = points!.first.latitude;
//     startlng = points!.first.longitude;
//     endtlat = points!.last.latitude;
//     endlng = points!.last.longitude;
//     distance = data['routes'][0]['legs'][0]['distance']['text'];
//     await dataStore(senderAdr);
//     print(
//         "distance ==> $distance \n Marker init =>point sender lat/lng $startlat/$startlat  reviver lat/lng=> $endtlat/$endlng  ===== \n list of Points=> $points ========= ");

//     //Convert distance from String to Double // for apply on Check

//     var Map = {
//       'senderAdress': 'senderadress',
//       'receiverAdress': 'receiveradress',
//       'senderlat': 'senderlat',
//       'senderlng': 'senderlng',
//       'receiverlat': 'receiverlat',
//       'receiverlng': 'receiverlng',
//       'senderName': 'sendername',
//       'senderMobileCode': '+123',
//       'senderMobileNo': '123456789',
//       'receiverName': 'receiverName',
//       'receiverMobileCode': '+123',
//       'receiverMobileNo': '123456789',
//       'modeOfTransport': 'bike',
//       'images': ['list of string', 'list of string', 'list of string'],
//       'date': '1/2/2023',
//       'time': '13.15 pm',
//       'instruction': 'abcabc abc abcabce',
//       'currentlocation': 'currentlocation',
//       'distance': 'distance',
//       'total_bill': 'total_bill',
//     };
//   }

//   dataStore(senderAdr) async {
//     await box.put("senderAdress", senderAdr);
//     await box.put("receiverAdress", receiverAdress);
//     await box.put("senderLat", startlat);
//     await box.put("senderLong", startlng);
//     await box.put("receiverLat", endtlat);
//     await box.put("receiverLong", endlng);
//     await box.put("distance", distance);
//   }
// }
