import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfe/cartmapsConsulterAnnonces.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/demandeClass.dart';
import 'package:pfe/models/tokens.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/notificationsTest.dart';
import 'package:url_launcher/url_launcher.dart';

class Card_cust extends StatefulWidget {
  final String? name, blood, adress, description, typedon;
  int? numtel;
  bool? choice;
  String? etatdemande;
  final int? id;
  void Function()? onPressed;
  final Utilisateur? utilisateur;
  final double? latitude, longitude;
  final int? year, month, day; //date de don
  final int? year_p, month_p, day_p; //date de publication
  Card_cust({
    //super.key,
    this.choice,
    this.id,
    this.onPressed,
    required this.name,
    required this.blood,
    required this.adress,
    this.numtel,
    this.description,
    this.year,
    this.month,
    this.day,
    this.year_p,
    this.month_p,
    this.day_p,
    this.utilisateur,
    this.etatdemande,
    required this.typedon,
    this.latitude,
    this.longitude,
  });

  @override
  State<Card_cust> createState() => Card_custj();
}

class Card_custj extends State<Card_cust> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    testui();
  }

  int i = 0;
  testui() {
    if (widget.etatdemande == 'Accepté') i++;
    if (widget.numtel == null) i++;
    if (widget.longitude == null) i++;
    if (widget.id == widget.utilisateur!.id) i++;
    setState(() {});
  }

  void appelerNumero(int numero) async {
    Uri url = Uri.parse('tel:0$numero');
    // if (await canLaunchUrl(url)) {
    await launchUrl(url);
    //} else {
    //throw 'Impossible de lancer $url';
    //}
  }

  bool pressed = false;
  String etatDemande = "demander";
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      color: Color.fromARGB(255, 241, 230, 231),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, top: 10, left: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.name}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${widget.blood}",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 220, 0, 59),
                  ),
                ),
              ],
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                              "Publié le : ${widget.day_p}-${widget.month_p}-${widget.year_p}",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          if (widget.description != null) ...[
                            Text(
                              "${widget.description}",
                            ),
                          ],
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 18,
                            color: Colors.grey[600],
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Endroit : ${widget.adress}",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 18,
                            color: Colors.grey[600],
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Date de don : ${widget.day}-${widget.month}-${widget.year}",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.typedon}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 220, 0, 59),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: 0.9,
                      color: Colors
                          .grey), // Ajoute une bordure noire d'épaisseur 1.0
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    // pas de ligne
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (i > 1)
                        SizedBox(
                          width: 20,
                        ),
                      if (widget.etatdemande == "Accepté" &&
                          widget.numtel == null)
                        IconButton(
                          icon: Icon(Icons.phone),
                          onPressed: () {
                            // Action à effectuer lors du clic sur l'icône du téléphone
                            appelerNumero(widget.utilisateur!.numtel);
                          },
                        ),
                      if (widget.longitude != null)
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 228, 64, 83)),
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            height: 40,
                            padding: EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: IconButton(
                                  onPressed: () {
                                    print(widget.longitude);
                                    LatLng lat = LatLng(
                                        widget.latitude!, widget.longitude!);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          ConsulterAnnoncesmaps(
                                        dest: lat,
                                        nom: widget.name,
                                        numtel: widget.numtel,
                                        gs: widget.blood,
                                      ),
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.location_on_outlined,
                                    color: Color.fromARGB(255, 241, 230, 231),
                                    size: 20,
                                  )),
                            )),
                      if (widget.numtel != null) ...[
                        IconButton(
                          icon: Icon(Icons.phone),
                          onPressed: () {
                            // Action à effectuer lors du clic sur l'icône du téléphone
                            appelerNumero(widget.numtel!);
                          },
                        ),
                      ],
                      if (widget.etatdemande != 'Accepté' &&
                          widget.id != widget.utilisateur!.id)
                        MaterialButton(
                          color: Color.fromARGB(255, 228, 64, 83),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () async {
                            print(widget.typedon);
                            if (widget.etatdemande == 'null' ||
                                widget.etatdemande == 'Annulé') {
                              DemandeClass demanda = DemandeClass(
                                  utilisateurdes: widget.id,
                                  utilisateurSrc: widget.utilisateur!,
                                  typeDemande: 'donner de sang',
                                  etatDemande: 'Envoyé');
                              if (widget.etatdemande == 'null') {
                                var response = await addDataDjango(
                                    demanda.toJson(),
                                    urlSite,
                                    'createDemande/');
                              } else {
                                print("je suis la");
                                await updateDataDjango(
                                    demanda.toJson(),
                                    urlSite,
                                    'modifierEtatDemande/',
                                    '${widget.id}/${widget.utilisateur!.id}');
                              }
                              var jsons = await getDataDjango(
                                  urlSite, 'recupereTokenUser/${widget.id}');
                              List<Tokens>? lista = jsonToListToken(jsons);
                              print("on est la");
                              for (var element in lista!) {
                                await sendNotifcation(
                                    "${widget.utilisateur!.nom} - ${widget.utilisateur!.prenom} peut vous donner son sang !",
                                    "vous avez reçu une demande de donner sang lieu de donneur: ${widget.utilisateur!.willaya} - ${widget.utilisateur!.daira} ",
                                    element.token);
                                print("on est la");
                              }
                              widget.etatdemande = 'Envoyé';

                              setState(() {});
                            } else {
                              DemandeClass demanda = DemandeClass(
                                  utilisateurdes: widget.id,
                                  utilisateurSrc: widget.utilisateur!,
                                  typeDemande: 'donner de sang',
                                  etatDemande: 'Annulé');

                              deleteDataDjango(urlSite,
                                  'supprimerDemande/${widget.id}/${widget.utilisateur!.id}');

                              widget.etatdemande = 'Annulé';
                              setState(() {});
                            }
                          },
                          //color: Color.fromARGB(255, 220, 0, 59),
                          child: Text(
                            widget.etatdemande == 'null' ||
                                    widget.etatdemande == 'Annulé'
                                ? "Envoyer demande"
                                : "Annuler demande",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ), //row tae padding
          ],
        ),
      ),
    );
  }
}
