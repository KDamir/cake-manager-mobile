import 'package:flutter/material.dart';

class CkTextField extends StatelessWidget {

  final Function onchange;
  final TextStyle style;
  final String hint;
  final String label;
  final TextEditingController controller;

  CkTextField({Key key,
    this.onchange,
    this.style,
    this.hint,
    this.label,
    this.controller,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        alignment: Alignment.bottomLeft,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            filled: true
          ),
          style: style,
          onChanged: onchange,
        )
    );
  }

}