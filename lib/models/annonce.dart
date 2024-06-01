import 'dart:ffi';

import 'utilisateur.dart';

class Annonce {
  int? id;
  Utilisateur utilisateur;
  String description;
  String groupSanguin;
  String? type_de_don;
  String? place;
  double? latitude;
  double? longitude;
  DateTime? dateDePublication;
  DateTime? dateDeDonMax;
  int? numeroTelephone;
  DateTime? dateDeModification;
  String? etatdemande;
  Annonce(
      {required this.utilisateur,
      required this.description,
      required this.groupSanguin,
      this.type_de_don,
      this.dateDePublication,
      this.place,
      this.dateDeDonMax,
      this.numeroTelephone,
      this.dateDeModification,
      this.id,
      this.etatdemande,
      this.latitude,
      this.longitude});

  factory Annonce.fromJson(Map<String, dynamic> json) {
    return Annonce(
      utilisateur: Utilisateur.fromJson(json['utilisateur']),
      description: json['description'],
      id: json['id'],
      type_de_don: json['type_de_don'],
      groupSanguin: json['groupSanguin'],
      place: json['place'],
      dateDeDonMax: json['date_de_Don_max'] != null
          ? DateTime.parse(json['date_de_Don_max'])
          : null,
      numeroTelephone: json['numerotelephone'],
      dateDeModification: json['date_de_modification'] != null
          ? DateTime.parse(json['date_de_modification'])
          : null,
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'utilisateur': utilisateur.toJson(),
      'description': description,
      'groupSanguin': groupSanguin,
      'place': place,
      'id': id,
      'type_de_don': type_de_don,
      'date_de_Don_max': dateDeDonMax?.toIso8601String(),
      'numerotelephone': numeroTelephone,
      'date_de_modification': dateDeModification?.toIso8601String(),
      'longitude': longitude,
      'latitude': latitude
    };
  }
}

List<Annonce> convertirListeAnnonces(List<dynamic> jsonAnnonces) {
  List<Annonce> annonces = [];
  for (var jsonAnnonce in jsonAnnonces) {
    print("=============");
    print(jsonAnnonce['longitude']);

    Annonce annonce = Annonce(
        utilisateur: Utilisateur.fromJson(jsonAnnonce['utilisateur']),
        description: jsonAnnonce['description'],
        id: jsonAnnonce['id'],
        groupSanguin: jsonAnnonce['groupSanguin'],
        place: jsonAnnonce['place'],
        dateDePublication: jsonAnnonce['date_de_publication'] != null
            ? DateTime.parse(jsonAnnonce['date_de_publication'])
            : null,
        dateDeDonMax: jsonAnnonce['date_de_Don_max'] != null
            ? DateTime.parse(jsonAnnonce['date_de_Don_max'])
            : null,
        numeroTelephone: jsonAnnonce['numerotelephone'],
        type_de_don: jsonAnnonce['type_de_don'],
        dateDeModification: jsonAnnonce['date_de_modification'] != null
            ? DateTime.parse(jsonAnnonce['date_de_modification'])
            : null,
        etatdemande: jsonAnnonce['etat_demande'],
        latitude: jsonAnnonce['latitude'],
        longitude: jsonAnnonce['longitude']);
    annonces.add(annonce);
  }
  return annonces;
}
