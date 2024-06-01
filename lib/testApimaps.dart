import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _fetchBloodDonationPlaces();
  }

  Future<void> _fetchBloodDonationPlaces() async {
    String apiKey = 'AIzaSyBOexVU9oAkKzCnq0U2Gs8hVz_-QOZ39x0';
    String url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=36.7525,3.04197' // Coordonnées du centre d'Alger
        '&radius=50000' // Rayon de recherche en mètres
        '&types=hospital' // Types de lieux pertinents pour la donation de sang
        // Mot-clé pour la recherche spécifique
        '&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> results = data['results'];

      List<Marker> markers = results.map((result) {
        return Marker(
          markerId: MarkerId(result['place_id']),
          position: LatLng(
            result['geometry']['location']['lat'],
            result['geometry']['location']['lng'],
          ),
          infoWindow: InfoWindow(
            title: result['name'],
            snippet: result['vicinity'],
          ),
        );
      }).toList();

      setState(() {
        _markers = markers;
      });
    } else {
      throw Exception('Failed to load blood donation places');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Changez cette couleur selon vos besoins
        ),
        title: Text(
          'Les centres de dons',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 220, 0, 59),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(36.7525, 3.04197),
          zoom: 10,
        ),
        markers: Set<Marker>.of(_markers),
      ),
    );
  }
}
