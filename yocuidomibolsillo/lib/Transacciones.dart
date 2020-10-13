import 'package:flutter/material.dart';

void main() {
  runApp(Transacciones());
}

class Transacciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: Colors.black87,
            bottom: TabBar(
              tabs: [
                Tab(text: "Ingresos",icon: Icon(Icons.attach_money,color: Colors.green)),
                Tab(text: "Gastos",icon: Icon(Icons.money_off,color: Colors.red)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                child: Row(
                    children: <Widget>[
                      Text("Ingresos")
                    ]
                ),
              ),
              Container(
                child: Row(
                    children: <Widget>[
                      Text("Gastos")
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}