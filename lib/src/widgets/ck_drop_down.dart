import 'package:flutter/material.dart';

class CkDropDown extends StatelessWidget {
  final List<String> items;
  final String title;
  final String selected;
  final Function onchange;

  CkDropDown({Key key,
    this.items,
    this.title,
    this.selected,
    this.onchange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: title,
          hintText: 'Choose an item',
          contentPadding: EdgeInsets.zero,
        ),
        isEmpty: selected == null,
        child: DropdownButton<String>(
          value: selected,
          onChanged: onchange,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

}