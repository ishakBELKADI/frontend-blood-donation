import 'package:pfe/annonce_filtre.dart';
import 'package:pfe/homepage.dart';
//import 'package:pfe/quiz.dart';
import 'package:pfe/maps.dart';
import 'package:flutter/material.dart';
import 'package:pfe/models/annonce.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/testApimaps.dart';

class choix_donneur extends StatefulWidget {
  String type;
  List<Annonce> annonces;
  Utilisateur utilisateur;
  choix_donneur(
      {super.key,
      required this.annonces,
      required this.utilisateur,
      required this.type});

  @override
  State<choix_donneur> createState() => _choix_donneurState();
}

class _choix_donneurState extends State<choix_donneur> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      title: Text(
        "À Qui voulez-vous faire don ?",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 220, 0, 59),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            elevation: 3.0,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MapScreen()));
                },
                child: Text(
                  "Centre de don",
                  style: TextStyle(color: Colors.grey[800], fontSize: 18),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size(222, 55)),
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) {
                      return Color.fromARGB(
                          255, 247, 226, 234); // couleur de l'ombre du bouton
                    },
                  ),
                )),
          ),
          Card(
            elevation: 3.0,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => annonce_filtre(
                            annonces: widget.annonces,
                            utilisateur: widget.utilisateur,
                            type: widget.type,
                          )));
                },
                child: Text(
                  "personne",
                  style: TextStyle(color: Colors.grey[800], fontSize: 18),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size(222, 55)),
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) {
                      return Color.fromARGB(
                          255, 247, 226, 234); // couleur de l'ombre du bouton
                    },
                  ),
                )),
          ),
          Center(
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Annuler",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              color: Color.fromARGB(255, 220, 0, 59),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
