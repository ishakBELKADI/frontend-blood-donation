import 'package:flutter/material.dart';
import 'package:pfe/Views/Trouver_donneur/ConsulterEtCherherD.dart';
import 'package:pfe/Views/Trouver_donneur/publierAnnonce.dart';
import 'package:pfe/models/utilisateur.dart';

class choix_trouverdonneur extends StatefulWidget {
  final Utilisateur utilisateur;
  const choix_trouverdonneur({super.key, required this.utilisateur});

  @override
  State<choix_trouverdonneur> createState() => _choix_trouverdonneurState();
}

class _choix_trouverdonneurState extends State<choix_trouverdonneur> {
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
                    builder: (context) => ConsulterEtchercherDonneur(
                      utilisateur: widget.utilisateur,
                    ),
                  ));
                },
                child: Text(
                  "Contacter donneur",
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
                    builder: (context) =>
                        PublierAnnonce(utilisateur: widget.utilisateur!),
                  ));
                },
                child: Text(
                  "Publier annonce",
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
