import 'dart:async';
import 'dart:convert';

//import 'package:blood_donation/api/location.dart';
//import 'package:blood_donation/tools/bottom_navigation_bar.dart';
//import 'package:blood_donation/tools/card_post.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' show parse;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class maps extends StatefulWidget {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.720357, 3.048924),
    zoom: 10,
  );
  maps({super.key});

  @override
  State<maps> createState() => _mapsState();
}

class _mapsState extends State<maps> {
  Location location = Location();
  List<Marker> markers = [];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> loadOverpassData() async {
    String overpassUrl =
        'https://overpass-api.de/api/interpreter?data=%2F*%0AThis%20has%20been%20generated%20by%20the%20overpass-turbo%20wizard.%0AThe%20original%20search%20was%3A%0A%E2%80%9Camenity%20%3D%20hospital%20in%20algeria%E2%80%9D%0A*%2F%0A%5Bout%3Ajson%5D%5Btimeout%3A25%5D%3B%0A%2F%2F%20fetch%20area%20%E2%80%9Calgeria%E2%80%9D%20to%20search%20in%0Aarea%28id%3A3600192756%29-%3E.searchArea%3B%0A%2F%2F%20gather%20results%0Anwr%5B%22amenity%22%3D%22hospital%22%5D%5B%22name%22~%22%5EH%C3%B4pital%22%5D%28area.searchArea%29%3B%0A%2F%2F%20print%20results%0Aout%20geom%3B';

    var response = await http.get(Uri.parse(overpassUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> elements = data['elements'];

      elements.forEach((element) {
        if (element['lat'] != null && element['lon'] != null) {
          double latitude = element['lat'];
          double longitude = element['lon'];
          String name = element['tags']['name'] ?? 'Unknown Hospital';

          Marker marker = Marker(
            markerId: MarkerId(name),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: name,
            ),
          );

          markers.add(marker);
        }
      });

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadOverpassData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 134, 183, 246),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(
                  context); // Revenir en arrière lorsque la flèche est pressée
            },
          ),
          title: Text(
            'Carte Google',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          // height: 400,

          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: maps._kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              location._determinePosition();
            },
            markers: markers.toSet(),

// Convertir la liste en ensemble de marqueurs
          ),
        ));
  }
}

class Location {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

class Hospital {
  final String name;
  final String url;
  String? coordinates;

  Hospital({required this.name, required this.url, this.coordinates});
}
