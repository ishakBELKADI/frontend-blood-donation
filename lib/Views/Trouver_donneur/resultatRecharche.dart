import 'package:flutter/material.dart';
import 'package:pfe/Views/Trouver_donneur/ConsulterEtCherherD.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/demandeClass.dart';
import 'package:pfe/models/donneur.dart';
import 'package:pfe/models/tokens.dart';
import 'package:pfe/notificationsTest.dart';

class Resultat extends StatefulWidget {
  final Donneur? element;

  Resultat({super.key, this.element});
  @override
  State<Resultat> createState() => ResultatPage();
}

class ResultatPage extends State<Resultat> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.element!.utilisateur.nom} ${widget.element!.utilisateur.prenom}   ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${widget.element!.utilisateur.groupSanguin}",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              height: 7,
            ),
            Row(
              children: [
                Text(
                  "${widget.element!.statu}  ",
                  style: TextStyle(fontSize: 16),
                ),
                if (widget.element!.statu == 'Apte')
                  Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 14,
                  )
                else
                  Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 14,
                  )
              ],
            ),
            Container(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${widget.element!.utilisateur.willaya}  -  ${widget.element!.utilisateur.daira}"),
                widget.element!.etatDemande != "Accepté"
                    ? MaterialButton(
                        onPressed: () async {
                          if (widget.element!.etatDemande == 'null') {
                            DemandeClass demanda = DemandeClass(
                                utilisateurdes: widget.element!.utilisateur.id,
                                utilisateurSrc: user!,
                                typeDemande: 'demande de sang',
                                etatDemande: 'Envoyé');

                            var response = addDataDjango(
                                demanda.toJson(), urlSite, 'createDemande/');
                            print(response);

                            var jsons = await getDataDjango(urlSite,
                                'recupereTokenUser/${widget.element!.utilisateur.id}');
                            List<Tokens>? lista = jsonToListToken(jsons);
                            print("on est la");
                            for (var element in lista!) {
                              sendNotifcation(
                                  "${user!.nom} - ${user!.prenom} a besoin de votre sang !",
                                  "vous avez reçu une demande de don de sang lieu de demandeur: ${user!.willaya} - ${user!.daira} ",
                                  element.token);
                              print("notif envoyé");
                            }

                            widget.element!.etatDemande = 'Envoyé';
                            setState(() {});
                          } else {
                            if (widget.element!.etatDemande == 'Envoyé') {
                              DemandeClass demanda = DemandeClass(
                                  utilisateurdes:
                                      widget.element!.utilisateur.id,
                                  utilisateurSrc: user!,
                                  typeDemande: 'demande de sang',
                                  etatDemande: 'Annulé');
                              updateDataDjango(
                                  demanda.toJson(),
                                  urlSite,
                                  'modifierEtatDemande/',
                                  '${widget.element!.utilisateur.id}/${user!.id}');
                              widget.element!.etatDemande = 'Annulé';
                              setState(() {});
                            } else {
                              if (widget.element!.etatDemande == 'Annulé') {
                                DemandeClass demanda = DemandeClass(
                                    utilisateurdes:
                                        widget.element!.utilisateur.id,
                                    utilisateurSrc: user!,
                                    typeDemande: 'demande de sang',
                                    etatDemande: 'Envoyé');
                                updateDataDjango(
                                    demanda.toJson(),
                                    urlSite,
                                    'modifierEtatDemande/',
                                    '${widget.element!.utilisateur.id}/${user!.id}');

                                widget.element!.etatDemande = 'Envoyé';
                                setState(() {});
                              }
                            }
                          }
                          print(widget.element!.etatDemande);
                          // setState(() {});
                        },
                        child: Text(
                          widget.element!.etatDemande != 'null' &&
                                  widget.element!.etatDemande == 'Envoyé'
                              ? "Demande ${widget.element!.etatDemande}"
                              : "Envoyer demande",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        color: Color(0xFFd20000),
                        textColor: Colors.white,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )
                    : IconButton(
                        onPressed: () {
                          appelerNumero(widget.element!.utilisateur.numtel);
                        },
                        icon: Icon(Icons.phone),
                        iconSize: 30,
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
