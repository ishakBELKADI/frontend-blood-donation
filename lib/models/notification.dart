class Notification {
  String typeDeNotif;
  String titre;
  String contenu;

  Notification({
    required this.typeDeNotif,
    required this.titre,
    required this.contenu,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      typeDeNotif: json['type_de_notif'],
      titre: json['titre'],
      contenu: json['contenu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type_de_notif': typeDeNotif,
      'titre': titre,
      'contenu': contenu,
    };
  }
}
