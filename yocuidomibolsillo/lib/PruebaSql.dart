import 'package:flutter/material.dart';
import 'package:yocuidomibolsillo/sqllite.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('insert', style: TextStyle(fontSize: 20),),
              onPressed: () {_insert_Ingresos();},
            ),
            RaisedButton(
              child: Text('query', style: TextStyle(fontSize: 20),),
              onPressed: () {_query();},
            ),
            RaisedButton(
              child: Text('query', style: TextStyle(fontSize: 20),),
              onPressed: () {_query_cat();},
            ),
            /*RaisedButton(
              child: Text('update', style: TextStyle(fontSize: 20),),
              onPressed: () {_update();},
            ),
            RaisedButton(
              child: Text('delete', style: TextStyle(fontSize: 20),),
              onPressed: () {_delete();},
            ),*/
          ],
        ),
      ),
    );
  }

  // Button onPressed methods

  void _insert_Ingresos() async {
    final allRows = await dbHelper.queryIngresosRowCount();
    DateTime now = DateTime.now();
    String ii_fecha = DateFormat('yyyy-MM-dd').format(now);
    Map<String, dynamic> row = {
      DatabaseHelper.columnIdIngresos : allRows+1,
      DatabaseHelper.columnCategoriaIngresos : 12,
      DatabaseHelper.columnFechaIngresos : ii_fecha,
      DatabaseHelper.columnMontoIngresos  : 100
    };
    final id = await dbHelper.insertIngresos_(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryIngresosAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }
  void _query_cat() async {
    final allRows = await dbHelper.queryCategoriasAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }
/*
  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Mary',
      DatabaseHelper.columnAge  : 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }*/
}