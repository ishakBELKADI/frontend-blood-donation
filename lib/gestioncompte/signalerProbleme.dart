import 'package:flutter/material.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/utilisateur.dart';

class Signalerprbl extends StatefulWidget {
  final Utilisateur utilisateur;

  Signalerprbl({super.key, required this.utilisateur});
  @override
  State<Signalerprbl> createState() => SignalerprblPage();
}

class SignalerprblPage extends State<Signalerprbl> {
  TextEditingController textEditingController = TextEditingController();
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFDC003C),
        borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(100, 10),
            topRight: Radius.elliptical(100, 10)),
      ),
      padding: EdgeInsets.all(10),
      width: 1000,
      height: 600,
      child: Column(
        children: [
          Container(
            height: 20,
          ),
          Text(
            "Signaler un probleme",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Container(
            height: 10,
          ),
          Text(
            "Expliquez brièvement ce qui s'est passé ou ce qui ne fonctionne pas",
            style: TextStyle(
                fontSize: 16,
                color: Colors.grey[50],
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 30,
          ),
          TextFormField(
            controller: textEditingController,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            maxLines: 5,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                hintText: "Décrivez votre problème...",
                hintStyle: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 20),
                    borderRadius: BorderRadius.circular(10))),
          ),
          Container(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  textEditingController.text = "";
                  Navigator.pop(context);
                },
                child: Text(
                  "Annuler",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFd20000)),
                ),
                color: Colors.white,
                height: 50,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFd20000), width: 1),
                    borderRadius: BorderRadius.circular(20)),
              ),
              MaterialButton(
                onPressed: () {
                  var data = {
                    "problem": textEditingController.text,
                    "id": widget.utilisateur.id
                  };
                  addDataDjango(data, urlSite, 'SignalerProbleme/');
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Envoyer",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                color: Color(0xFFd20000),
                textColor: Colors.white,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
