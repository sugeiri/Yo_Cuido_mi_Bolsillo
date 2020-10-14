import 'dart:async';

import 'package:flutter/widgets.dart';

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'Categorias.dart';
import 'Ingresos_Class.dart';

class DatabaseHelper {

  static final _databaseName = "YoCuidoMiBolsillo.db";
  static final _databaseVersion = 1;

  static final table_Categoria = 'Categorias';
  static final columnId = '_id';
  static final columnDescripcion = 'descripcion';
  static final columnTipo = 'tipo';

  static final table_Ingresos = 'Ingresos';
  static final columnIdIngresos = '_id';
  static final columnCategoriaIngresos = 'categoria';
  static final columnFechaIngresos = 'fecha';
  static final columnMontoIngresos = 'monto';

  static final table_Gastos = 'Gastos';
  static final columnIdGastos = '_id';
  static final columnCategoriaGastos = 'categoria';
  static final columnFechaGastos = 'fecha';
  static final columnMontoGastos = 'monto';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table_Categoria (
            $columnId INTEGER PRIMARY KEY,
            $columnDescripcion TEXT NOT NULL,
            $columnTipo TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $table_Ingresos (
            $columnIdIngresos INTEGER PRIMARY KEY,
            $columnCategoriaIngresos INT NOT NULL,
            $columnFechaIngresos TEXT NOT NULL,
            $columnMontoIngresos INT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $table_Gastos (
            $columnIdGastos INTEGER PRIMARY KEY,
            $columnCategoriaGastos INT NOT NULL,
            $columnFechaGastos TEXT NOT NULL,
            $columnMontoGastos INT NOT NULL
          )
          ''');

    Map<String, dynamic> row= {
      DatabaseHelper.columnId:1,DatabaseHelper.columnDescripcion:'Automovil',DatabaseHelper.columnTipo:'G'
    };
    insertCategoria_(row);
    row={DatabaseHelper.columnId:2,DatabaseHelper.columnDescripcion:'Facturas',DatabaseHelper.columnTipo:'G'};
    insertCategoria_(row);
    row={DatabaseHelper.columnId:3,DatabaseHelper.columnDescripcion:'Ropa',DatabaseHelper.columnTipo:'G'};
    insertCategoria_(row);
    row={DatabaseHelper.columnId:4,DatabaseHelper.columnDescripcion:'Entretenimiento',DatabaseHelper.columnTipo:'G'};
    insertCategoria_(row);
    row={DatabaseHelper.columnId:5,DatabaseHelper.columnDescripcion:'Comida',DatabaseHelper.columnTipo:'G'};
    insertCategoria_(row);
    row={DatabaseHelper.columnId:6,DatabaseHelper.columnDescripcion:'Gasolina',DatabaseHelper.columnTipo:'G'};
    insertCategoria_(row);
    row={DatabaseHelper.columnId:7,DatabaseHelper.columnDescripcion:'Regalos',DatabaseHelper.columnTipo:'G'};
    insertCategoria_(row);
    row={DatabaseHelper.columnId:8,DatabaseHelper.columnDescripcion:'Salud',DatabaseHelper.columnTipo:'G'};
    insertCategoria_(row);
    row={DatabaseHelper.columnId:9,DatabaseHelper.columnDescripcion:'Hogar',DatabaseHelper.columnTipo:'G'};
    insertCategoria_(row);
    row={DatabaseHelper.columnId:10,DatabaseHelper.columnDescripcion:'Ocio',DatabaseHelper.columnTipo:'G'};
    insertCategoria_(row);
    row={DatabaseHelper.columnId:11,DatabaseHelper.columnDescripcion:'Otro',DatabaseHelper.columnTipo:'G'};
    insertCategoria_(row);
    row={DatabaseHelper.columnId:12,DatabaseHelper.columnDescripcion:'Premio',DatabaseHelper.columnTipo:'I'};
    insertCategoria_(row);
    row={DatabaseHelper.columnId:13,DatabaseHelper.columnDescripcion:'Sueldo',DatabaseHelper.columnTipo:'I'};
    insertCategoria_(row);
    row={DatabaseHelper.columnId:14,DatabaseHelper.columnDescripcion:'Otro',DatabaseHelper.columnTipo:'I'};
    insertCategoria_(row);

  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertCategoria_(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table_Categoria, row);
  }
  Future<int> insertGastos_(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table_Gastos, row);
  }
  Future<int> insertIngresos_(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table_Ingresos, row);
  }
  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryCategoriasAllRows() async {
    Database db = await instance.database;
    return await db.query(table_Categoria);
  }
  Future<List<Map<String, dynamic>>> queryIngresosAllRows() async {
    Database db = await instance.database;
    return await db.query(table_Ingresos);
  }
  Future<List<Map<String, dynamic>>> queryGastosAllRows() async {
    Database db = await instance.database;
    return await db.query(table_Gastos);
  }
  Future<List<Ingresos>> getAllIngresos() async {
    Database db = await instance.database;
    var res = await db.rawQuery('SELECT Ingresos._id,Ingresos.categoria,fecha,monto,Categorias.descripcion FROM Ingresos,Categorias WHERE Categorias._id=Ingresos.categoria');

    List<Ingresos> list =
    res.isNotEmpty ? res.map((c) => Ingresos.fromMap(c)).toList() : null;
    return list;
  }

  Future<List<Gastos>> getAllGastos() async {
    Database db = await instance.database;
    var res = await db.rawQuery('SELECT Gastos._id,Gastos.categoria,fecha,monto,Categorias.descripcion FROM Gastos,Categorias WHERE Categorias._id=Gastos.categoria');
  List<Gastos> list =
    res.isNotEmpty ? res.map((c) => Gastos.fromMap(c)).toList() : null;
    return list;
  }
  Future<List<Categoria>> getCategoriaIngreso() async {
    Database db = await instance.database;
    var res = await db.query(table_Categoria);
    List<Categoria> list =
    res.isNotEmpty ? res.map((c) => Categoria.fromMap(c)).toList() : null;
    return list;
  }

  Future<int> queryCategoriasRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table_Categoria'));
  }
  Future<int> queryIngresosRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table_Ingresos'));
  }
  Future<int> queryGastosRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table_Gastos'));
  }

  Future<int> ConsultaTotalIngresos() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT SUM(columnMontoIngresos) FROM $table_Ingresos'));
  }
  Future<int> ConsultaTotalGastos() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT SUM(columnMontoGastos) FROM $table_Gastos'));
  }


  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table_Categoria, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete_cateoria(int id) async {
    Database db = await instance.database;
    return await db.delete(table_Categoria, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<int> delete_ingresos(int id) async {
    Database db = await instance.database;
    return await db.delete(table_Ingresos, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<int> delete_gatos(int id) async {
    Database db = await instance.database;
    return await db.delete(table_Gastos, where: '$columnId = ?', whereArgs: [id]);
  }
}