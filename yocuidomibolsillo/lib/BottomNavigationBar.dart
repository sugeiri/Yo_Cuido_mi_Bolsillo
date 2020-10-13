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
        title: Text('YO CUIDO TU BOLSILLO'),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home,color: Colors.blue,),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.format_line_spacing,color:Colors.red),
            title: new Text('Transacciones'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on,color: Colors.green,),
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
