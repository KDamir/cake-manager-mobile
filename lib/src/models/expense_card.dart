import 'package:flutter/material.dart';


class ExpenseCard extends StatelessWidget {

  final String name;
  final String type;
  final double value;

  ExpenseCard({Key key,
    this.name,
    this.type,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text('$name $value тг.'),
            subtitle: Text('$type'),
          ),
        ],
      ),
    );
  }

}