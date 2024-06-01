import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfe/Views/Trouver_donneur/publierAnnonce.dart';
import 'package:pfe/cartmapsConsulterAnnonces.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/annonce.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/tools/card_post.dart';
import 'package:url_launcher/url_launcher.dart';

class GestionAnnonce extends StatefulWidget {
  final Utilisateur utilisateur;
  const GestionAnnonce({super.key, required this.utilisateur});

  @override
  State<GestionAnnonce> createState() => GestionAnnoncePage();
}

class GestionAnnoncePage extends State<GestionAnnonce> {
  List<Annonce>? listAnnonce;
  bool waiting = true;
  getAllannoncesUser(id) async {
    var response = await getDataDjango(
        urlSite, 'getAllAnnouncesUser/${widget.utilisateur.id}');
    if (response is List) listAnnonce = convertirListeAnnonces(response);
    // if (response["message"] != "Vous avez publier aucune annonce")

    waiting = false;
    setState(() {});
  }

  List<Annonce>? lista;

  @override
  void initState() {
    super.initState();
    print(waiting);
    getAllannoncesUser(widget.utilisateur.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text(
            "Vos annonces",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFFDC003C),
        ),
        body: waiting == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : listAnnonce != null
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.all(10),
                        color: Color.fromARGB(255, 241, 230, 231),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 10, left: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${listAnnonce![index].utilisateur.nom} ${listAnnonce![index].utilisateur.prenom}",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${listAnnonce![index].groupSanguin}",
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 220, 0, 59),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      "Publié le : ${listAnnonce![index].dateDePublication!.day}-${listAnnonce![index].dateDePublication!.month}-${listAnnonce![index].dateDePublication!.year}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFDC003C),
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ...[
                                    Text(
                                      "${listAnnonce![index].description}",
                                    ),
                                  ],
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Endroit : ${listAnnonce![index].place}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date de don :${listAnnonce![index].dateDeDonMax!.day}-${listAnnonce![index].dateDeDonMax!.month}-${listAnnonce![index].dateDeDonMax!.year}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFFDC003C),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromARGB(
                                                    255, 228, 64, 83)),
                                            margin: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            height: 40,
                                            padding: EdgeInsets.all(5),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: IconButton(
                                                  onPressed: () {
                                                    print(listAnnonce![index]
                                                        .longitude);
                                                    LatLng lat = LatLng(
                                                        listAnnonce![index]
                                                            .latitude!,
                                                        listAnnonce![index]
                                                            .longitude!);
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          ConsulterAnnoncesmaps(
                                                        dest: lat,
                                                        nom: listAnnonce![index]
                                                            .utilisateur
                                                            .nom,
                                                        numtel:
                                                            listAnnonce![index]
                                                                .utilisateur
                                                                .numtel,
                                                        gs: listAnnonce![index]
                                                            .utilisateur
                                                            .groupSanguin,
                                                      ),
                                                    ));
                                                  },
                                                  icon: Icon(
                                                    Icons.location_on_outlined,
                                                    color: Color.fromARGB(
                                                        255, 241, 230, 231),
                                                    size: 20,
                                                  )),
                                            )),
                                        if (listAnnonce![index]
                                                .numeroTelephone !=
                                            null) ...[
                                          IconButton(
                                            icon: Icon(Icons.phone),
                                            onPressed: () {
                                              // Action à effectuer lors du clic sur l'icône du téléphone
                                              appelerNumero(listAnnonce![index]
                                                  .numeroTelephone!);
                                            },
                                          ),
                                        ],
                                        PopupMenuButton(
                                          onSelected: (value) async {
                                            if (value == "supprimer") {
                                              var response = await deleteDataDjango(
                                                  urlSite,
                                                  'deleteAnnonce/${listAnnonce![index].id}');
                                              if (response["message"] ==
                                                  "annonce supprimé") {
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType:
                                                      DialogType.success,
                                                  animType: AnimType.rightSlide,
                                                  title: 'Annonce supprimé',
                                                  autoHide:
                                                      Duration(seconds: 5),
                                                )..show();
                                                listAnnonce!.removeAt(index);
                                                // getAllannoncesUser(
                                                //     widget.utilisateur.id);
                                              }
                                              getAllannoncesUser(
                                                  widget.utilisateur.id);
                                            } else {
                                              await Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    PublierAnnonce(
                                                        utilisateur:
                                                            widget.utilisateur,
                                                        annonce: listAnnonce![
                                                            index]),
                                              ));
                                              getAllannoncesUser(
                                                  widget.utilisateur.id);
                                            }
                                          },
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                  child: Text(
                                                      "Supprimer l'annonce "),
                                                  value: "supprimer"),
                                              PopupMenuItem(
                                                  child: Text(
                                                      "Modifier l'annonce "),
                                                  value: "modifier"),
                                            ];
                                          },
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
                    },
                    itemCount: listAnnonce!.length,
                  )
                : Center(
                    child: Text("Vous avez publié aucune annonces"),
                  ));
  }

  void appelerNumero(int numero) async {
    Uri url = Uri.parse('tel:0$numero');
    // if (await canLaunchUrl(url)) {
    await launchUrl(url);
    //} else {
    //throw 'Impossible de lancer $url';
    //}
  }
}
