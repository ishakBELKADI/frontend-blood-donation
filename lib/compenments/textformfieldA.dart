import 'package:flutter/material.dart';

class Textapp extends StatelessWidget {
  final String contenue;
  final double fontzsize;
  final Color? color;
  const Textapp(
      {super.key, required this.contenue, required this.fontzsize, this.color});
  @override
  Widget build(BuildContext context) {
    return Text(contenue,
        // textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: this.fontzsize,
          fontWeight: FontWeight.bold,
        ));
  }
}

// ignore: must_be_immutable
class TextForm extends StatelessWidget {
  final Icon i;
  final String label;
  Widget? suffix;
  void Function()? function;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  final TextInputType? type;

  TextForm(
      {super.key,
      required this.label,
      required this.i,
      suffix,
      function,
      this.validator,
      this.textEditingController,
      this.type});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      controller: textEditingController,
      validator: validator,
      // style: TextStyle(
      //   fontSize: 16,
      //   fontWeight: FontWeight.bold,
      //   color: Colors.white,
      // ),
      onTap: function,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
        suffix: suffix,
        prefixIcon: i,
        hintText: label,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.only(left: 30, top: 20, bottom: 20),
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.grey),
        ),
      ),
    );
  }
}
