//import 'package:blood_donation/historique_don.dart';
//import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfe/Views/Trouver_donneur/ConsulterEtCherherD.dart';
import 'package:pfe/cartmapsConsulterAnnonces.dart';
//import 'package:blood_donation/Views/Trouver_donneur/publierAnnonce.dart';
//import 'package:blood_donation/annonce_filtre.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/annonce.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/notificationsTest.dart';
//import 'package:blood_donation/models/utilisateur.dart';
import 'package:pfe/tools/card_post.dart';
import 'package:pfe/tools/choix_don.dart';
import 'package:flutter/material.dart';
import 'package:pfe/tools/choix_trouverdon.dart';
//import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  final Utilisateur? utilisateur;
  Homepage({super.key, required this.utilisateur});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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

  var user;
  Utilisateur? utilisateur;
  String? don;
  List<Annonce> annonces = [];
  bool waiting = true;
  List<Marker> lista = [];
  currentUser() async {
    user = FirebaseAuth.instance.currentUser;
    print("==============email================");
    String email = user.email;
    print(email);
    var userData = await getOneDataDjango(urlSite, email, 'getUser/');
    utilisateur = Utilisateur.fromJson(userData);
    print(utilisateur!.id);
    print(utilisateur!.nom);
    setState(() {});
  }

  Listannonce() async {
    var Data = await getDataDjango(
        urlSite, 'getAllAnnounces/${widget.utilisateur!.id}');
    print(Data);
    annonces = convertirListeAnnonces(Data);
    waiting = false;
    setState(() {});
  }

  /* void maj_fenetre(context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return choix();
          });
        });
  }  */
  @override
  void initState() {
    super.initState();
    // currentUser();
    Listannonce();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink, primaryColor: Colors.pink),
      home: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     getToken();
        //   },
        // ),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 220, 0, 59),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 40,
              ),
              Icon(
                Icons.bloodtype,
                color: Colors.white,
              ),
              const Text(
                "iDonate",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  Position position = await _determinePosition();

                  if (annonces.isNotEmpty) {
                    for (var annonce in annonces) {
                      if (annonce.latitude != null) {
                        Marker marker = Marker(
                            markerId: MarkerId("${annonce.latitude}"),
                            position:
                                LatLng(annonce.latitude!, annonce.longitude!),
                            infoWindow: InfoWindow(
                                title:
                                    "${annonce.utilisateur.nom} ${annonce.utilisateur.prenom} besoin ${annonce.groupSanguin}",
                                snippet: annonce.numeroTelephone != null
                                    ? "num tel : ${annonce.numeroTelephone}"
                                    : "num tel : non disponible"));
                        lista.add(marker);
                      }
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ConsulterAnnoncesmaps(
                        markers: lista,
                        init: position,
                      ),
                    ));
                  }
                },
                icon: Icon(
                  Icons.location_on,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: Color.fromARGB(255, 248, 235, 240),
        body: waiting == false
            ? ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    height: 70,
                    color: Color.fromARGB(255, 220, 0, 59),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              // maj_fenetre(context);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return choix(
                                      annonces: annonces,
                                      utilisateur: widget.utilisateur!,
                                    );
                                  });
                            },
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Color.fromARGB(255, 249, 224, 226),
                            ),
                            child: Text(
                              "Donner sang",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                        TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return choix_trouverdonneur(
                                        utilisateur: widget.utilisateur!);
                                  });
                            },
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Color.fromARGB(255, 249, 224, 226),
                            ),
                            child: Text(
                              "Trouver donneur",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ))
                      ],
                    ),
                  ),
                  /* RefreshIndicator(
                onRefresh: () => Listannonce(),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: annonces.length,
                    itemBuilder: (context, i) {
                      return Card_cust(
                        name:
                            "${annonces[i].utilisateur.nom} ${annonces[i].utilisateur.prenom}",
                        blood: annonces[i].groupSanguin,
                        day: annonces[i].dateDeDonMax?.day,
                        month: annonces[i].dateDeDonMax?.month,
                        year: annonces[i].dateDeDonMax?.year,
                        day_p: annonces[i].dateDePublication?.day,
                        month_p: annonces[i].dateDePublication?.month,
                        year_p: annonces[i].dateDePublication?.year,
                        adress: annonces[i].place,
                        numtel: annonces[i].numeroTelephone,
                        description: annonces[i].description,
                      );
                    })), */

                  ...List.generate(
                    annonces.length,
                    (i) {
                      return Card_cust(
                        name:
                            "${annonces[i].utilisateur.nom!} ${annonces[i].utilisateur.prenom!}",
                        blood: annonces[i].groupSanguin,
                        day: annonces[i].dateDeDonMax?.day,
                        month: annonces[i].dateDeDonMax?.month,
                        year: annonces[i].dateDeDonMax?.year,
                        day_p: annonces[i].dateDePublication?.day,
                        month_p: annonces[i].dateDePublication?.month,
                        year_p: annonces[i].dateDePublication?.year,
                        adress: annonces[i].place,
                        numtel: annonces[i].numeroTelephone,
                        description: annonces[i].description,
                        utilisateur: widget.utilisateur,
                        id: annonces[i].utilisateur.id,
                        etatdemande: annonces[i].etatdemande,
                        typedon: annonces[i].type_de_don,
                        latitude: annonces[i].latitude,
                        longitude: annonces[i].longitude,
                      );
                    },
                  )

                  /*Card_cust(
                name: "maya", blood: "B+", date: "27082002", adress: "alger"), */
                  //
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
