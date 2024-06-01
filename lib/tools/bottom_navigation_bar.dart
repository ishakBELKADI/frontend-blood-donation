//import 'package:blood_donation/gestioncompte/gestionCompte.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/gestioncompte/gestionCompte.dart';
import 'package:pfe/homepage.dart';
import 'package:pfe/historique_don.dart';
import 'package:flutter/material.dart';
import 'package:pfe/demandeView/demande.dart';
import 'package:pfe/models/tokens.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/notificationsTest.dart';

class Bottom_navigation_bar extends StatefulWidget {
  final int? i;
  const Bottom_navigation_bar({super.key, this.i});

  @override
  State<Bottom_navigation_bar> createState() => _Bottom_navigation_barState();
}

class _Bottom_navigation_barState extends State<Bottom_navigation_bar> {
  var user;
  Utilisateur? utilisateur;
  bool waiting = true;
  currentUser() async {
    user = FirebaseAuth.instance.currentUser;
    print("==============email================");
    String email;
    email = user.email;

    print(email);
    var userData = await getOneDataDjango(urlSite, email, 'getUser/');
    utilisateur = Utilisateur.fromJson(userData);
    String? tokenchaine = await getToken();
    Tokens token = Tokens(token: tokenchaine!, utilisateur: utilisateur);
    token.addtoken();
    print(utilisateur!.id);
    print(utilisateur!.nom);
    waiting = false;
    if (widget.i != null) currentindex = widget.i!;

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser();
  }

  int currentindex = 0; // il permettra de switcher entre les pages

  @override
  Widget build(BuildContext context) {
    if (waiting == false) {
      final pages = [
        Homepage(
          utilisateur: utilisateur,
        ),
        historique(
          utilisateur: utilisateur!,
        ),
        demande(
          utilisateur: utilisateur!,
        ),
        Profil(
          utilisateur: utilisateur!,
        ),
      ];

      return Scaffold(
        body: pages[currentindex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            currentIndex: currentindex,
            backgroundColor: Color.fromARGB(255, 220, 0, 59),
            onTap: (value) => setState(() => currentindex =
                value), // l'index prend la valeur que retourne le bottom nav bar
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 35,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history,
                    size: 35,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.email_outlined,
                    size: 35,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_4_outlined,
                    size: 35,
                  ),
                  label: ""),
            ]),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
