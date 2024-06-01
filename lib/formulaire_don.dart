import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pfe/djangoTest.dart';
import 'package:pfe/models/donneur.dart';
import 'package:pfe/models/effectuedon.dart';
import 'package:pfe/models/utilisateur.dart';
import 'package:flutter/services.dart';

String? donfait = null;

class DonHistoryForm extends StatefulWidget {
  final Utilisateur? utilisateur;

  const DonHistoryForm({super.key, this.utilisateur});
  @override
  _DonHistoryFormState createState() => _DonHistoryFormState();
}

class _DonHistoryFormState extends State<DonHistoryForm> {
  String _selectedDonationType = 'Sang';
  DateTime _selectedDate = DateTime.now();
  ////////
  final TextEditingController _controller = TextEditingController();
  final int _maxQuantity = 450;
  String message = "";

  bool _submitQuantity() {
    final int? quantity = int.tryParse(_controller.text);

    if (quantity == null || quantity == 0) {
      message = "Veuillez entrer une valeur numérique.";
      return false;
    } else if (quantity > _maxQuantity) {
      message = "La quantité ne peut pas dépasser $_maxQuantity ml.";
      return false;
    } else {
      message = "Quantité acceptée: $quantity ml.";
      return true;
    }
  }

//////
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title: Text('Ajouter un Don'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.50,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Color.fromARGB(255, 220, 0, 59),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Date de Don :',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 220, 0, 59),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "${_selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.bloodtype_outlined,
                  color: Color.fromARGB(255, 220, 0, 59),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Type de Don :',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 220, 0, 59),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            RadioListTile(
              activeColor: Color.fromARGB(255, 220, 0, 59),
              title: Text('Sang'),
              value: 'Sang',
              groupValue: _selectedDonationType,
              onChanged: (String? value) {
                setState(() {
                  _selectedDonationType = value!;
                });
              },
            ),
            RadioListTile(
              title: Text(
                'Plaquette',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              activeColor: Color.fromARGB(255, 220, 0, 59),
              value: 'Plaquette',
              groupValue: _selectedDonationType,
              onChanged: (String? value) {
                setState(() {
                  _selectedDonationType = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('Plasma'),
              activeColor: Color.fromARGB(255, 220, 0, 59),
              value: 'Plasma',
              groupValue: _selectedDonationType,
              onChanged: (String? value) {
                setState(() {
                  _selectedDonationType = value!;
                });
              },
            ),
            Row(
              children: [
                Icon(
                  Icons.percent,
                  color: Color.fromARGB(255, 220, 0, 59),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Quantité :',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 220, 0, 59),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 140,
              child: TextField(
                maxLength: 3,
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "ml",
                  border: UnderlineInputBorder(),
                  //suffixText: "ml",
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                donfait = null;
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
            TextButton(
              onPressed: () async {
                if (_submitQuantity() != false) {
                  print(widget.utilisateur!.id);
                  Donneur donneur =
                      Donneur(utilisateur: widget.utilisateur!, statu: 'Apte');
                  EffectueDon don = EffectueDon(
                      donneur: donneur,
                      dateDeDon: _selectedDate,
                      typeDeDon: _selectedDonationType,
                      quantite: int.tryParse(_controller.text));
                  var response =
                      await addDataDjango(don.toJson(), urlSite, 'creeDon/');
                  if (response["message"] ==
                      'Un Don est crée et a été effectué') {
                    // AwesomeDialog(
                    //   context: context,
                    //   dialogType: DialogType.success,
                    //   animType: AnimType.rightSlide,
                    //   title: 'Don effectué',
                    //   desc: 'Don effectué avec succeés !',
                    //   btnCancelOnPress: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   descTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    //   btnOkOnPress: () {
                    //     Navigator.of(context).pop();
                    //   },
                    // )..show();
                    donfait = 'fait';
                    Navigator.of(context).pop();
                  } else {
                    // AwesomeDialog(
                    //   context: context,
                    //   dialogType: DialogType.error,
                    //   animType: AnimType.rightSlide,
                    //   title: 'Don Non effectué',
                    //   desc:
                    //       'vous pouvez pas effectuer plusieurs don dans la meme date',
                    //   btnCancelOnPress: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   descTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    //   btnOkOnPress: () {
                    //     Navigator.of(context).pop();
                    //   },
                    // )..show();
                    donfait = 'nonfait';
                    Navigator.of(context).pop();
                  }
                } else {
                  print(message);
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Erreur',
                    desc: message,
                    btnCancelOnPress: () {
                      Navigator.of(context).pop();
                    },
                    descTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    btnOkOnPress: () {
                      Navigator.of(context).pop();
                    },
                  )..show();
                  donfait == null;
                }
              },
              child: Text(
                'Ajouter',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
