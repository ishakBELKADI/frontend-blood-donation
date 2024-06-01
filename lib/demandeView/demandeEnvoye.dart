import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/demandeClass.dart';
import 'package:pfe/models/utilisateur.dart';

class Envoye extends StatefulWidget {
  final List? demandesEnvoyes;
  final Utilisateur utilisateur;

  const Envoye({super.key, this.demandesEnvoyes, required this.utilisateur});

  @override
  State<Envoye> createState() => EnvoyeState();
}

class EnvoyeState extends State<Envoye> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ListView(
        children: [
          Container(
              margin: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "vous avez envoyé ${widget.demandesEnvoyes!.length} demande",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              )),
          ...List.generate(widget.demandesEnvoyes!.length, (index) {
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
                          "${widget.demandesEnvoyes![index]["utilisateur_dest"]["nom"]} ${widget.demandesEnvoyes![index]["utilisateur_dest"]["prenom"]}   ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${widget.demandesEnvoyes![index]["utilisateur_dest"]["groupSanguin"]}",
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
                    Container(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "${widget.demandesEnvoyes![index]["utilisateur_dest"]["willaya"]}    "), ////hnaaa ${widget.demandesEnvoyes![index]["utilisateur_dest"]["daira"]}
                        MaterialButton(
                          onPressed: () async {
                            // if (widget.demandesEnvoyes![index]
                            //         ["etat_demande"] == 'null') {
                            //   Demande demanda = Demande(
                            //       utilisateurdes:
                            //           listDonneurs![index].utilisateur.id,
                            //       utilisateurSrc: widget.utilisateur,
                            //       typeDemande: 'demande de sang',
                            //       etatDemande: 'Envoyé');

                            //   var response = addDataDjango(
                            //       demanda.toJson(), urlSite, 'createDemande/');
                            //   print(response);

                            //   var jsons = await getDataDjango(urlSite,
                            //       'recupereTokenUser/${listDonneurs![index].utilisateur.id}');
                            //   List<Tokens>? lista = jsonToListToken(jsons);
                            //   print("on est la");
                            //   for (var element in lista!) {
                            //     sendNotifcation(
                            //         "${widget.utilisateur.nom} - ${widget.utilisateur.prenom} a besoin de votre sang !",
                            //         "vous avez reçu une demande de don de sang lieu de demandeur: ${widget.utilisateur.willaya} - ${widget.utilisateur.daira} ",
                            //         element.token);
                            //     print("notif envoyé");
                            //   }

                            //   listDonneurs![index].etatDemande = 'Envoyé';
                            // } else {
                            if (widget.demandesEnvoyes![index]
                                    ["etat_demande"] ==
                                'Envoyé') {
                              DemandeClass demanda = DemandeClass(
                                  utilisateurdes: widget.demandesEnvoyes![index]
                                      ["utilisateur_dest"]["id"],
                                  utilisateurSrc: widget.utilisateur,
                                  typeDemande: 'demande de sang',
                                  etatDemande: 'Annulé');
                              // updateDataDjango(
                              //     demanda.toJson(),
                              //     urlSite,
                              //     'modifierEtatDemande/',
                              //     '${widget.demandesEnvoyes![index]["utilisateur_dest"]["id"]}/${widget.utilisateur.id}');

                              // widget.demandesEnvoyes![index]["etat_demande"] =
                              //     'Annulé';

                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.question,
                                animType: AnimType.rightSlide,
                                title: 'voulez-vous annuler cette demande ?',
                                descTextStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  deleteDataDjango(
                                    urlSite,
                                    'supprimerDemande/${widget.demandesEnvoyes![index]["utilisateur_dest"]["id"]}/${widget.utilisateur.id}',
                                  );

                                  widget.demandesEnvoyes![index]
                                      ["etat_demande"] = 'Annulé';
                                  setState(() {});
                                },
                              ).show();
                              setState(() {});
                            } else {
                              if (widget.demandesEnvoyes![index]
                                      ["etat_demande"] ==
                                  'Annulé') {
                                DemandeClass demanda = DemandeClass(
                                    utilisateurdes:
                                        widget.demandesEnvoyes![index]
                                            ["utilisateur_dest"]["id"],
                                    utilisateurSrc: widget.utilisateur,
                                    typeDemande: 'demande de sang',
                                    etatDemande: 'Envoyé');
                                updateDataDjango(
                                    demanda.toJson(),
                                    urlSite,
                                    'modifierEtatDemande/',
                                    '${widget.demandesEnvoyes![index]["utilisateur_dest"]["id"]}/${widget.utilisateur.id}');

                                widget.demandesEnvoyes![index]["etat_demande"] =
                                    'Envoyé';
                              }
                            }
                            print(
                                widget.demandesEnvoyes![index]["etat_demande"]);
                            setState(() {});
                          },
                          child: Text(
                            widget.demandesEnvoyes![index]["etat_demande"] !=
                                        'null' &&
                                    widget.demandesEnvoyes![index]
                                            ["etat_demande"] ==
                                        'Envoyé'
                                ? "Demande ${widget.demandesEnvoyes![index]["etat_demande"]}"
                                : "Envoyer demande",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          color: Color(0xFFd20000),
                          textColor: Colors.white,
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
