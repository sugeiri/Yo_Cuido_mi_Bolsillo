import 'package:flutter/material.dart';
import 'Home.dart';
import 'Transacciones.dart';
import 'Ahorro.dart';
class BottomNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<BottomNav> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Transacciones(),
    Ahorro()
  ];
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedLocation; // Option 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.add),
            title: new Text('Transacciones'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on),
              title: Text('Ahorro')
          )
        ],
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
