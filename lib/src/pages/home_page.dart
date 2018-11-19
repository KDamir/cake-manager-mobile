import 'package:flutter/material.dart';
import 'package:mobile/src/pages/expense_page.dart';
import '../auth.dart';
import '../auth_provider.dart';
import 'list_orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final VoidCallback onSignedOut;

  HomePage({this.onSignedOut});

  final drawerItems = [
    new DrawerItem("Заказы", Icons.rss_feed),
    new DrawerItem("Расходы", Icons.info),
  ];

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new ListOrders();
      case 1:
        return new ExpensePage();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {

    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    void _signOut() async {
      try {
        var auth = AuthProvider.of(context).auth;
        await auth.signOut();
        widget.onSignedOut();
      } catch (e) {
        print(e);
      }

    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
        actions: <Widget>[
          new FlatButton(
              onPressed: _signOut,
              child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white))
          )
        ],
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
      drawer: Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("John Doe"), accountEmail: null),
            new Column(children: drawerOptions)
          ],
        ),
      ),
    );
  }

}