import 'package:flutter/material.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:url_launcher/url_launcher.dart';

class Acceptes extends StatefulWidget {
  List? demandesRecu;
  final Utilisateur utilisateur;

  Acceptes({super.key, required this.utilisateur});
  @override
  State<Acceptes> createState() => AcceptesState();
}

class AcceptesState extends State<Acceptes> {
  void appelerNumero(int numero) async {
    Uri url = Uri.parse('tel:0$numero');
    // if (await canLaunchUrl(url)) {
    await launchUrl(url);
    //} else {
    //throw 'Impossible de lancer $url';
    //}
  }

  var demandesAcceptes;
  bool waiting = true;
  getDemandeAcc() async {
    demandesAcceptes = await getDataDjango(
        urlSite, 'demandesAccepter/${widget.utilisateur.id}');
    waiting = false;
    print("===============");
    print(demandesAcceptes);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDemandeAcc();
  }

  @override
  Widget build(BuildContext context) {
    if (waiting == false) {
      return ListView(
        children: [
          Container(
              margin: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "vous avez ${demandesAcceptes.length} demande accepée",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              )),
          ...List.generate(
            demandesAcceptes.length,
            (index) {
              return Card(
                child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 10, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${demandesAcceptes[index]["utilisateur_dest"]["nom"]} ${demandesAcceptes[index]["utilisateur_dest"]["prenom"]} ",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${demandesAcceptes[index]["utilisateur_dest"]["groupSanguin"]}",
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 220, 0, 59),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 20, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "${demandesAcceptes[index]["utilisateur_dest"]["willaya"]} ", //- ${demandesAcceptes[index]["utilisateur_dest"]["daira"]}
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: IconButton(
                                iconSize: 30,
                                icon: Icon(Icons.phone),
                                onPressed: () {
                                  appelerNumero(demandesAcceptes[index]
                                      ["utilisateur_dest"]["numtel"]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              );
            },
          )
        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
