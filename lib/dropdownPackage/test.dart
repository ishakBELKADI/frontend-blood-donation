import 'package:flutter/material.dart';
import 'package:pfe/Views/authentification/dialogueGroupeSanguin.dart';
import 'package:pfe/dataStructur.dart';
import 'package:pfe/dropdownPackage/dropdown.dart';

class Testing extends StatefulWidget {
  @override
  State<Testing> createState() => TestPage();
}

class TestPage extends State<Testing> {
  String? typeUser;

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  bool obscuretext = true;

  bool obscuretext1 = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDC003C),
        title: Text(
          "Inscriviez-vous",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: ListView(
          children: [
            Container(
              height: 300,
              child: Stack(children: [
                Positioned(
                  height: 300,
                  width: 430,
                  top: -100,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFDC003C),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(300, 60),
                            bottomRight: Radius.elliptical(300, 60))),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 117,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.photo_camera)),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10000)),
                  ),
                ),
                Positioned(
                    top: 20,
                    left: 100,
                    right: 50,
                    child: Text(
                      "Créez un compte",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                // Positioned(
                //     top: 60,
                //     left: 85,
                //     child: Text(
                //       "Creez un compte pour continuer",
                //       style: TextStyle(
                //           // fontSize: 30,
                //           // fontWeight: FontWeight.bold,
                //           color: Colors.white),
                //     )),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nom",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          // color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(),
                        hintText: "Votre nom"),
                  ),
                  Container(
                    height: 12,
                  ),
                  Text(
                    "Prenom",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          // color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(),
                        hintText: "Votre prenom"),
                  ),
                  Container(
                    height: 12,
                  ),
                  Text(
                    "Groupe sanguin",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Container(
                    height: 10,
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

                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Valider",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                color: Color(0xFFd20000),
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
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: v == null ? "Groupe sanguin" : v!,
                            prefixIcon: Icon(
                              Icons.bloodtype,
                              // color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(),
                            hintText: "O+"),
                      ),
                    ),
                  ),
                  Container(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "Voulez-vous etre un donneur?",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Oui",
                            style: TextStyle(fontSize: 16),
                          ),
                          Radio(
                            activeColor: Colors.red,
                            value: "Oui",
                            groupValue: typeUser,
                            onChanged: (value) {
                              typeUser = value;
                              print(typeUser);
                              setState(() {});
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Non",
                            style: TextStyle(fontSize: 16),
                          ),
                          Radio(
                            activeColor: Colors.red,
                            value: "Non",
                            groupValue: typeUser,
                            onChanged: (value) {
                              typeUser = value;
                              setState(() {});
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Pas maintenant",
                            style: TextStyle(fontSize: 16),
                          ),
                          Radio(
                            activeColor: Colors.red,
                            value: "Pas maintenant",
                            groupValue: typeUser,
                            onChanged: (value) {
                              typeUser = value;
                              setState(() {});
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    height: 12,
                  ),
                  Text(
                    "Willaya",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Container(
                    height: 10,
                  ),
                  AppTextField(
                    icon: Icons.location_on,
                    textEditingController: textEditingController2,
                    hint: "Alger",
                    isCitySelected: true,
                    cities: willaya,
                  ),
                  Container(
                    height: 12,
                  ),
                  Text(
                    "Ville",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Container(
                    height: 10,
                  ),
                  AppTextField(
                    icon: Icons.location_city_rounded,
                    textEditingController: textEditingController1,
                    hint: "Beb ezzouar",
                    isCitySelected: true,
                    cities: dairas,
                  ),
                  Container(
                    height: 12,
                  ),
                  Text(
                    "Numero de telephone",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_enabled,
                          // color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(),
                        hintText: "0567877747"),
                  ),
                  Container(
                    height: 12,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          // color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(),
                        hintText: "votreemail@gmail.com"),
                  ),
                  Container(
                    height: 12,
                  ),
                  Text(
                    "Mot de passe",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: obscuretext1,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              obscuretext1 = !obscuretext1;
                              setState(() {});
                            },
                            icon: Icon(Icons.remove_red_eye_outlined)),
                        prefixIcon: Icon(
                          Icons.password,
                          // color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(),
                        hintText: "utiliSAteur37#"),
                  ),
                  Container(
                    height: 12,
                  ),
                  Text(
                    "Confirmer mot de passe",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: obscuretext,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              obscuretext = !obscuretext;
                              setState(() {});
                            },
                            icon: Icon(Icons.remove_red_eye_outlined)),
                        prefixIcon: Icon(
                          Icons.password,
                          // color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(),
                        hintText: "utiliSAteur37#"),
                  ),
                  Container(
                    height: 12,
                  ),
                ],
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: MaterialButton(
                onPressed: () {
                  print("compte créé");
                },
                child: Text(
                  "Se connecter",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                color: Color(0xFFDC003C),
                textColor: Colors.white,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Container(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("login");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vous avez deja un compte? ",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Connectez vous",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
