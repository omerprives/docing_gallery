import 'package:flutter/material.dart';
import 'home_page.dart';
import 'http_client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'OpenSansHebrew-Regular'),
      home: HomePage(),
    );
  }
}
