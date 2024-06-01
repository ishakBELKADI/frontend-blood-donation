import 'package:pfe/models/annonce.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/quiz.dart';
import 'package:flutter/material.dart';

class choix extends StatefulWidget {
  List<Annonce> annonces;
  Utilisateur utilisateur;
  choix({super.key, required this.annonces, required this.utilisateur});

  @override
  State<choix> createState() => _choixState();
}

class _choixState extends State<choix> {
  String? don;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      title: Text(
        "Faites votre choix..",
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => quiz(
                            type: "sang",
                            annonces: widget.annonces,
                            utilisateur: widget.utilisateur,
                          )));
                },
                child: Text(
                  "Don de sang",
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
                      builder: (context) => quiz(
                            type: "plasma",
                            annonces: widget.annonces,
                            utilisateur: widget.utilisateur,
                          )));
                },
                child: Text(
                  "Don de plasma",
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
                      builder: (context) => quiz(
                            type: "plaquette",
                            annonces: widget.annonces,
                            utilisateur: widget.utilisateur,
                          )));
                },
                child: Text(
                  "Don de plaquette",
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
