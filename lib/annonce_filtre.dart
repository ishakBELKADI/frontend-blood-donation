import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/tools/card_post.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:pfe/homepage.dart';

import 'models/annonce.dart';

class annonce_filtre extends StatefulWidget {
  String type;
  List<Annonce> annonces;
  Utilisateur utilisateur;
  annonce_filtre(
      {required this.annonces, required this.utilisateur, required this.type});

  @override
  State<annonce_filtre> createState() => _annonce_filtreState();
}

class _annonce_filtreState extends State<annonce_filtre> {
  late List<Annonce> annoncesFiltrees;

  @override
  void initState() {
    super.initState();
    annoncesFiltrees = widget.annonces
        .where((annonce) =>
            annonce.groupSanguin == widget.utilisateur.groupSanguin &&
            annonce.place!.contains(widget.utilisateur.willaya) &&
            annonce.type_de_don == widget.type)
        .toList();

    print(widget.annonces);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 220, 0, 59),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(
                context); // Revenir en arrière lorsque la flèche est pressée
          },
        ),
        title: Text(
          'SOS Help',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: annoncesFiltrees.isEmpty
          ? Center(
              child: Text(
              'Aucune annonce trouvée',
              style: TextStyle(fontSize: 30, color: Colors.grey[600]),
            ))
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: annoncesFiltrees.length,
              itemBuilder: (context, i) {
                return Card_cust(
                  name:
                      "${annoncesFiltrees[i].utilisateur.nom} ${annoncesFiltrees[i].utilisateur.prenom}",
                  blood: annoncesFiltrees[i].groupSanguin,
                  day: annoncesFiltrees[i].dateDeDonMax?.day,
                  month: annoncesFiltrees[i].dateDeDonMax?.month,
                  year: annoncesFiltrees[i].dateDeDonMax?.year,
                  day_p: annoncesFiltrees[i].dateDePublication?.day,
                  month_p: annoncesFiltrees[i].dateDePublication?.month,
                  year_p: annoncesFiltrees[i].dateDePublication?.year,
                  adress: annoncesFiltrees[i].place,
                  numtel: annoncesFiltrees[i].numeroTelephone,
                  description: annoncesFiltrees[i].description,
                  typedon: annoncesFiltrees[i].type_de_don,
                );
              }),
    );
  }
}
