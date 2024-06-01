import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:pfe/dataStructur.dart';

List willaya_ville = ["willaya", "ville"];
int i = 0;

class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final String? title;
  final String hint;
  final String? argument;
  final bool isCitySelected;
  final List<SelectedListItem>? cities;
  final IconData? icon;
  const AppTextField({
    required this.textEditingController,
    this.title,
    this.validator,
    required this.hint,
    required this.isCitySelected,
    this.cities,
    Key? key,
    this.argument,
    this.icon,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  /// This is on text changed method which will display on city text field on changed.
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        isDismissible: true,
        // bottomSheetTitle: const Text(
        //   widget.titreInterieur,
        //   style: TextStyle(
        //     fontWeight: FontWeight.bold,
        //     fontSize: 20.0,
        //   ),
        // ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        clearButtonChild: const Text(
          'Clear',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.cities ?? [],
        selectedItems: (List<dynamic> selectedList) {
          print(selectedList.indexed);
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
              widget.textEditingController.text = item.name;
            }
          }
          willayaselected = list[0];
          setState(() {});
          showSnackBar(list.toString());
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Text(widget.title!)
            : const SizedBox(
                height: 5.0,
              ),
        TextFormField(
          validator: widget.validator,
          controller: widget.textEditingController,
          cursorColor: Colors.black,
          onTap: widget.isCitySelected
              ? () {
                  setState(() {});
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,

          //  InputDecoration(
          //           prefixIcon: Icon(
          //             Icons.location_city_rounded,
          //             // color: Colors.grey,
          //           ),
          //           enabledBorder: OutlineInputBorder(),
          //           hintText: "Bab ezzouar"),
          //     ),
          decoration: InputDecoration(
            errorStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            prefixIcon: Icon(
              widget.icon,
              color: Color.fromARGB(255, 220, 0, 59),
              // color: Colors.white,
            ),
            hintText: widget.textEditingController.text == ""
                ? widget.hint
                : widget.textEditingController.text,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              //color: Colors.white,
            ),
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            contentPadding: EdgeInsets.only(left: 30, top: 20, bottom: 20),
            filled: true,
            fillColor: Colors.grey[200],
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              // borderSide: BorderSide(
              //   width: 2.0,
              // ),
              // borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
