import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/demandeClass.dart';
import 'package:pfe/models/tokens.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:pfe/notificationsTest.dart';
import 'package:pfe/tools/card_demande.dart';

class Recu extends StatefulWidget {
  final List? demandesRecu;
  final Utilisateur utilisateur;

  const Recu({super.key, this.demandesRecu, required this.utilisateur});

  @override
  State<Recu> createState() => RecuState();
}

class RecuState extends State<Recu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ListView(
        children: [
          Container(
              margin: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "vous avez reçu ${widget.demandesRecu!.length} demande",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              )),
          ...List.generate(widget.demandesRecu!.length, (index) {
            return card_demande(
              nom: widget.demandesRecu![index]["utilisateur_src"]["nom"],
              prenom: widget.demandesRecu![index]["utilisateur_src"]["prenom"],
              blood: widget.demandesRecu![index]["utilisateur_src"]
                  ["groupSanguin"],
              adress: widget.demandesRecu![index]["utilisateur_src"]
                      ["willaya"] +
                  " - " +
                  widget.demandesRecu![index]["utilisateur_src"]["daira"],
              datedemande: widget.demandesRecu![index]["date_de_demande"],
              typedemande: widget.demandesRecu![index]["type_demande"],
              contenu: "Refuser",
              changer: true,
              accepted: () async {
                DemandeClass demanda = DemandeClass(
                    utilisateurdes: widget.utilisateur.id,
                    utilisateurSrc: Utilisateur.fromJson(
                        widget.demandesRecu![index]["utilisateur_src"]),
                    typeDemande: widget.demandesRecu![index]["type_demande"],
                    etatDemande: 'Accepté');
                updateDataDjango(
                    demanda.toJson(),
                    urlSite,
                    'modifierEtatDemande/',
                    '${widget.utilisateur.id}/${widget.demandesRecu![index]["utilisateur_src"]["id"]}');
                var jsons = await getDataDjango(urlSite,
                    'recupereTokenUser/${widget.demandesRecu![index]["utilisateur_src"]["id"]}');
                List<Tokens>? lista = jsonToListToken(jsons);
                print("on est la");
                for (var element in lista!) {
                  sendNotifcation(
                      "${widget.utilisateur.nom} - ${widget.utilisateur.prenom} a Accepté votre demande de sang!",
                      "",
                      element.token);
                  print("notif envoyé");
                }
                AwesomeDialog(
                        context: context,
                        transitionAnimationDuration: Duration(seconds: 1),
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Demande accepté',
                        descTextStyle: TextStyle(fontWeight: FontWeight.bold),
                        autoHide: Duration(seconds: 2))
                    .show();

                widget.demandesRecu!.removeAt(index);
                setState(() {});
              },
              refused: () {
                // DemandeClass demanda = DemandeClass(
                //     utilisateurdes: widget.utilisateur.id,
                //     utilisateurSrc: Utilisateur.fromJson(
                //         widget.demandesRecu![index]["utilisateur_src"]),
                //     typeDemande: widget.demandesRecu![index]["type_demande"],
                //     etatDemande: 'Annulé');
                deleteDataDjango(urlSite,
                    'supprimerDemande/${widget.utilisateur.id}/${widget.demandesRecu![index]["utilisateur_src"]["id"]}');
                // updateDataDjango(
                //     demanda.toJson(),
                //     urlSite,
                //     'modifierEtatDemande/',
                //     '${widget.utilisateur.id}/${widget.demandesRecu![index]["utilisateur_src"]["id"]}');

                setState(() {
                  widget.demandesRecu!.removeAt(index);
                });
              },
            );
          })
        ],
      ),
    );
  }
}
