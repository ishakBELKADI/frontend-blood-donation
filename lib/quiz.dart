//import 'dart:math';

import 'package:pfe/maps.dart';
import 'package:pfe/models/annonce.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/tools/choix_donneur.dart';
import 'package:flutter/material.dart';

class quiz extends StatefulWidget {
  String type;
  List<Annonce> annonces;
  Utilisateur utilisateur;
  quiz(
      {super.key,
      required this.annonces,
      required this.utilisateur,
      required this.type});

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  int Index = 0, i = 0;
  bool type = false;
  List<String> images = [
    "images/ill_1.png",
    "images/ill_2.png",
    "images/ill_3.png",
    "images/ill_4.png",
    "images/ill_5.png",
    "images/ill_6.png",
    "images/ill_blood-min.png",
  ];

  void _nextQuestion(bool reponse) {
    type = true;
    if (reponse) {
      setState(() {
        // Avancez à la prochaine question
        if (Index < Questionnaire.length - 1) {
          Index++;
        } else {
          // Si c la dernière question, affichez un choix pour savoir a qui faire le don
          showDialog(
              context: context,
              builder: (context) {
                return choix_donneur(
                  type: widget.type,
                  annonces: widget.annonces,
                  utilisateur: widget.utilisateur,
                );
              });
        }
      });
    }
  }

  int nextImage() {
    // defiler les images
    if (type == true) {
      setState(() {
        if (i < 6) {
          i++;
        } else {
          i = 0;
        }
      });
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Questionnaire',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color.fromARGB(255, 255, 247, 247),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 220, 0, 59),
      ),
      backgroundColor: Color.fromARGB(255, 248, 226, 234),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              images[nextImage()],
              height: 180,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Liste de cartes représentant chaque question

              Container(
                padding: EdgeInsets.only(right: 15, left: 15),
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${Questionnaire[Index].question}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                Questionnaire[Index].options[0],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 220, 0, 59)),
                              ),
                            ),
                            ElevatedButton(
                              // L'utilisateur a bien repondu donc passer a la prochaine question
                              onPressed: () {
                                _nextQuestion(true);
                              },
                              child: Text(
                                Questionnaire[Index].options[1],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 220, 0, 59)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  // final String? image;
  Question(
    this.question,
    this.options,
  );
}

// Liste de questions pour le quiz
List<Question> Questionnaire = [
  Question('Quel age avez vous?', ['-18/+71 ans', '18 à 71 ans']),
  Question('Quel est votre poids?', ['- de 50 kg', '+ 50 kg']),
  Question(
      'Votre dernier don date de moins de 8 semaines (sang) ou 4 semaines (plaquettes) ou 2 semaines (plasma) ?',
      ['Oui', 'Non']),
  Question(
      'Avez-vous été testé(e) positif pour le VIH (sida), ou VHB (hépatite B) ou VHC (hépatite C) ou la syphilis ?',
      ['Oui', 'Non']),
  Question('Avez-vous eu un cancer au cours de votre vie ?', ['Oui', 'Non']),
  Question(
      'Êtes-vous traité(e) pour une maladie chronique telle que : diabète (traité par insuline), maladie inflammatoire de l\'intestin, maladie auto-immune...?',
      ['Oui', 'Non']),
  Question(
      'Avez-vous déjà eu une transfusion de sang (globules rouges, plaquettes ou plasma) ou une greffe d\’organe ?',
      ['Oui', 'Non']),
  Question(
      'Avez-vous déjà pris des drogues illicites et/ou substances dopantes par voie intraveineuse ? ',
      ['Oui', 'Non']),
  Question(
      'Avez-vous fait un tatouage ou un piercing (oreilles comprises) dans les 4 derniers mois ?',
      ['Oui', 'Non']),
];
