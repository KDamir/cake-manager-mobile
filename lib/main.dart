import 'package:flutter/material.dart';
import 'src/pages/root_page.dart';
import 'src/auth.dart';
import 'src/auth_provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Cake manager',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: RootPage(),
      ),
    );
  }
}
