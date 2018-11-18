import 'package:flutter/material.dart';
import '../auth.dart';
import '../auth_provider.dart';
import 'list_orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onSignedOut;

  HomePage({this.onSignedOut});

  @override
  Widget build(BuildContext context) {

    void _signOut() async {
      try {
        var auth = AuthProvider.of(context).auth;
        await auth.signOut();
        onSignedOut();
      } catch (e) {
        print(e);
      }

    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Cake Manager'),
          actions: <Widget>[
            new FlatButton(
                onPressed: _signOut,
                child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white))
            )
          ],
        ),
        body: new ListOrders(),
    );
  }
}