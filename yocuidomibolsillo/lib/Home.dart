import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(Home());
List<double> Lingresos=new List<double>();
List<double> LGastos=new List<double>();
double Ingresos = 0;
double Gastos = 0;

class Home extends StatelessWidget {
  // It is the root widget of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Application',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Complex layout example'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.fromLTRB(3.0, 12.0, 3.0, 12.0),
      children: <Widget>[
        ProductBox(
            description: "Saldo Actual en Cuenta", Monto: 10000, tipo: "Total")
      ],
    ));
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({Key key, this.description, this.Monto, this.tipo})
      : super(key: key);
  final String description;
  final double Monto;
  final String tipo;

  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
              width: 1.0, color: Color(0xFFFFFFFFFF)),
          left: BorderSide(
              width: 1.0, color: Color(0xFFFFFFFFFF)),
          right: BorderSide(
              width: 1.0, color: Color(0xFFFF000000)),
          bottom: BorderSide(
              width: 1.0, color: Color(0xFFFF000000)),
        ),
      ),
      padding: EdgeInsets.all(2),
      height: 400,
      child: Card(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
            Widget>[
          Expanded(
            child: Container(

              color: Colors.black87,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Saldo Actual en Cuenta",
                      style: TextStyle(fontSize: 20, color: Colors.white60)),
                  Text(Saldo(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.trending_up,
                          color: Colors.green,
                          size: 30.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                        Text("Ingresos",
                            style: TextStyle(fontSize: 20, color: Colors.white60)),
                        Text(TIngresos(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.green)),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.trending_down,
                          color: Colors.red,
                          size: 30.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                        Text("Gastos",
                            style: TextStyle(fontSize: 20, color: Colors.white60)),
                        Text(TGastos(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.red)),
                      ]),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  String Saldo() {
    double s = Ingresos - Gastos;
    return "RD " + s.toStringAsFixed(2);
  }

  String TIngresos() {
    Ingresos=0;
    for(var i in Lingresos)
      {
        Ingresos+=i;
      }
    return "RD "+Ingresos.toStringAsFixed(2);
  }

  String TGastos() {
    Gastos=0;
    for(var i in LGastos)
    {
      Gastos+=i;
    }
    return "RD "+Gastos.toStringAsFixed(2);
  }
}
