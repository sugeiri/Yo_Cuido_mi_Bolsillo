class Categoria_Gastos {
  int ID;
  String Descripcion;

  Categoria_Gastos({this.ID, this.Descripcion});

  static List<Categoria_Gastos> getUsers() {
    return <Categoria_Gastos>[
    Categoria_Gastos(ID:1,Descripcion:'Facturas'),
    //Categoria_Gastos(ID:2,Descripcion:'Facturas'),
    //Categoria_Gastos(ID:3,Descripcion:'Ropa'),
    Categoria_Gastos(ID:4,Descripcion:'Entretenimiento'),
    Categoria_Gastos(ID:5,Descripcion:'Comida'),
   // Categoria_Gastos(ID:6,Descripcion:'Gasolina'),
    //Categoria_Gastos(ID:7,Descripcion:'Regalos'),
    Categoria_Gastos(ID:8,Descripcion:'Salud'),
    //Categoria_Gastos(ID:9,Descripcion:'Hogar'),
    //Categoria_Gastos(ID:10,Descripcion:'Ocio'),
    Categoria_Gastos(ID:11,Descripcion:'Otro'),
    ];
  }
}
class Categoria_Ingresos {
  int ID;
  String Descripcion;

  Categoria_Ingresos({this.ID, this.Descripcion});

  static List<Categoria_Ingresos> getUsers() {
    return <Categoria_Ingresos>[
      Categoria_Ingresos(ID:12,Descripcion:'Premio'),
      Categoria_Ingresos(ID:13,Descripcion:'Sueldo'),
      Categoria_Ingresos(ID:14,Descripcion:'Otro'),

    ];
  }
}