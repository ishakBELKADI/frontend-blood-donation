import 'utilisateur.dart';

class Donneur {
  int? id;
  Utilisateur utilisateur;
  String statu;
  DateTime? dateDernierDon;
  String? etatDemande;

  Donneur(
      {required this.utilisateur,
      required this.statu,
      this.dateDernierDon,
      this.id,
      this.etatDemande});

  factory Donneur.fromJson(Map<String, dynamic> json) {
    return Donneur(
        utilisateur: Utilisateur.fromJson(json['utilisateur']),
        statu: json['statu'],
        dateDernierDon: json['date_dernier_don'] != null
            ? DateTime.parse(json['date_dernier_don'])
            : null,
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'utilisateur': utilisateur.toJson(),
      'statu': statu,
      'date_dernier_don': dateDernierDon?.toIso8601String(),
      'id': id
    };
  }
}

List<Donneur> convertirListeDonneurs(List<dynamic> jsonDonneurs) {
  List<Donneur> donneurs = [];
  for (var jsonDonneur in jsonDonneurs) {
    // print(jsonDonneur['utilisateur']);

    Donneur donneur = Donneur(
        utilisateur: Utilisateur.fromJson(jsonDonneur['utilisateur']),
        statu: jsonDonneur['statu'],
        id: jsonDonneur['id'],
        dateDernierDon: jsonDonneur['dateDernierDon'] != null
            ? DateTime.parse(jsonDonneur['dateDernierDon'])
            : null,
        etatDemande: jsonDonneur['etat_demande']);
    donneurs.add(donneur);
  }
  return donneurs;
}
