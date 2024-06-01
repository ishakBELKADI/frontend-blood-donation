import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pfe/Views/Trouver_donneur/publierAnnonce.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/gestioncompte/gestionannonces.dart';
import 'package:pfe/gestioncompte/infopersonnels.dart';
import 'package:pfe/gestioncompte/signalerProbleme.dart';
import 'package:pfe/models/utilisateur.dart';
// import 'package:pfe/Views/gestioncompte/signalerProbleme.dart';

class Profil extends StatefulWidget {
  final Utilisateur? utilisateur;

  const Profil({super.key, this.utilisateur});

  @override
  State<Profil> createState() => ProfilPage();
}

class ProfilPage extends State<Profil> {
  // var user;
  // Utilisateur? utilisateur;
  // currentUser() async {
  //   user = FirebaseAuth.instance.currentUser;
  //   print("==============email================");
  //   String email = user.email;
  //   print(email);
  //   var userData = await getOneDataDjango(urlSite, email, 'getUser/');
  //   utilisateur = Utilisateur.fromJson(userData);
  //   print(utilisateur!.id);
  //   print(utilisateur!.nom);
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    testability();
    // currentUser();
  }

  bool denied = false;
  testability() async {
    var response =
        await getDataDjango(urlSite, 'getstatu/${widget.utilisateur!.id}');
    if (response["message"] == "Apte") {
      switchvalue = true;
    }
    if (response["message"] == "inapte") switchvalue = false;
    if (response["message"] == "non donneur") {
      switchvalue = false;
      denied = true;
    }
    setState(() {});
  }

  bool switchvalue = false;
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 235,
          240), //Colors.grey[200], //Color.fromARGB(255, 255, 234, 239),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PublierAnnonce(
              utilisateur: utilisateur!,
            ),
          ));
        },
      ), */
      key: globalKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Changez cette couleur selon vos besoins
        ),
        backgroundColor: Color(0xFFDC003C),
        titleTextStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "AcherusFeral"),
        centerTitle: true,
        title: Text(
          "Mon profil",
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: ListView(
          children: [
            Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 100,
                    /* child: InkWell(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "images/moi.jpg",
                        ),
                      ),
                    ), */
                  ),
                  Expanded(
                    child: ListTile(
                        onTap: () {},
                        isThreeLine: false,
                        subtitle: Container(
                          margin: EdgeInsets.only(top: 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.utilisateur != null
                                    ? widget.utilisateur!.groupSanguin
                                    : "groupe sanguin",
                                style: TextStyle(fontSize: 16),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 7),
                                  child: switchvalue
                                      ? Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.green,
                                              size: 16,
                                            ),
                                            Text(" Apte"),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.red,
                                              size: 16,
                                            ),
                                            Text(" Inapte"),
                                          ],
                                        )),
                            ],
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.only(left: 5, top: 10, bottom: 10),
                        title: Text(
                          widget.utilisateur != null
                              ? "${widget.utilisateur!.nom}  ${widget.utilisateur!.prenom} "
                              : "Nom et Prenom",
                          style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: Container(
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Infoperso(utilisateur: widget.utilisateur),
                        ));
                      },
                      title: Text(
                        "Informations personelles",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(
                        Icons.person,
                        color: Color(0xFFDC003C),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              GestionAnnonce(utilisateur: widget.utilisateur!),
                        ));
                      },
                      title: Text(
                        "Gerer vos annonces",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(
                        Icons.announcement,
                        color: Color(0xFFDC003C),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      trailing: Switch(
                        activeColor: Color(0xFFDC003C),
                        value: switchvalue,
                        onChanged: (value) {
                          if (denied == true) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Vous n\'etes pas donneur',
                              desc:
                                  "vous pouvez pas activer cette fonction car vous etes pas un donneur",
                              autoHide: Duration(seconds: 4),
                            )..show();
                          } else {
                            var data;
                            if (value == false) {
                              data = {'statu': 'Apte'};
                            } else {
                              data = {'statu': 'inapte'};
                            }

                            updateDataDjango(data, urlSite, 'etatDonneur/',
                                widget.utilisateur!.id.toString());
                            switchvalue = value;
                            setState(() {});
                          }
                        },
                      ),
                      title: Text(
                        "Statut de don ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(
                        Icons.health_and_safety_sharp,
                        color: Color(0xFFDC003C),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        globalKey.currentState!.showBottomSheet((context) =>
                            Signalerprbl(utilisateur: widget.utilisateur!));
                      },
                      title: Text(
                        "Signaler un probleme",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(
                        Icons.warning_rounded,
                        color: Color(0xFFDC003C),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Expanded(
            // child:
            Container(
              child: MaterialButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamed("main");
                },
                child: Text(
                  "Se Deconnecter",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                color: Color(0xFFDC003C),
                textColor: Colors.white,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
