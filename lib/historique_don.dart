import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/formulaire_don.dart';
import 'package:pfe/models/utilisateur.dart';

class historique extends StatefulWidget {
  final Utilisateur? utilisateur;
  const historique({super.key, this.utilisateur});

  @override
  State<historique> createState() => _historiqueState();
}

class _historiqueState extends State<historique> {
  bool waiting = true;
  String? message;
  List? donsUser;
  getDonuser() async {
    var response = await getDataDjango(
        urlSite, 'recupererDonUser/${widget.utilisateur!.id}');
    if (response is List)
      donsUser = response;
    else
      message = response["message"];
    print(donsUser);
    waiting = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDonuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return DonHistoryForm(
                  utilisateur: widget.utilisateur,
                );
              },
            ).then((value) {
              setState(() {});
              if (donfait != null && donfait == 'fait') {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: 'Don effectué',
                  desc: 'Don effectué avec succès !',
                  btnCancelOnPress: () {},
                  descTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  btnOkOnPress: () {
                    // Afficher le deuxième dialogue ici si nécessaire
                  },
                )..show();
              }
              if (donfait != null && donfait == 'nonfait') {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  title: 'Don Non effectué',
                  desc:
                      'vous ne pouvez pas effectuer plusieurs dons à la même date',
                  btnCancelOnPress: () {},
                  descTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  btnOkOnPress: () {
                    // Afficher le deuxième dialogue ici si nécessaire
                  },
                )..show();
              }
              getDonuser();
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 218, 52, 96),
          //Color.fromARGB(255, 249, 202, 213),
          elevation: 5,
          splashColor: Color.fromARGB(255, 250, 181, 197),
        ),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 220, 0, 59),
          titleTextStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: "AcherusFeral"),
          centerTitle: true,
          title: Text(
            "Historique de dons",
          ),
          /* backgroundColor: Color.fromARGB(255, 220, 0, 59),
            title: Text(
              "Historique de dons",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 251),
              ),
            ) */
        ),
        body: waiting == false && donsUser != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Card(
                      elevation: 3.0,
                      shadowColor: Color.fromARGB(255, 250, 181, 197),
                      color: Colors.white,
                      surfaceTintColor: Color.fromARGB(255, 255, 255, 250),
                      child: Container(
                        height: 80,
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, right: 30, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /*  Expanded(
                              child: Container(
                                color: Colors.grey,
                                height: 10,
                              ),
                            ), */
                            const Text(
                              "Total don",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 218, 52,
                                      96), //Color.fromARGB(255, 205, 1, 55),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${donsUser!.length}",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Color.fromARGB(255, 218, 52,
                                      96), //Color.fromARGB(255, 205, 1, 55),
                                  fontWeight: FontWeight.bold),
                            ),

                            /* Expanded(
                              child: Container(
                                color: Colors.grey,
                                height: 10,
                              ),
                            ), */
                          ],
                        ),
                      ),
                    ),
                    /*  Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.grey,
                            height: 10,
                          ),
                        ),
                        Container(
                            child: Text(
                                "Nombre de dons total : ${donsUser!.length}")),
                        Expanded(
                          child: Container(
                            color: Colors.grey,
                            height: 10,
                          ),
                        ),
                      ],
                    ), */
                    ...List.generate(donsUser!.length, (index) {
                      return Card(
                        color: Color.fromARGB(255, 255, 249, 251),
                        surfaceTintColor: Colors.white,
                        child: Container(
                          height: 150,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "date de don : ",
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    donsUser![index]["date_de_don"],
                                    style: TextStyle(
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 218, 52,
                                          96), // Color.fromARGB(255, 220, 0, 59)
                                    ),
                                  ),
                                  PopupMenuButton(
                                    onSelected: (value) async {
                                      if (value == 'supp') {
                                        var response = await deleteDataDjango(
                                            urlSite,
                                            'deleteDon/${widget.utilisateur!.id}/${donsUser![index]["date_de_don"]}');
                                        if (response["message"] ==
                                            "Don supprimé") {
                                          AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.info,
                                              animType: AnimType.rightSlide,
                                              title: 'Un don est supprimé',
                                              desc: 'vous avez supprimé un don',
                                              descTextStyle: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              autoHide: Duration(seconds: 1))
                                            ..show();
                                          donsUser!.removeAt(index);
                                          setState(() {});
                                        }
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text("Supprimer le don"),
                                          value: 'supp',
                                        )
                                      ];
                                    },
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "type de don : ",
                                      style: TextStyle(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(donsUser![index]["type_de_don"],
                                        style: TextStyle(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 218, 52,
                                              96), //Color.fromARGB(
                                          // 255, 220, 0, 59)
                                        )),
                                    SizedBox(
                                      width: 15,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "quantité : ",
                                      style: TextStyle(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        donsUser![index]["quantite"] != null
                                            ? donsUser![index]["quantite"]
                                                .toString()
                                            : "non precisé",
                                        style: TextStyle(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 218, 52, 96),
                                        )),
                                    SizedBox(
                                      width: 1,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                ),
              )
            : waiting == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text(message!),
                  ));
  }
}
