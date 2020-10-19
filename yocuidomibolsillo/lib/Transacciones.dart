import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:yocuidomibolsillo/sqllite.dart';
import 'package:intl/intl.dart';

final dbHelper = DatabaseHelper.instance;
List LCategorias = new List();
List LCategorias_G = new List();
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
    _Consulta_Categorias();
    _Consulta_Categorias_G();
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
          body: TabBarView(
            children: [
              Container(
                  height: 1000,
                  width: 1000,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                         DropdownButton(
                          value: _currentCity,
                          items: _dropDownMenuItems,
                          onChanged: changedDropDownItem,
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
                    DropdownButton(
                      value: _currentCity_G,
                      items: _dropDownMenuItems_G,
                      onChanged: changedDropDownItemG,
                    ),
                    /*TextFormField(
                      keyboardType: TextInputType.number,
                      //textInputAction: TextInputAction.continueAction,
                    ),*/
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
      DatabaseHelper.columnIdIngresos : allRows+1,
      DatabaseHelper.columnCategoriaIngresos : 12,
      DatabaseHelper.columnFechaIngresos : ii_fecha,
      DatabaseHelper.columnMontoIngresos  : int.parse(TextIngreso.text),
    };
    final id = await dbHelper.insertIngresos_(row);
    print('inserted row id: $id');
    setState(() {
      TextIngreso.text="";
    });

  }
  void _insert_Gastos() async {
    final allRows = await dbHelper.queryGastosRowCount();
    DateTime now = DateTime.now();
    String ii_fecha = DateFormat('yyyy-MM-dd').format(now);
    Map<String, dynamic> row = {
      DatabaseHelper.columnIdGastos : allRows+1,
      DatabaseHelper.columnCategoriaGastos : 01,
      DatabaseHelper.columnFechaGastos : ii_fecha,
      DatabaseHelper.columnMontoGastos  : int.parse(TextGastos.text),
    };
    final id = await dbHelper.insertGastos_(row);
    print('inserted row id: $id');
    setState(() {
      TextGastos.text="";
    });
  }
  void changedDropDownItem(String selectedCity) {
    //print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentCity = selectedCity;
    });
  }

  void changedDropDownItemG(String selectedCity) {
    //print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentCity_G = selectedCity;
    });
  }
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in LCategorias) {
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.blueGrey))));
    }
    return items;
  }

  void _Consulta_Categorias() async {
    List ii_Lcategoria = new List();
    ii_Lcategoria.add('Seleccione Categoria');
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
  }

  void changedDropDownItem_G(String selectedCity) {
    print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentCity_G = selectedCity;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems_G() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in LCategorias_G) {
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.blueGrey))));
    }
    return items;
  }

  void _Consulta_Categorias_G() async {
    List ii_Lcategoria = new List();
    ii_Lcategoria.add('Seleccione Categoria');
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
  }
}
