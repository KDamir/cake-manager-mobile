import 'package:flutter/material.dart';
import '../utils/date_item.dart';

class DateTimeColumn extends StatelessWidget {

  final TextStyle style;
  final DateTime dateTime;
  final Function onchange;

  DateTimeColumn({Key key,
    this.style,
    this.dateTime,
    this.onchange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('To', style: style),
        DateTimeItem(
          dateTime: dateTime,
          onChanged: onchange,
        ),
      ]
    );
  }

}