import 'package:flutter/material.dart';
import 'package:pfe/Views/Trouver_donneur/resultatRecharche.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/demandeClass.dart';
import 'package:pfe/models/donneur.dart';
import 'package:pfe/models/envoyernotif.dart';
import 'package:pfe/models/tokens.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/notificationsTest.dart';
import 'package:url_launcher/url_launcher.dart';

void appelerNumero(int numero) async {
  Uri url = Uri.parse('tel:0$numero');
  // if (await canLaunchUrl(url)) {
  await launchUrl(url);
  //} else {
  //throw 'Impossible de lancer $url';
  //}
}

List<Donneur>? donneursrecherche;
Utilisateur? user;

class ConsulterEtchercherDonneur extends StatefulWidget {
  final Utilisateur utilisateur;

  ConsulterEtchercherDonneur({super.key, required this.utilisateur});
  @override
  State<ConsulterEtchercherDonneur> createState() =>
      ConsulterEtchercherDonneurPage();
}

class ConsulterEtchercherDonneurPage extends State<ConsulterEtchercherDonneur> {
  bool waiting = true;
  var listDemande;
  List<Donneur>? listDonneurs;
  // recupererDonneurDemande() async {
  //   listDemande = await getDataDjango(urlSite, 'recupererDemande/32');
  //   print(listDemande);
  // }

  List? demandes;

  Future<List<Donneur>> recupererDonneur() async {
    var response = await getDataDjango(
        urlSite, 'recupererDonneursUserState/${widget.utilisateur.id}');
    listDonneurs = convertirListeDonneurs(response);
    donneursrecherche = listDonneurs;
    user = widget.utilisateur;
    waiting = false;

    setState(() {});
    return listDonneurs!;
  }

  @override
  void initState() {
    super.initState();
    recupererDonneur();
    // recupererDonneurDemande();
  }

  int i = 0;

  bool? b;
  bool demande = false;
  TextEditingController sanguin = TextEditingController();
  TextEditingController ville = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /* floatingActionButton: FloatingActionButton(
          onPressed: () {
            getDataDjango(urlSite, 'recupererDemande/1');
          },
        ), */
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 220, 0, 59),
          title: Text(
            "Liste des donneurs",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CostumeSearch(),
                );
              },
              icon: Icon(Icons.search),
              color: Colors.white,
            ),
          ],
        ),
        body: waiting == false
            ? ListView(
                children: [
                  Form(
                      child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: ville,
                          decoration: InputDecoration(
                            hintText: "Ville",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            prefixIcon: Icon(
                              Icons.location_city_rounded,
                              color: Color.fromARGB(255, 220, 0, 59),
                            ),
                            prefixStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: sanguin,
                          decoration: InputDecoration(
                            hintText: "O+",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            prefixIcon: Icon(
                              Icons.bloodtype,
                              color: Color.fromARGB(255, 220, 0, 59),
                            ),
                            prefixStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )),
                  Container(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      showSearch(
                          useRootNavigator: false,
                          context: context,
                          delegate: CostumeSearch(),
                          query: ville.text + " " + sanguin.text);
                    },
                    child: Text(
                      "chercher",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    color: Color.fromARGB(255, 220, 0, 59),
                    textColor: Colors.white,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  ...List.generate(
                    listDonneurs!.length,
                    (index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${listDonneurs![index].utilisateur.nom} ${listDonneurs![index].utilisateur.prenom}   ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${listDonneurs![index].utilisateur.groupSanguin}",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color:
                                              Color.fromARGB(255, 220, 0, 59),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${listDonneurs![index].statu}  ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  if (listDonneurs![index].statu == 'Apte')
                                    Icon(
                                      Icons.circle,
                                      color: Colors.green,
                                      size: 14,
                                    )
                                  else
                                    Icon(
                                      Icons.circle,
                                      color: Colors.red,
                                      size: 14,
                                    )
                                ],
                              ),
                              Container(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${listDonneurs![index].utilisateur.willaya} -  ${listDonneurs![index].utilisateur.daira}  "),
                                  (listDonneurs![index].etatDemande !=
                                              "Accepté" &&
                                          listDonneurs![index].utilisateur.id !=
                                              widget.utilisateur.id)
                                      ? MaterialButton(
                                          onPressed: () async {
                                            if (listDonneurs![index]
                                                    .etatDemande ==
                                                'null') {
                                              DemandeClass demanda =
                                                  DemandeClass(
                                                      utilisateurdes:
                                                          listDonneurs![index]
                                                              .utilisateur
                                                              .id,
                                                      utilisateurSrc:
                                                          widget.utilisateur,
                                                      typeDemande:
                                                          'demande de sang',
                                                      etatDemande: 'Envoyé');

                                              var response = addDataDjango(
                                                  demanda.toJson(),
                                                  urlSite,
                                                  'createDemande/');
                                              print(response);

                                              var jsons = await getDataDjango(
                                                  urlSite,
                                                  'recupereTokenUser/${listDonneurs![index].utilisateur.id}');
                                              List<Tokens>? lista =
                                                  jsonToListToken(jsons);
                                              print("on est la");
                                              for (var element in lista!) {
                                                sendNotifcation(
                                                    "${widget.utilisateur.nom} - ${widget.utilisateur.prenom} a besoin de votre sang !",
                                                    "vous avez reçu une demande de don de sang lieu de demandeur: ${widget.utilisateur.willaya} - ${widget.utilisateur.daira} ",
                                                    element.token);
                                                print("notif envoyé");
                                              }

                                              listDonneurs![index].etatDemande =
                                                  'Envoyé';
                                            } else {
                                              if (listDonneurs![index]
                                                      .etatDemande ==
                                                  'Envoyé') {
                                                deleteDataDjango(urlSite,
                                                    'supprimerDemande/${listDonneurs![index].utilisateur.id}/${widget.utilisateur.id}');

                                                listDonneurs![index]
                                                    .etatDemande = 'null';
                                              } else {
                                                if (listDonneurs![index]
                                                        .etatDemande ==
                                                    'Annulé') {
                                                  print("coucou");
                                                  DemandeClass demanda =
                                                      DemandeClass(
                                                          utilisateurdes:
                                                              listDonneurs![
                                                                      index]
                                                                  .utilisateur
                                                                  .id,
                                                          utilisateurSrc:
                                                              widget
                                                                  .utilisateur,
                                                          typeDemande:
                                                              'demande de sang',
                                                          etatDemande:
                                                              'Envoyé');
                                                  updateDataDjango(
                                                      demanda.toJson(),
                                                      urlSite,
                                                      'modifierEtatDemande/',
                                                      '${listDonneurs![index].utilisateur.id}/${widget.utilisateur.id}');

                                                  listDonneurs![index]
                                                      .etatDemande = 'Envoyé';
                                                }
                                              }
                                            }
                                            print(listDonneurs![index]
                                                .etatDemande);
                                            setState(() {});
                                          },
                                          child: Text(
                                            listDonneurs![index].etatDemande !=
                                                        'null' &&
                                                    listDonneurs![index]
                                                            .etatDemande ==
                                                        'Envoyé'
                                                ? "Demande ${listDonneurs![index].etatDemande}"
                                                : "Envoyer demande",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          color:
                                              Color.fromARGB(255, 220, 0, 59),
                                          textColor: Colors.white,
                                          height: 50,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            appelerNumero(listDonneurs![index]
                                                .utilisateur
                                                .numtel);
                                          },
                                          icon: Icon(Icons.phone),
                                          iconSize: 30,
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class CostumeSearch extends SearchDelegate {
  Utilisateur? utilisateur;
  List<Donneur> listfilter = [];
  int? selectionne;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Resultat(
      element: donneursrecherche![selectionne!],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      selectionne = index;
                      print(selectionne);
                      showResults(context);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${donneursrecherche![index].utilisateur.nom} ${donneursrecherche![index].utilisateur.prenom}   ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${donneursrecherche![index].utilisateur.groupSanguin}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${donneursrecherche![index].statu}  ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                if (donneursrecherche![index].statu == 'Apte')
                                  Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: 14,
                                  )
                                else
                                  Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                    size: 14,
                                  )
                              ],
                            ),
                            Container(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${donneursrecherche![index].utilisateur.willaya} -  ${donneursrecherche![index].utilisateur.daira}  "),
                                donneursrecherche![index].etatDemande !=
                                            "Accepté" &&
                                        donneursrecherche![index]
                                                .utilisateur
                                                .id !=
                                            user!.id
                                    ? MaterialButton(
                                        onPressed: () async {
                                          if (donneursrecherche![index]
                                                  .etatDemande ==
                                              'null') {
                                            DemandeClass demanda = DemandeClass(
                                                utilisateurdes:
                                                    donneursrecherche![index]
                                                        .utilisateur
                                                        .id,
                                                utilisateurSrc: user!,
                                                typeDemande: 'demande de sang',
                                                etatDemande: 'Envoyé');

                                            var response = addDataDjango(
                                                demanda.toJson(),
                                                urlSite,
                                                'createDemande/');
                                            print(response);

                                            var jsons = await getDataDjango(
                                                urlSite,
                                                'recupereTokenUser/${donneursrecherche![index].utilisateur.id}');
                                            List<Tokens>? lista =
                                                jsonToListToken(jsons);
                                            print("on est la");
                                            for (var element in lista!) {
                                              sendNotifcation(
                                                  "${user!.nom} - ${user!.prenom} a besoin de votre sang !",
                                                  "vous avez reçu une demande de don de sang lieu de demandeur: ${user!.willaya} - ${user!.daira} ",
                                                  element.token);
                                              print("notif envoyé");
                                            }

                                            donneursrecherche![index]
                                                .etatDemande = 'Envoyé';
                                            setState(() {});
                                          } else {
                                            if (donneursrecherche![index]
                                                    .etatDemande ==
                                                'Envoyé') {
                                              deleteDataDjango(
                                                urlSite,
                                                'supprimerDemande/${donneursrecherche![index].utilisateur.id}/${user!.id}',
                                              );
                                              donneursrecherche![index]
                                                  .etatDemande = 'null';
                                              setState(() {});
                                            } else {
                                              if (donneursrecherche![index]
                                                      .etatDemande ==
                                                  'Annulé') {
                                                DemandeClass demanda =
                                                    DemandeClass(
                                                        utilisateurdes:
                                                            donneursrecherche![
                                                                    index]
                                                                .utilisateur
                                                                .id,
                                                        utilisateurSrc: user!,
                                                        typeDemande:
                                                            'demande de sang',
                                                        etatDemande: 'Envoyé');
                                                updateDataDjango(
                                                    demanda.toJson(),
                                                    urlSite,
                                                    'modifierEtatDemande/',
                                                    '${donneursrecherche![index].utilisateur.id}/${user!.id}');

                                                donneursrecherche![index]
                                                    .etatDemande = 'Envoyé';
                                                setState(() {});
                                              }
                                            }
                                          }
                                          print(donneursrecherche![index]
                                              .etatDemande);
                                          // setState(() {});
                                        },
                                        child: Text(
                                          donneursrecherche![index]
                                                          .etatDemande !=
                                                      'null' &&
                                                  donneursrecherche![index]
                                                          .etatDemande ==
                                                      'Envoyé'
                                              ? "Demande ${donneursrecherche![index].etatDemande}"
                                              : "Envoyer demande",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        color: Color(0xFFd20000),
                                        textColor: Colors.white,
                                        height: 50,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          appelerNumero(
                                              donneursrecherche![index]
                                                  .utilisateur
                                                  .numtel);
                                        },
                                        icon: Icon(Icons.phone),
                                        iconSize: 30,
                                      )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: donneursrecherche!.length);
        },
      );
    } else {
      if (!query.contains(' ')) {
        listfilter = donneursrecherche!
            .where((element) =>
                element.utilisateur.willaya
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                element.utilisateur.groupSanguin
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      } else {
        String? ville;
        String? gs;
        List<String> lista = query.split(' ');
        lista.removeWhere(
          (element) => element.contains(' '),
        );
        print(lista);
        ville = lista[0];
        print(ville);
        gs = lista[1];
        listfilter = donneursrecherche!
            .where((element) => element.utilisateur.willaya
                .toLowerCase()
                .contains(ville!.toLowerCase()))
            .where((element) => element.utilisateur.groupSanguin
                .toLowerCase()
                .contains(gs!.toLowerCase()))
            .toList();
      }
      return StatefulBuilder(
        builder: (context, setState) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      selectionne =
                          donneursrecherche!.indexOf(listfilter[index]);
                      print(selectionne);
                      showResults(context);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${listfilter[index].utilisateur.nom} ${listfilter[index].utilisateur.prenom}   ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${listfilter[index].utilisateur.groupSanguin}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${listfilter[index].statu}  ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                if (listfilter[index].statu == 'Apte')
                                  Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: 14,
                                  )
                                else
                                  Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                    size: 14,
                                  )
                              ],
                            ),
                            Container(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${listfilter[index].utilisateur.willaya} -  ${listfilter[index].utilisateur.daira}  "),
                                (listfilter[index].etatDemande != "Accepté" &&
                                        listfilter[index].utilisateur.id !=
                                            user!.id)
                                    ? MaterialButton(
                                        onPressed: () async {
                                          if (listfilter[index].etatDemande ==
                                              'null') {
                                            DemandeClass demanda = DemandeClass(
                                                utilisateurdes:
                                                    listfilter[index]
                                                        .utilisateur
                                                        .id,
                                                utilisateurSrc: user!,
                                                typeDemande: 'demande de sang',
                                                etatDemande: 'Envoyé');

                                            var response = addDataDjango(
                                                demanda.toJson(),
                                                urlSite,
                                                'createDemande/');
                                            print(response);

                                            var jsons = await getDataDjango(
                                                urlSite,
                                                'recupereTokenUser/${listfilter[index].utilisateur.id}');
                                            List<Tokens>? lista =
                                                jsonToListToken(jsons);
                                            print("on est la");
                                            for (var element in lista!) {
                                              sendNotifcation(
                                                  "${user!.nom} - ${user!.prenom} a besoin de votre sang !",
                                                  "vous avez reçu une demande de don de sang lieu de demandeur: ${user!.willaya} - ${user!.daira} ",
                                                  element.token);
                                              print("notif envoyé");
                                            }

                                            listfilter[index].etatDemande =
                                                'Envoyé';
                                            setState(() {});
                                          } else {
                                            if (listfilter[index].etatDemande ==
                                                'Envoyé') {
                                              print(
                                                  'supprimerDemande/${listfilter[index].utilisateur.id}/${user!.id}');
                                              deleteDataDjango(
                                                urlSite,
                                                'supprimerDemande/${listfilter[index].utilisateur.id}/${user!.id}',
                                              );
                                              listfilter[index].etatDemande =
                                                  'null';
                                              setState(() {});
                                            } else {
                                              if (listfilter[index]
                                                      .etatDemande ==
                                                  'Annulé') {
                                                DemandeClass demanda =
                                                    DemandeClass(
                                                        utilisateurdes:
                                                            listfilter[index]
                                                                .utilisateur
                                                                .id,
                                                        utilisateurSrc: user!,
                                                        typeDemande:
                                                            'demande de sang',
                                                        etatDemande: 'Envoyé');
                                                updateDataDjango(
                                                    demanda.toJson(),
                                                    urlSite,
                                                    'modifierEtatDemande/',
                                                    '${donneursrecherche![index].utilisateur.id}/${user!.id}');

                                                donneursrecherche![index]
                                                    .etatDemande = 'Envoyé';
                                                setState(() {});
                                              }
                                            }
                                          }
                                          print(listfilter[index].etatDemande);
                                        },
                                        child: Text(
                                          listfilter[index].etatDemande !=
                                                      'null' &&
                                                  listfilter[index]
                                                          .etatDemande ==
                                                      'Envoyé'
                                              ? "Demande ${listfilter[index].etatDemande}"
                                              : "Envoyer demande",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        color: Color(0xFFd20000),
                                        textColor: Colors.white,
                                        height: 50,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          appelerNumero(
                                              donneursrecherche![index]
                                                  .utilisateur
                                                  .numtel);
                                        },
                                        icon: Icon(Icons.phone),
                                        iconSize: 30,
                                      )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: listfilter.length);
        },
      );
    }
  }
}
