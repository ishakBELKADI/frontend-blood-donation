import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pfe/Views/Trouver_donneur/ConsulterEtCherherD.dart';
import 'package:pfe/Views/Trouver_donneur/publierAnnonce.dart';
import 'package:pfe/Views/authentification/SignUp.dart';
import 'package:pfe/Views/authentification/dialogueGroupeSanguin.dart';
import 'package:pfe/Views/authentification/logIn.dart';
import 'package:pfe/demandeView/demande.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/dropdownPackage/dropdown.dart';
import 'package:pfe/dropdownPackage/test.dart';
import 'package:pfe/firebase_options.dart';
import 'package:pfe/gestioncompte/gestionCompte.dart';
import 'package:pfe/Views/open.dart';
import 'package:pfe/gestioncompte/gestionannonces.dart';
import 'package:pfe/gestioncompte/infopersonnels.dart';
import 'package:pfe/gestioncompte/signalerProbleme.dart';
import 'package:pfe/graphes.dart';
import 'package:pfe/notificationsTest.dart';
import 'package:pfe/statistiques/questionnaireDon.dart';
import 'package:pfe/testApimaps.dart';
import 'package:pfe/tools/bottom_navigation_bar.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print("==================Le titreee Background===============");
    print(message.notification!.title);
    print("data:");
    print(message.data);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  get http => null;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  bool? auth;
  String? groupeS;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "================une notification fourground est arrivé ==================");
      if (message.notification != null) {
        print("Contenue :");
        print("title : ${message.notification!.title}");
        print("body : ${message.notification!.body}");
        print("data:");
        print(message.data);

        if (_scaffoldMessengerKey.currentState != null) {
          _scaffoldMessengerKey.currentState!
              .showSnackBar(_buildSnackBar(context));
        }
      }
    });
  }

  SnackBar _buildSnackBar(BuildContext context) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_services,
                color: Colors.red,
              ),
              Text(
                '  Vous avez reçu une demande de Sang! ',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              gotodemande();
            },
            color: Colors.red,
            iconSize: 30,
            icon: Icon(Icons.mail_outlined),
          )
        ],
      ),
      backgroundColor: Colors.grey[300],
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
  }
gotodemande() {
  navigatorKey.currentState?.pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => Bottom_navigation_bar(i: 2),
    ),
    (route) => false, // Supprimez toutes les routes précédentes
  );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: _scaffoldMessengerKey,
      routes: {
        "login": (context) => LogIn(),
        "signup": (context) => SignUp(),
        "informations perso": (context) => Infoperso(),
        // "annonces perso": (context) => GestionAnnonce(),
        "demande": (context) => demande(),
        "profil": (context) => Profil(),
        "questionnaire": (context) => QuestionnaireDon(),
        "main": (context) => const MyApp(),
        "homepage": (context) => Bottom_navigation_bar(),
      },
      theme: ThemeData(
        fontFamily: "AcherusFeral",
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? Open()
          : Bottom_navigation_bar(),
    );
  }
}
