import 'donneur.dart';
import 'utilisateur.dart';

class DemandeClass {
  Donneur? donneurDest;
  DateTime? dateDeDemande;
  Utilisateur utilisateurSrc;
  String typeDemande;
  String etatDemande;
  int? utilisateurdes;

  DemandeClass(
      {
      // required this.donneurDest,
      this.dateDeDemande,
      required this.utilisateurSrc,
      required this.typeDemande,
      required this.etatDemande,
      this.utilisateurdes});

  factory DemandeClass.fromJson(Map<String, dynamic> json) {
    return DemandeClass(
      // donneurDest: Donneur.fromJson(json['donneur_dest']),
      dateDeDemande: DateTime.parse(json['date_de_demande']),
      utilisateurSrc: Utilisateur.fromJson(json['utilisateur_src']),
      typeDemande: json['type_demande'],
      etatDemande: json['etat_demande'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'utilisateur_dest': utilisateurdes,
      // 'date_de_demande': dateDeDemande!.toIso8601String(),
      'utilisateur_src': utilisateurSrc.toJson(),
      'type_demande': typeDemande,
      'etat_demande': etatDemande,
    };
  }
}

// List<Demande> convertirListeDemandeDon(List<dynamic> jsonDemandes) {
//   List<Donneur> demandes = [];
//   for (var jsonDemande in jsonDemandes) {
//     // print(jsonDemande['utilisateur']);

//     Demande demande = Demande(
//       donneurdes: jsonDemande['donneur_dest_id'],
//       etatDemande: jsonDemande['etat_demande'],
//       typeDemande: jsonDemande['type_demande'],
//       dateDeDemande: jsonDemande['date_de_demande'], utilisateurSrc: null,


//     );
//     demandes.add(demande);
//   }
//   return Demands;
// }
