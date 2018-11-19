import 'package:flutter/material.dart';

class CakeCard extends StatelessWidget {

  final String title;
  final String description;
  final Function onPress;

  CakeCard({Key key,
    this.title,
    this.description,
    this.onPress,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text('$title'),
            subtitle: Text('$description'),
            onTap: () => onPress(),
          ),
        ],
      ),
    );
  }

}