// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;

// import '../../../utils/app_colors.dart';
// import '../../../utils/constants.dart';

// class GoogleSearchPlacesApi extends StatefulWidget {
//   const GoogleSearchPlacesApi({super.key});

//   @override
//   _GoogleSearchPlacesApiState createState() => _GoogleSearchPlacesApiState();
// }

// class _GoogleSearchPlacesApiState extends State<GoogleSearchPlacesApi> {
//   final _controller = TextEditingController();
//   var uuid = const Uuid();
//   String _sessionToken = '1234567890';
//   List<dynamic> _placeList = [];

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       _onChanged();
//     });
//   }

//   _onChanged() {
//     if (_sessionToken == null) {
//       setState(() {
//         _sessionToken = uuid.v4();
//       });
//     }
//     getSuggestion(_controller.text);
//   }

//   void getSuggestion(String input) async {
//     String kplacesApiKey = "AIzaSyD5VL5sp3UUsOJgl8BvLWJrjw-uIGspu7w";
//     String type = '(regions)';

//     try {
//       String baseURL =
//           'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//       String request =
//           '$baseURL?input=$input&key=$kplacesApiKey&sessiontoken=$_sessionToken';
//       var response = await http.get(Uri.parse(request));
//       var data = json.decode(response.body.toString());
//       print(data);
//       print('mydata');
//       if (response.statusCode == 200) {
//         setState(() {
//           _placeList = json.decode(response.body)['predictions'];
//           print(" disppppp  ${_placeList[0]['description']}");
//         });
//       } else {
//         throw Exception('Failed to load predictions');
//       }
//     } catch (e) {
//       // toastMessage('success');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         shadowColor: AppColors.WHITE_COLOR,
//         foregroundColor: AppColors.FULL_BLACK,
//         backgroundColor: AppColors.WHITE_COLOR,
//         elevation: 0,
//         title: const Text(
//           'Google Map Search places ',
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Align(
//               alignment: Alignment.topCenter,
//               child: TextField(
//                 controller: _controller,
//                 decoration: InputDecoration(
//                   focusedBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                       borderSide: BorderSide(
//                         color: AppColors.SCAFFOLD_COLOR,
//                       )),
//                   hintText: "Seek your location here",
//                   fillColor: AppColors.SCAFFOLD_COLOR,
//                   focusColor: AppColors.SCAFFOLD_COLOR,
//                   floatingLabelBehavior: FloatingLabelBehavior.never,
//                   prefixIcon: const Icon(
//                     Icons.map,
//                     color: AppColors.SCAFFOLD_COLOR,
//                   ),
//                   suffixIcon: IconButton(
//                     icon: const Icon(
//                       Icons.cancel,
//                       color: AppColors.SCAFFOLD_COLOR,
//                     ),
//                     onPressed: () {
//                       _controller.clear();
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: _placeList.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () async {
//                       List<Location> locations = await locationFromAddress(
//                           _placeList[index]["description"]);
//                       var box = Hive.box("hivebox");
//                       var a = _placeList[index]["description"];
//                       box.put('adress1', a);
                     
//                       box.put("location", locations);

//                       // var adress1 = box.get("adress1");
//                       // print("location ${locations.last.latitude}");
//                       // print("location ${locations.last.longitude}");
//                       // print(adress1);
//                       Constants.senderMainNavKey.currentState
//                           ?.pushNamedAndRemoveUntil('/senderLocationSelector',
//                               (Route<dynamic> route) => false);

//                       setState(() {});
//                     },
//                     child: ListTile(
//                       title: Text(_placeList[index]["description"]),
//                       //   trailing: Text(P_Address),
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
