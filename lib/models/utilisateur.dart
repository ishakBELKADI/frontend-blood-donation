class Utilisateur {
  int? id;
  String nom;
  String prenom;
  int numtel;
  String groupSanguin;
  String willaya;
  String daira;
  String email;
  Utilisateur(
      {required this.nom,
      required this.prenom,
      required this.numtel,
      required this.groupSanguin,
      required this.willaya,
      required this.daira,
      required this.email,
      this.id});

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      numtel: json['numtel'],
      groupSanguin: json['groupSanguin'],
      willaya: json['willaya'],
      daira: json['daira'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'numtel': numtel,
      'groupSanguin': groupSanguin,
      'willaya': willaya,
      'daira': daira,
      'email': email,
    };
  }
}
