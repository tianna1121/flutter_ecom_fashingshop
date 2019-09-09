import 'package:flutter/material.dart';
import 'package:flutter_ecomm/pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.red.shade900),
        home: Login());
  }
}
