import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yocuidomibolsillo/sqllite.dart';
import 'Ingresos_Class.dart';

void main() => runApp(Ingresos_Page());

final dbHelper = DatabaseHelper.instance;

class Ingresos_Page extends StatelessWidget {
  // It is the root widget of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IngresosPage(),
    );
  }
}

class IngresosPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IngresosPageState();
  }
}

class _IngresosPageState extends State<IngresosPage> {
  int _counter = 0;
  int TIngresos = 0;
  int TGastos = 0;
  int TSaldo = 0;

  @override
  Widget build(BuildContext context) {
    _Consulta_Saldos();
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.fromLTRB(3.0, 12.0, 3.0, 12.0),
          children: <Widget>[
            Container(
              height: 50,
              child: Text("INGRESOS",
                  style: TextStyle(fontSize: 20, color: Colors.green)),
            ),
            Expanded(
                child: FutureBuilder<List>(
              future: dbHelper.getAllIngresos(),
              initialData: List(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? new ListView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return _buildRow(snapshot.data[i]);
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ))
          ]),
    );
  }

  void _Consulta_Saldos() async {
    int LIngresos = 0;
    int LGastos = 0;
    final Ingresos = await dbHelper.queryIngresosAllRows();
    Ingresos.forEach((row) {
      LIngresos += int.parse(row['monto'].toString());
    });
    final Gastos = await dbHelper.queryGastosAllRows();
    Gastos.forEach((row) {
      LIngresos += int.parse(row['monto'].toString());
    });
    setState(() {
      TSaldo = LIngresos - LGastos;
      TIngresos = LIngresos;
      TGastos = LGastos;
    });
  }

  Widget _buildRow(Ingresos ingresos) {
    /*return new ListTile(
      title: new Text(ingresos.monto.toStringAsFixed(2)),
    );*/
    return new ListTile(
        title: new Text('${ingresos.descripcion.toUpperCase()} '),
        subtitle: new Text(
            '${ingresos.fecha} ---> ${ingresos.monto.toStringAsFixed(2)}'));
  }

  Widget _buildGastos(Gastos gastos) {
    return new ListTile(
        title: new Text('${gastos.descripcion.toUpperCase()} '),
        subtitle: new Text(
            '${gastos.fecha} ---> ${gastos.monto.toStringAsFixed(2)}'));

    /*setState(() {
      return new ListTile(
        title: new Text(gastos.fecha),
        subtitle: new Text('Cat: ${gastos.categoria}'),
        leading: new Icon(Icons.map),
        onTap: () {
          print(gastos.monto);
        },
      );
    });*/
  }
}
