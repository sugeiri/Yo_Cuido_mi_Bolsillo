import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yocuidomibolsillo/Lista.dart';
import 'package:yocuidomibolsillo/sqllite.dart';
import 'Ingresos_Class.dart';

void main() => runApp(Home());


final dbHelper = DatabaseHelper.instance;

class Home extends StatelessWidget {
  // It is the root widget of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _HomePageState();
  }
}

class _HomePageState extends State<MyHomePage> {
  int _counter = 0;
  int TIngresos = 0;
  int TGastos = 0;
  int TSaldo=0;

  @override
  Widget build(BuildContext context) {
    _Consulta_Saldos();
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(3.0, 12.0, 3.0, 12.0),
        children: <Widget>[
          Container(
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
            child: Card(
              child:
              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                  Widget>[
                Expanded(
                  child: Container(
                    height: 350,
                    color: Colors.black87,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Saldo Actual en Cuenta",
                            style: TextStyle(fontSize: 20, color: Colors.white60)),
                        Text("RD "+TSaldo.toStringAsFixed(2),
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
                                semanticLabel:'',
                              ),
                              Text("Ingresos",
                                  style:
                                  TextStyle(fontSize: 20, color: Colors.white60)),
                              Text("RD "+TIngresos.toStringAsFixed(2),
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
                                semanticLabel:'Text to announce in accessibility modes',
                              ),
                              Text("Gastos",
                                  style:
                                  TextStyle(fontSize: 20, color: Colors.white60)),
                              Text("RD "+TGastos.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.red)),
                            ]),
                      ],
                    ),
                  ),
                ),
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
                        return snapshot.hasData ?
                        new ListView.builder(
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
                    )
                ),
                Container(
                  height: 50,
                  child: Text("GASTOS",
                      style: TextStyle(fontSize: 20, color: Colors.red)),
                ),
                Expanded(
                    child:FutureBuilder<List>(
                    future: dbHelper.getAllGastos(),
                    initialData: List(),
                    builder: (context, snapshot) {
                      return snapshot.hasData ?
                      new ListView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return _buildGastos(snapshot.data[i]);
                        },
                      )
                          : Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                ),
              ]
              ),
            ),
          ),
        ],
      ),
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
      LGastos += int.parse(row['monto'].toString());
    });
    setState(() {
      TSaldo=LIngresos-LGastos;
      TIngresos=LIngresos;
      TGastos=LGastos;
    });
  }
  Widget _buildRow(Ingresos ingresos) {
    /*return new ListTile(
      title: new Text(ingresos.monto.toStringAsFixed(2)),
    );*/
    return new ListTile(
        title: new Text('${ingresos.descripcion.toUpperCase()} '),
        subtitle: new Text('${ingresos.fecha} ---> ${ingresos.monto.toStringAsFixed(2)}')
      );


  }
  Widget _buildGastos(Gastos gastos) {
    return new ListTile(
        title: new Text('${gastos.descripcion.toUpperCase()} '),
        subtitle: new Text('${gastos.fecha} ---> ${gastos.monto.toStringAsFixed(2)}')
    );

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
