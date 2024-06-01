import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pfe/Views/authentification/SignUp.dart';
import 'package:pfe/statistiques/questionnaireDon.dart';

Future<String?> getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print("=======The token is================");
  print(token);
  return token;
}

sendNotifcation(String title, String bodycontent, String? token) async {
  var headersList = {
    'Accept': '*/*',
    'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    'Content-Type': 'application/json',
    'Authorization':
        'key=AAAA8yBZXCc:APA91bHR3M3n1dkg8lYh7ULltqcBIioVSURC2VkF_ejIEzwRTexWrdrD9KgYQrsU_xxjrDUBas0O13HjZ8NO323Qx1xXY6ML99Iq_1WOWu7rne_lHGJw8I9G-kFOmKHi8zXxjNAOdJkF'
  };
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  var body = {
    "to": token,
    "notification": {"title": title, "body": bodycontent}
  };

  var req = http.Request('POST', url);
  req.headers.addAll(headersList);
  req.body = json.encode(body);

  var res = await req.send();
  final resBody = await res.stream.bytesToString();

  if (res.statusCode >= 200 && res.statusCode < 300) {
    print(resBody);
  } else {
    print(res.reasonPhrase);
  }
}

class Notificationtest extends StatefulWidget {
  @override
  State<Notificationtest> createState() => NotificationPage();
}

class NotificationPage extends State<Notificationtest> {
  Future<String?>? thistoken;
  //fonction pour recupérer les tokens des utilisateurs
  Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("=======The token is================");
    print(token);
    return token;
  }

  //fonction pour avoir la permission de systéme de notification
  myRequestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

//envoyer une notification
  sendNotifcation(String title, String bodycontent, String? token) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAA8yBZXCc:APA91bHR3M3n1dkg8lYh7ULltqcBIioVSURC2VkF_ejIEzwRTexWrdrD9KgYQrsU_xxjrDUBas0O13HjZ8NO323Qx1xXY6ML99Iq_1WOWu7rne_lHGJw8I9G-kFOmKHi8zXxjNAOdJkF'
    };
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = {
      "to": token,
      "notification": {"title": title, "body": bodycontent}
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }

// Onclick notification (Background)
  onClickNotificationBackground() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        if (message.data["type"].toString().toUpperCase() ==
            "demande".toUpperCase()) {
          print(
              "=============Se deriger vers la page des demande=================");
        } else {
          print("on est la");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => QuestionnaireDon(),
          ));
          // Navigator.of(context).pushNamed("questionnaire");
        }
      }
    });
  }

// Onclick notification (Terminated)
  onClickNotificationTerminated() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage!.data["type"] == "demande") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignUp()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => QuestionnaireDon()));
      }
    }

    // if (initialMessage != null && initialMessage.notification != null) {
    //   print("title : ${initialMessage.notification!.title}");
    //   print("type : ${initialMessage.data["type"]}");
    // }
  }

  @override
  void initState() {
    thistoken = getToken();
    onClickNotificationTerminated();
    onClickNotificationBackground();
    myRequestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          "systeme de notification",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                sendNotifcation(
                    "application ouverte",
                    "une notification forground",
                    await FirebaseMessaging.instance.getToken());
              },
              icon: Icon(Icons.notification_add))
        ],
      ),
    );
  }
}
