import 'package:pfe/demandeView/demandeAcceptes.dart';
import 'package:pfe/demandeView/demandeEnvoye.dart';
import 'package:pfe/demandeView/demandeRecu.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/tools/card_demande.dart';
import 'package:flutter/material.dart';

class demande extends StatefulWidget {
  final Utilisateur? utilisateur;

  const demande({super.key, this.utilisateur});

  @override
  State<demande> createState() => _demandeState();
}

class _demandeState extends State<demande> {
  bool waiting = true;
  List? demandesRecus;
  List? demandesEnvoyes;
  getDemandes() async {
    var response = await getDataDjango(
        urlSite, 'recupererDemande/${widget.utilisateur!.id}');
    if (response[1]['Reçu'] != null) demandesRecus = response[1]['Reçu'];
    if (response[0]['Envoye'] != null) demandesEnvoyes = response[0]['Envoye'];
    waiting = false;
    // print(demandesRecus);
    // print(demandesEnvoyes);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDemandes();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, // Changez cette couleur selon vos besoins
            ),
            backgroundColor: Color.fromARGB(255, 220, 0, 59),
            /* title: Text(
              "Les demandes",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 251),
                fontWeight: FontWeight.bold,
              ),
            ), */

            titleTextStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: "AcherusFeral"),
            centerTitle: true,
            title: Text(
              "Les demandes",
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.white70,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 18),
              tabs: [
                Tab(
                  icon: Icon(Icons.mark_email_unread_outlined),
                  text: "Reçus",
                ),
                Tab(
                  icon: Icon(Icons.outgoing_mail),
                  text: "Envoyées",
                ),
                Tab(
                  icon: Icon(Icons.mark_email_read_outlined),
                  text: "Acceptés",
                ),
              ],
            ),
          ),
          body: waiting == false
              ? Container(
                  child: TabBarView(children: [
                    Recu(
                        utilisateur: widget.utilisateur!,
                        demandesRecu: demandesRecus),
                    Envoye(
                        utilisateur: widget.utilisateur!,
                        demandesEnvoyes: demandesEnvoyes),
                    Acceptes(utilisateur: widget.utilisateur!),
                  ]),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}

// cards.isEmpty
//           ? Center(
//               child: Text(
//               'Aucune demande',
//               style: TextStyle(fontSize: 30, color: Colors.grey[600]),
//             ))
//           : ListView.builder(
//               itemCount: cards.length,
//               itemBuilder: (context, index) {
//                 return 
// card_demande(
//                   name: cards[index].name,
//                   blood: cards[index].blood,
//                   adress: cards[index].adress,
//                   contenu: cards[index].contenu,
//                   changer: cards[index].changer,
//                   accepted: () {
//                     setState(() {
//                       // Si la carte est acceptée, toutes les autres cartes sont supprimées
//                       cards[index].contenu = "annuler";
//                       //cards.removeWhere((card) => card != cards[index]);

//                       setState(() {
//                         cards[index].changer = false;
//                       });
//                     });
//                   },
//                   refused: () {
//                     setState(() {
//                       // Si la carte est refusée, elle est supprimée de la liste
//                       cards.removeAt(index);
//                     });
//                   },
//                 );
//               },
//             ),
