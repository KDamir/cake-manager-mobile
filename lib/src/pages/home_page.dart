import 'package:flutter/material.dart';
import '../auth.dart';
import 'list_orders.dart';

class HomePage extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback onSignOut;

  HomePage({this.auth, this.onSignOut});

  @override
  Widget build(BuildContext context) {

    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
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
        body: new ListOrders(auth),
    );
  }
}