import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CartMaps extends StatefulWidget {
  final Position? initial;
  final List<Location>? locations;
  const CartMaps({super.key, this.initial, this.locations});

  @override
  State<CartMaps> createState() => CartMapsState();
}

class CartMapsState extends State<CartMaps> {
  List<Marker> maposition = [
    // Marker(
    //   markerId: MarkerId("position"),
    // )
  ];
  @override
  void initState() {
    if (widget.initial != null) {
      maposition.add(Marker(
          markerId: MarkerId("maposition"),
          position:
              LatLng(widget.initial!.latitude, widget.initial!.longitude)));
    }
    // for (var element in widget.locations!) {
    //   maposition.add(Marker(
    //       markerId: MarkerId("${element.latitude}"),
    //       position: LatLng(element.latitude, element.longitude)));
    // }
    super.initState();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.627558, 3.048160),
    zoom: 5.2,
  );
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: maposition.isNotEmpty
          ? FloatingActionButton(
              onPressed: () async {
                await AwesomeDialog(
                  context: context,
                  transitionAnimationDuration: Duration(seconds: 1),
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: 'Position prise',
                  descTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  //autoHide: Duration(seconds: 2)
                ).show();
                Navigator.of(context).pop(maposition[0].position);
              },
              child: Icon(
                Icons.check_outlined,
                color: Colors.white,
              ),
              backgroundColor: Color.fromARGB(255, 220, 0, 59),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Changez cette couleur selon vos besoins
        ),
        backgroundColor: Color.fromARGB(255, 220, 0, 59),
        title: Text(
          "choisissez votre localisation",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                markers: maposition.toSet(),
                onTap: (argument) {
                  if (maposition.isNotEmpty) maposition.removeAt(0);
                  maposition.add(Marker(
                      markerId: MarkerId("maposition"),
                      position: LatLng(argument.latitude, argument.longitude)));

                  setState(() {});
                },
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
