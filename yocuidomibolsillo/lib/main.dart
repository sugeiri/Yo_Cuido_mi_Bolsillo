import 'package:flutter/material.dart';
import 'BottomNavigationBar.dart';
import 'package:yocuidomibolsillo/PruebaSql.dart';

void main() => runApp(App());
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YO CUIDO TU BOLSILLO',
      home: BottomNav(),
    );
  }
}