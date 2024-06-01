import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class QuestionnaireDon extends StatefulWidget {
  @override
  State<QuestionnaireDon> createState() => QuestionnaireDonPage();
}

class QuestionnaireDonPage extends State<QuestionnaireDon> {
  bool doneffectue = true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.infoReverse,
        animType: AnimType.rightSlide,
        title: 'Statistique',
        desc: 'Avez vous effectué un don cette semain',
        btnOkText: "Oui",
        btnCancelText: "Non",
        btnCancelOnPress: () {
          doneffectue = false;
          setState(() {});
        },
        descTextStyle: TextStyle(fontWeight: FontWeight.bold),
        btnOkOnPress: () {
          doneffectue = true;
          setState(() {});
        },
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // // if (doneffectue == false) {
                // //   AwesomeDialog(
                // //     context: context,
                // //     dialogType: DialogType.success,
                // //     animType: AnimType.rightSlide,
                // //     title: 'Merci pour votre reponse ',
                // //     // desc: 'Avez vous effectué un don cette semain',
                // //     // btnOkText: "Oui",
                // //     // btnCancelText: "Non",
                // //     // btnCancelOnPress: () {
                // //     //   doneffectue = false;
                // //     //   setState(() {});
                // //     // },
                // //     // descTextStyle: TextStyle(fontWeight: FontWeight.bold),
                // //     // btnOkOnPress: () {
                // //     //   doneffectue = true;
                // //     //   setState(() {});
                // //     // },
                // //   ).show();
                // }
                // showDialog(
                //   barrierDismissible: false,
                //   context: context,
                //   builder: (context) {
                //     return AlertDialog(
                //       title: Text(
                //         "Avez vous effectué un Don cette semaine?",
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //       actions: [
                //         TextButton(
                //             onPressed: () {},
                //             child: Text(
                //               "OUI",
                //               style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.red),
                //             )),
                //         TextButton(
                //             onPressed: () {},
                //             child: Text("NON",
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                     color: Colors.red)))
                //       ],
                //     );
                //   },
                // );
              },
              icon: Icon(Icons.abc))
        ],
        title: Text("Le questionnaire de don chaque semaine "),
        backgroundColor: Colors.red,
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            height: 300,
          ),
          Icon(
            Icons.verified,
            color: Colors.green,
            size: 100,
          ),
          Container(
            height: 10,
          ),
          Text(
            "Merci pour votre reponse..!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ],
      )),
    );
  }
}
