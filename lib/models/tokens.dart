import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/utilisateur.dart';

class Tokens {
  String token;
  Utilisateur? utilisateur;

  Tokens({required this.token, this.utilisateur});

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      token: json['token'],
      utilisateur: Utilisateur.fromJson(json['utilisateur']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'utilisateur': utilisateur != null ? utilisateur!.toJson() : null
    };
  }

  addtoken() {
    addDataDjango(this.toJson(), urlSite, 'createToken/');
  }
}

List<Tokens>? jsonToListToken(List<dynamic> jsons) {
  List<Tokens>? lista = [];

  for (var json in jsons) {
    lista.add(Tokens(token: json["token"]));
  }
  return lista;
}
