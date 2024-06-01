import 'package:flutter/material.dart';

String? v;

class GroupeSanguin extends StatefulWidget {
  @override
  // TODO: implement key

  GroupeSanguin({
    super.key,
  });
  @override
  State<GroupeSanguin> createState() => GroupeSanguinPage();
}

class GroupeSanguinPage extends State<GroupeSanguin> {
  String? res = v;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Text(
            "Quelle est votre groupe sanguin?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: Text("A+"),
                  value: "A+",
                  activeColor: Colors.red,
                  groupValue: res,
                  onChanged: (value) {
                    v = value;
                    res = value;

                    print(res);
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text("A-"),
                  value: "A-",
                  groupValue: res,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    v = value;

                    res = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: Text("B+"),
                  value: "B+",
                  activeColor: Colors.red,
                  groupValue: res,
                  onChanged: (value) {
                    v = value;

                    res = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text("B-"),
                  value: "B-",
                  groupValue: res,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    v = value;
                    res = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: Text("AB+"),
                  value: "AB+",
                  activeColor: Colors.red,
                  groupValue: res,
                  onChanged: (value) {
                    v = value;

                    res = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text("AB-"),
                  value: "AB-",
                  activeColor: Colors.red,
                  groupValue: res,
                  onChanged: (value) {
                    v = value;

                    res = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: Text("O+"),
                  activeColor: Colors.red,
                  value: "O+",
                  groupValue: res,
                  onChanged: (value) {
                    v = value;

                    res = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text("O-"),
                  value: "O-",
                  groupValue: res,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    v = value;

                    res = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
