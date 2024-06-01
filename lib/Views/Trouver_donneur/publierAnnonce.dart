//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfe/Views/authentification/dialogueGroupeSanguin.dart';
import 'package:pfe/cartmaps.dart';
import 'package:pfe/compenments/textformfieldA.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/annonce.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/tools/bottom_navigation_bar.dart';

class PublierAnnonce extends StatefulWidget {
  final Annonce? annonce;
  final Utilisateur utilisateur;
  const PublierAnnonce({super.key, required this.utilisateur, this.annonce});

  @override
  State<PublierAnnonce> createState() => PublierAnnoncePage();
}

class PublierAnnoncePage extends State<PublierAnnonce> {
  DateTime? selectedDate;
  TextEditingController placeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController numtelController = TextEditingController();
  TextEditingController groupsanguinController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

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

  String? typedon;
  String? numAffich;
  Placemark? address;
  LatLng? lating;

  @override
  void initState() {
    if (widget.annonce != null) {
      placeController.text = widget.annonce!.place!;
      descriptionController.text = widget.annonce!.description;
      numtelController.text = widget.annonce!.numeroTelephone!.toString();
      groupsanguinController.text = widget.annonce!.groupSanguin;
      selectedDate = widget.annonce!.dateDeDonMax;
      typedon = widget.annonce!.type_de_don;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          var list = await getDataDjango(urlSite, 'getAllAnnounces/');
          List<Annonce> listAnnonce = convertirListeAnnonces(list);
          print("==========List returned=======");
          print(listAnnonce[0].description);
        },
      ), */
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Publier Annonce"),
        backgroundColor: Color.fromARGB(255, 220, 0, 59),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              height: 17,
            ),
            // Text(
            //   "Publier une annonce",
            //   textAlign: TextAlign.start,
            //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            // ),
            // Text(
            //   "Creer et publier votre annonce de besoin de sang",
            //   textAlign: TextAlign.start,
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            Form(
                child: Column(
              children: [
                Text(
                  "Quel type de Don avez-vous besoin ? ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Column(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          activeColor: Colors.red,
                          title: Text(
                            "Plaquettes",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          value: "plaquette",
                          groupValue: typedon,
                          onChanged: (value) {
                            typedon = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          activeColor: Colors.red,
                          title: Text(
                            "Plasma",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          value: "plasma",
                          groupValue: typedon,
                          onChanged: (value) {
                            typedon = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          activeColor: Colors.red,
                          title: Text(
                            "Sang globale",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          value: "sang",
                          groupValue: typedon,
                          onChanged: (value) {
                            typedon = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choisissiez le type du sang ?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: GroupeSanguin(),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                setState(() {});
                                groupsanguinController.text = v!;
                                print(groupsanguinController.text);

                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Valider",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              color: Color(0xFFd20000),
                              textColor: Colors.white,
                              height: 50,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: AbsorbPointer(
                    absorbing:
                        true, // Désactiver l'interaction avec le TextFormField
                    child: TextForm(
                        textEditingController: groupsanguinController,
                        label: v == null
                            ? "Groupe sanguin"
                            : groupsanguinController.text,
                        i: Icon(
                          Icons.bloodtype,
                          color: Color.fromARGB(255, 220, 0, 59),
                        )),
                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Voulez-vous afficher votre Numero de telephone dans l'annonce ?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                RadioListTile(
                  activeColor: Color.fromARGB(255, 220, 0, 59),
                  title: Text(
                    "Oui",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  value: "affiche",
                  groupValue: numAffich,
                  onChanged: (value) {
                    numAffich = value;
                    setState(() {});
                  },
                ),
                RadioListTile(
                  activeColor: Color.fromARGB(255, 220, 0, 59),
                  title: Text(
                    "Non",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  value: "Naffiche",
                  groupValue: numAffich,
                  onChanged: (value) {
                    numAffich = value;
                    setState(() {});
                  },
                ),
              ],
            )),
            Container(
              height: 20,
            ),

            if (numAffich == 'affiche')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Numero de telephone ?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Container(
                    height: 8,
                  ),
                  TextForm(
                      textEditingController: numtelController,
                      label: "numero tel",
                      i: Icon(Icons.phone)),
                  Container(
                    height: 20,
                  ),
                ],
              ),
            Text(
              "Ajoutez une description : (facultative)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              height: 8,
            ),
            TextForm(
                textEditingController: descriptionController,
                label: "description",
                i: Icon(Icons.description)),
            Container(
              height: 20,
            ),
            Text(
              "Endroit :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              height: 8,
            ),
            TextForm(
                textEditingController: placeController,
                label: "willaya",
                i: Icon(Icons.location_city)),
            Container(
              height: 20,
            ),
            Text(
              "voulez-vouz ajouter une position précise sur la carte ? ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              height: 8,
            ),
            GestureDetector(
              onTap: () async {
                Position position = await _determinePosition();
                print(position.longitude);

                lating = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CartMaps(initial: position),
                  ),
                );
                print("=============");
                print(lating);

                List<Placemark> placemarks = await placemarkFromCoordinates(
                    lating!.latitude, lating!.longitude);
                address = placemarks[0];
                print(address!.locality);
                print(address!.name);
                print(address!.administrativeArea);
                setState(() {});
              },
              child: AbsorbPointer(
                absorbing:
                    true, // Désactiver l'interaction avec le TextFormField
                child: TextForm(
                    label: address == null
                        ? "localisation"
                        : "${address!.locality}" + ", ${address!.name}",
                    i: Icon(
                      Icons.location_on_sharp,
                    )),
              ),
            ),
            Container(
              height: 25,
            ),
            Text(
              "Date de Don au maximum :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: AbsorbPointer(
                absorbing:
                    true, // Désactiver l'interaction avec le TextFormField
                child: TextForm(
                    label: selectedDate == null
                        ? "Date"
                        : "${selectedDate!.toLocal()}".split(' ')[0],
                    i: Icon(
                      Icons.date_range,
                    )),
              ),
            ),
            Container(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60),
              child: MaterialButton(
                onPressed: () {
                  print(selectedDate);
                  Annonce annonce;
                  if (numtelController.text != '') {
                    annonce = Annonce(
                        utilisateur: widget.utilisateur,
                        type_de_don: typedon,
                        description: descriptionController.text,
                        groupSanguin: groupsanguinController.text,
                        dateDeDonMax: selectedDate,
                        numeroTelephone: int.parse(numtelController.text),
                        place: placeController.text,
                        latitude: lating != null ? lating!.latitude : null,
                        longitude: lating != null ? lating!.longitude : null);
                  } else {
                    annonce = Annonce(
                        utilisateur: widget.utilisateur,
                        type_de_don: typedon,
                        description: descriptionController.text,
                        groupSanguin: groupsanguinController.text,
                        dateDeDonMax: selectedDate,
                        place: placeController.text,
                        latitude: lating != null ? lating!.latitude : null,
                        longitude: lating != null ? lating!.longitude : null);
                  }
                  if (widget.annonce == null) {
                    print(annonce.toJson());
                    addDataDjango(annonce.toJson(), urlSite,
                        'createAnounce/${widget.utilisateur.id}');
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => Bottom_navigation_bar(),
                        ),
                        (route) => false);
                  } else {
                    print(annonce.toJson());
                    updateDataDjango(annonce.toJson(), urlSite,
                        'updateAnnounce/', widget.annonce!.id.toString());
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  "Publier",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                color: Color.fromARGB(255, 220, 0, 59),
                textColor: Colors.white,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
