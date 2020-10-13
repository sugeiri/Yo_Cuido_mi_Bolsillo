import 'package:flutter/material.dart';

class Transacciones extends StatelessWidget {
  Transacciones();

  @override
  Widget build(BuildContext context) {
    return  ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: const Card(child: Text("2")),
    );
  }
}