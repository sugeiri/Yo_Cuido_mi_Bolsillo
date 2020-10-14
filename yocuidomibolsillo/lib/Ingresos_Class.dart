class Ingresos {
  int _id;
  int categoria;
  String fecha;
  String descripcion;
  int monto;
  Ingresos(this._id,
           this.categoria,
           this.fecha,
           this.monto,
           this.descripcion);
  Ingresos.fromMap(dynamic obj) {
    this._id= obj['_id'];
    this.categoria= obj['categoria'];
    this.fecha= obj['fecha'];
    this.monto= obj['monto'];
    this.descripcion= obj['descripcion'];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["_id"] = _id;
    map["categoria"] = categoria;
    map["fecha"] = fecha;
    map["monto"] = monto;
    map["descripcion"] = descripcion;
    return map;
  }
}
class Gastos {
  int _id;
  int categoria;
  String fecha;
  int monto;
  String descripcion;
  Gastos(this._id,
      this.categoria,
      this.fecha,
      this.monto,
      this.descripcion);
  Gastos.fromMap(dynamic obj) {
    this._id= obj['_id'];
    this.categoria= obj['categoria'];
    this.fecha= obj['fecha'];
    this.monto= obj['monto'];
    this.descripcion= obj['descripcion'];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["_id"] = _id;
    map["categoria"] = categoria;
    map["fecha"] = fecha;
    map["monto"] = monto;
    map["descripcion"] = descripcion;
    return map;
  }
}

class Categoria {
  int _id;
  String descripcion;
  String tipo;
  Categoria(this._id,
      this.descripcion,
      this.tipo,);
  Categoria.fromMap(dynamic obj) {
    this._id= obj['_id'];
    this.descripcion= obj['descripcion'];
    this.tipo= obj['tipo'];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["_id"] = _id;
    map["descripcion"] = descripcion;
    map["tipo"] = tipo;
    return map;
  }
}