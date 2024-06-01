import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

var urlSite = "http://10.0.2.2:8000/";
Future<dynamic> addDataDjango(dataAdd, url, suffix) async {
  var data = dataAdd;

  var jsonData = jsonEncode(data);
  print("===========les donnees envoyé=======");
  print(jsonData);
  var response = await http.post(
    Uri.parse(url + suffix),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonData,
  );
  print("===========l'URL de l'envoi =======");
  print(Uri.parse(url + suffix));
  var jsonresponse = json.decode(response.body);
  print(jsonresponse);

  if (response.statusCode == 200) {
    print("===========message from backend=========");
    print(jsonresponse["message"]);
  } else {
    print('Erreur lors de la publication des données: ${response.statusCode}');
    print("===========message from backend=========");
    print(jsonresponse["message"]);
  }
  return jsonresponse;
}

Future<Map<String, dynamic>> getOneDataDjango(url, attribut, suffix) async {
  var response = await http.get(Uri.parse(url + suffix + attribut));
  print("======URL GET=======");
  print(url + suffix + attribut);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

updateDataDjango(dataAdd, url, suffix, id) async {
  var response = await http.put(
    Uri.parse(url + suffix + id),
    body: json.encode(dataAdd),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(
    Uri.parse(url + suffix),
  );
  if (response.statusCode == 200) {
    print("tuple updated");
  } else {
    print('Erreur lors de la publication des données: ${response.statusCode}');
  }
}

getDataDjango(url, suffix) async {
  try {
    var response = await http.get(Uri.parse(url + suffix));

    if (response.statusCode == 200) {
      print("data ramenéé");
      var jsonresponse = response.body;
      var data = jsonDecode(jsonresponse);
      print(data);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print("==========error============");
    print(e);
  }
}

deleteDataDjango(url, suffix) async {
  print(url + suffix);

  var response = await http.delete(Uri.parse(url + suffix));
  if (response.statusCode == 200) {
    print("DEEEEELETED");
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  } else {
    print(jsonDecode(response.body));
    print(response.statusCode);
    return jsonDecode(response.body);
  }
}

class Connectivity extends StatefulWidget {
  @override
  State<Connectivity> createState() => ConnectivityState();
}

class ConnectivityState extends State<Connectivity> {
  List note = [];
  getDataDjango(url, attribut, suffix) async {
    try {
      var response = await http.get(Uri.parse(url + suffix));

      // print(response.body);
      if (response.statusCode == 200) {
        setState(() {});
        print(note[0]["id"]);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("==========error============");
      print(e);
    }
  }

  addDataDjango(dataAdd, url, suffix) async {
    var data = dataAdd;

    // Encodez les données au format JSON
    var jsonData = jsonEncode(data);

    // Remplacez 'http://votre_api_django/endpoint' par l'URL de votre endpoint Django
    var response = await http.post(
      Uri.parse(url + suffix),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonData,
    );
    print(Uri.parse(url + suffix));
    var jsonresponse = json.decode(response.body);

    if (response.statusCode == 200) {
      // Réponse réussie
      print('Données postées avec succès');
      print("===========message from backend=========");
      print(jsonresponse["message"]);
    } else {
      // Gestion des erreurs
      print(
          'Erreur lors de la publication des données: ${response.statusCode}');
      print("===========message from backend=========");
      print(jsonresponse["message"]);
    }
  }

  updateDataDjango(dataAdd, url, suffix, id) async {
    var response = await http.put(
      Uri.parse(url + suffix),
      body: json.encode(dataAdd),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(
      Uri.parse(url + suffix),
    );
    if (response.statusCode == 200) {
      print("tuple updated");
    } else {
      print(
          'Erreur lors de la publication des données: ${response.statusCode}');
    }
  }

  deleteNoteDjango(url, suffix) async {
    print(url + suffix);

    var response = await http.delete(Uri.parse(url + suffix));
    if (response.statusCode == 200) {
      print("DEEEEELETED");
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }

  var url = "http://10.0.2.2:8000/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            var dataAdd = {
              "nom": "flutter ",
              "email": "ishakess80@gmail.com",
              "prenom": "flutter user",
              "numtel": "99899",
              "groupSanguin": "O+",
              "willaya": "Alger",
              "daira": "el harrach",
            };

            addDataDjango(dataAdd, url, "createUser/");
          },
          backgroundColor: Colors.blue,
          child: Icon(Icons.add)),
      appBar: AppBar(
        title: Text(
          "Test Connectivity",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  // getDataDjango();
                  setState(() {});
                },
                child: Text("remenez data")),
            ...List.generate(
              note.length,
              (index) {
                return Card(
                  child: ListTile(
                      title: Text(note[index]["body"]),
                      leading: Text("${note[index]["id"]}"),
                      trailing: IconButton(
                          onPressed: () {
                            deleteNoteDjango(
                                url, "Notes/${note[index]["id"]}/delete");
                          },
                          icon: Icon(Icons.delete))),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
