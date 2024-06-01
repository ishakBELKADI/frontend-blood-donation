import 'package:flutter/material.dart';

class Open extends StatefulWidget {
  @override
  State<Open> createState() => OpenPage();
}

class OpenPage extends State<Open> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color(0xFFDC003C),
          child: ListView(
            children: [
              Container(
                height: 110,
              ),
              Center(
                child: Icon(
                  Icons.bloodtype,
                  size: 200,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 70,
              ),
              Text(
                "Donnez Votre Sang",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10,
              ),
              Text(
                "Et",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Container(
                height: 10,
              ),
              Text(
                "Sauvez des vies",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 80,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 100),
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("signup");
                  },
                  child: Text(
                    "S'inscrire",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2)),
                ),
              ),
              Container(
                height: 15,
              ),
              Text(
                "Or",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 100),
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("login");
                  },
                  child: Text(
                    "Se connecter",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2)),
                ),
              ),
            ],
          )),
    );
  }
}
