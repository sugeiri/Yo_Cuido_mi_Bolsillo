import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:yocuidomibolsillo/sqllite.dart';
import 'package:intl/intl.dart';
import 'user.dart';

final dbHelper = DatabaseHelper.instance;
List LCategorias = new List();
List LCategorias_G = new List();

List<Categoria_Gastos> C_Gastos;
List<Categoria_Ingresos> G_Ingresos;

TextEditingController TextIngreso = new TextEditingController();
TextEditingController TextGastos = new TextEditingController();

void main() {
  runApp(Transacciones());
}

class Transacciones extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransaccionesPageState();
  }
}

class _TransaccionesPageState extends State<Transacciones> {
  int current_Id = 0;
  int current_IdG = 0;
  Categoria_Ingresos selectedCatIng;
  Categoria_Gastos selectedCatGastos;
  int selectedRadio;
  int selectedRadioTile;

  int selectedRadio_G;
  int selectedRadioTile_G;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    G_Ingresos = Categoria_Ingresos.getUsers();

    selectedRadio_G = 0;
    selectedRadioTile_G = 0;
    C_Gastos = Categoria_Gastos.getUsers();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  setSelectedUser(Categoria_Ingresos user) {
    setState(() {
      selectedCatIng = user;
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    for (Categoria_Ingresos CatIng in G_Ingresos) {
      widgets.add(
        RadioListTile(
          value: CatIng,
          groupValue: selectedCatIng,
          title: Text(CatIng.Descripcion),
          onChanged: (currentUser) {
            current_Id = currentUser.ID;
            // print(current_Id);
            setSelectedUser(currentUser);
          },
          selected: selectedCatIng == CatIng,
          activeColor: Colors.green,
        ),
      );
    }
    setState(() {});
    return widgets;
  }

  setSelectedRadioTile_G(int val) {
    setState(() {
      selectedRadioTile_G = val;
    });
  }

  setSelectedUser_G(Categoria_Gastos user) {
    setState(() {
      selectedCatGastos = user;
    });
  }

  List<Widget> createRadioListUsers_G() {
    List<Widget> widgets = [];
    for (Categoria_Gastos CatGastos in C_Gastos) {
      widgets.add(
        RadioListTile(
          value: CatGastos,
          groupValue: selectedCatGastos,
          title: Text(CatGastos.Descripcion),
          onChanged: (currentUser) {
            current_IdG = currentUser.ID;
            // print(current_Id);
            setSelectedUser_G(currentUser);
          },
          selected: selectedCatGastos == CatGastos,
          activeColor: Colors.green,
        ),
      );
    }
    setState(() {});
    return widgets;
  }

  ///////////////////////////////////////////////
  bool _isEditingText = false;
  TextEditingController _editingController;
  String initialText = "Initial Text";
  List _cities =
      new List(); //LCategorias;//["Cluj-Napoca", "Bucuresti", "Timisoara", "Brasov", "Constanta"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;
  List<DropdownMenuItem<String>> _dropDownMenuItems_G;
  String _currentCity_G;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String valor = '';
    // _Consulta_Categorias();
    // _Consulta_Categorias_G();
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              //toolbarHeight: 100,
              backgroundColor: Colors.black87,
              bottom: TabBar(
                tabs: [
                  Tab(
                      text: "Ingresos",
                      icon: Icon(Icons.attach_money, color: Colors.green)),
                  Tab(
                      text: "Gastos",
                      icon: Icon(Icons.money_off, color: Colors.red)),
                ],
              ),
            ),
            body:  TabBarView(
              children: [
                Container(
                  height: 1000,
                  width: 1000,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        children:
                        createRadioListUsers(),
                      ),
                      TextField(
                        controller: TextIngreso,
                        style: Theme.of(context).textTheme.headline5,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered
                      ),
                      /*TextFormField(
                          keyboardType: TextInputType.number,
                          //textInputAction: TextInputAction.continueAction,
                        ),*/
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Text('Guardar'),
                            color: Colors.green,
                            onPressed: _insert_Ingresos,
                          ),
                        ],
                      ),
                    ],
                  ) ,
                ),
                Container(
                    height: 1000,
                    width: 1000,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Column(
                          children:
                          createRadioListUsers_G(),
                        ),
                        TextField(
                          controller: TextGastos,
                          style: Theme.of(context).textTheme.headline5,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                        ),
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: Text('Guardar'),
                              color: Colors.green,
                              onPressed: _insert_Gastos,
                            ),
                          ],
                        ),
                      ],
                    )
                ),
              ],
            ),
        ),
      ),
    );
  }

  void _insert_Ingresos() async {
    final allRows = await dbHelper.queryIngresosRowCount();
    DateTime now = DateTime.now();
    String ii_fecha = DateFormat('yyyy-MM-dd').format(now);
    Map<String, dynamic> row = {
      DatabaseHelper.columnIdIngresos: allRows + 1,
      DatabaseHelper.columnCategoriaIngresos: current_Id,
      DatabaseHelper.columnFechaIngresos: ii_fecha,
      DatabaseHelper.columnMontoIngresos: int.parse(TextIngreso.text),
    };
    final id = await dbHelper.insertIngresos_(row);
//    print('inserted row id: $id');
    setState(() {
      TextIngreso.text = "";
    });
  }

  void _insert_Gastos() async {
    final allRows = await dbHelper.queryGastosRowCount();
    DateTime now = DateTime.now();
    String ii_fecha = DateFormat('yyyy-MM-dd').format(now);
    Map<String, dynamic> row = {
      DatabaseHelper.columnIdGastos: allRows + 1,
      DatabaseHelper.columnCategoriaGastos: current_IdG,
      DatabaseHelper.columnFechaGastos: ii_fecha,
      DatabaseHelper.columnMontoGastos: int.parse(TextGastos.text),
    };
    final id = await dbHelper.insertGastos_(row);
    //  print('inserted row id: $id');
    setState(() {
      TextGastos.text = "";
    });
  }

/*void _Consulta_Categorias() async {
    List ii_Lcategoria = new List();
    final Categoria = await dbHelper.getCategoriaIngreso();
    Categoria.forEach((row) {
      if (row.tipo.toString().toUpperCase() == 'I') {
        String l = row.descripcion.toString();

        ii_Lcategoria.add(l);
      }
    });
    LCategorias = ii_Lcategoria;
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    setState(() {});
  }*/

/* void _Consulta_Categorias_G() async {
    List ii_Lcategoria = new List();
    final Categoria = await dbHelper.getCategoriaIngreso();
    Categoria.forEach((row) {
      if (row.tipo.toString().toUpperCase() == 'G') {
        String l = row.descripcion.toString();

        ii_Lcategoria.add(l);
      }
    });
    LCategorias_G = ii_Lcategoria;
    _dropDownMenuItems_G = getDropDownMenuItems_G();
    _currentCity_G = _dropDownMenuItems_G[0].value;
    setState(() {});
  }*/
}
