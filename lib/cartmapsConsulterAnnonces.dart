import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConsulterAnnoncesmaps extends StatefulWidget {
  final Position? init;
  final Position? maposition;
  final String? nom;
  final String? gs;
  final int? numtel;
  final LatLng? dest;
  final List<LatLng>? listdest;
  final List<Marker>? markers;

  ConsulterAnnoncesmaps(
      {super.key,
      this.maposition,
      this.dest,
      this.listdest,
      this.nom,
      this.numtel,
      this.gs,
      this.markers,
      this.init});

  @override
  State<ConsulterAnnoncesmaps> createState() => ConsulterAnnoncesmapsState();
}

class ConsulterAnnoncesmapsState extends State<ConsulterAnnoncesmaps> {
  List<Marker> markers = [];

  @override
  void initState() {
    if (widget.markers != null) {
      markers = widget.markers!;
    }
    if (widget.dest != null) {
      markers.add(Marker(
        infoWindow: InfoWindow(
            title: "${widget.nom} besoin ${widget.gs}",
            snippet: "numero tel : ${widget.numtel}"),
        markerId: MarkerId("1"),
        position: LatLng(
          widget.dest!.latitude,
          widget.dest!.longitude,
        ),
      ));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: GoogleMap(
              markers: markers.toSet(),
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(36.49349291361419, 3.156034286106686),
                zoom: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
