import 'package:flutter/material.dart';

class Transacciones extends StatelessWidget {
  Transacciones();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 800,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
            left: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
          ),
        ),
        padding: EdgeInsets.all(2),
        child: TabBarView(
          children: [
            Center(
                child: Text(
                  "0",
                  style: TextStyle(fontSize: 40),
                )),
            Center(
                child: Text(
                  "1",
                  style: TextStyle(fontSize: 40),
                )),
          ],
        ));
  }
}
