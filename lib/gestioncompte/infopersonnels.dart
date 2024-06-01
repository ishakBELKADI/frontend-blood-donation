import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfe/Views/authentification/dialogueGroupeSanguin.dart';
import 'package:pfe/compenments/textformfieldA.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/tools/bottom_navigation_bar.dart';

class Infoperso extends StatefulWidget {
  final Utilisateur? utilisateur;

  const Infoperso({super.key, this.utilisateur});
  @override
  State<Infoperso> createState() => InfopersoPage();
}

class InfopersoPage extends State<Infoperso> {
  late TextEditingController nom;
  late TextEditingController prenom;
  late TextEditingController wilaya;
  late TextEditingController dairatext;
  late TextEditingController emailAdress;
  late TextEditingController groupesnguincontroller;
  late TextEditingController numtel;

  @override
  void initState() {
    nom = TextEditingController(text: widget.utilisateur!.nom);
    prenom = TextEditingController(text: widget.utilisateur!.prenom);
    wilaya = TextEditingController(text: widget.utilisateur!.willaya);
    dairatext = TextEditingController(text: widget.utilisateur!.daira);
    emailAdress = TextEditingController(text: widget.utilisateur!.email);
    numtel = TextEditingController(text: widget.utilisateur!.numtel.toString());
    groupesnguincontroller =
        TextEditingController(text: widget.utilisateur!.groupSanguin);

    super.initState();
  }

  TextEditingController password = TextEditingController();

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
            Navigator.pop(
                context); // Revenir en arrière lorsque la flèche est pressée
          },
        ),
        title: Text(
          "informations personnelles",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFFDC003C),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
        child: ListView(
          children: [
            Container(
              height: 40,
            ),
            Form(
              child: Column(
                children: [
                  TextForm(
                    textEditingController: nom,
                    label: "Nom",
                    i: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 220, 0, 59),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  TextForm(
                    textEditingController: prenom,
                    label: "Prenom",
                    i: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 220, 0, 59),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  TextForm(
                    textEditingController: numtel,
                    label: "numero telephone",
                    i: Icon(
                      Icons.phone,
                      color: Color.fromARGB(255, 220, 0, 59),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: GroupeSanguin(),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  setState(() {});
                                  print(v);
                                  groupesnguincontroller.text = v!;

                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Valider",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                color: Color(0xFFDC003C),
                                textColor: Colors.white,
                                height: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: AbsorbPointer(
                      absorbing:
                          true, // Désactiver l'interaction avec le TextFormField
                      child: TextForm(
                        textEditingController: groupesnguincontroller,
                        label: "groupe sanguin",
                        i: Icon(
                          Icons.bloodtype_outlined,
                          color: Color.fromARGB(255, 220, 0, 59),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  TextForm(
                    label: "Willaya",
                    textEditingController: wilaya,
                    i: Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 220, 0, 59),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  TextForm(
                    label: "Daira",
                    textEditingController: dairatext,
                    i: Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 220, 0, 59),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  TextFormField(
                    controller: emailAdress,
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Color.fromARGB(255, 220, 0, 59),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 220, 0, 59),
                      ),
                      contentPadding:
                          EdgeInsets.only(left: 30, top: 20, bottom: 20),
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.key,
                        color: Color.fromARGB(255, 220, 0, 59),
                      ),
                      labelText: "Nouveau Mot de passe",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 220, 0, 59),
                      ),
                      contentPadding:
                          EdgeInsets.only(left: 30, top: 20, bottom: 20),
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () async {
                Utilisateur user = Utilisateur(
                  nom: nom.text,
                  prenom: prenom.text,
                  numtel: int.parse(numtel.text),
                  groupSanguin: groupesnguincontroller.text,
                  willaya: wilaya.text,
                  daira: dairatext.text,
                  email: emailAdress.text,
                );
                print(user.toJson());

                await updateDataDjango(
                  user.toJson(),
                  urlSite,
                  "updaterUser/",
                  widget.utilisateur!.id.toString(),
                );

                if (password.text.isNotEmpty) {
                  var user = FirebaseAuth.instance.currentUser;
                  print(user);
                  await user?.updatePassword(password.text);
                }

                await Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => Bottom_navigation_bar(
                      i: 3,
                    ),
                  ),
                  (route) => false,
                );
              },
              child: Text(
                "Enregister",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              color: Color.fromARGB(255, 220, 0, 59),
              textColor: Colors.white,
              height: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
