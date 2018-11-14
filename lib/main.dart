import 'package:flutter/material.dart';
import 'src/pages/root_page.dart';
import 'src/auth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new RootPage(auth: new Auth()),
    );
  }
}
