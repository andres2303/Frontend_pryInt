import 'dart:convert';

class VentaModel {
  int idVenta;
  dynamic numVenta;
  double cambio;
  String ruc;
  String estado;
  String moneda;
  double totalVenta;
  String metodoPago;
  String fecnaVenta;
  UsuarioModel usuario;
  TrabajadorModel trabajador;
  ClienteModel cliente;

  VentaModel({
    required this.idVenta,
    required this.numVenta,
    required this.cambio,
    required this.ruc,
    required this.estado,
    required this.moneda,
    required this.totalVenta,
    required this.metodoPago,
    required this.fecnaVenta,
    required this.usuario,
    required this.trabajador,
    required this.cliente,
  });

  factory VentaModel.fromJson(Map<String, dynamic> json) {
    return VentaModel(
      idVenta: json['idVenta'],
      numVenta: json['numVenta'],
      cambio: json['cambio'],
      ruc: json['ruc'],
      estado: json['estado'],
      moneda: json['moneda'],
      totalVenta: json['totalVenta'],
      metodoPago: json['metodoPago'],
      fecnaVenta: json['fecnaVenta'],
      usuario: UsuarioModel.fromJson(json['usuario']),
      trabajador: TrabajadorModel.fromJson(json['trabajador']),
      cliente: ClienteModel.fromJson(json['cliente']),
    );
  }
}

class UsuarioModel {
  int idUsuario;
  String email;
  String password;
  String estado;
  String imgPerfil;
  RolModel rol;
  TrabajadorModel trabajador;

  UsuarioModel({
    required this.idUsuario,
    required this.email,
    required this.password,
    required this.estado,
    required this.imgPerfil,
    required this.rol,
    required this.trabajador,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      idUsuario: json['idUsuario'],
      email: json['email'],
      password: json['password'],
      estado: json['estado'],
      imgPerfil: json['imgPerfil'],
      rol: RolModel.fromJson(json['rol']),
      trabajador: TrabajadorModel.fromJson(json['trabajador']),
    );
  }
}

class RolModel {
  int idRol;
  String nombre;

  RolModel({
    required this.idRol,
    required this.nombre,
  });

  factory RolModel.fromJson(Map<String, dynamic> json) {
    return RolModel(
      idRol: json['idRol'],
      nombre: json['nombre'],
    );
  }
}

class TrabajadorModel {
  int idTrabajador;
  String codigo;
  bool estadoLaboral;
  String estado;
  PersonaModel persona;

  TrabajadorModel({
    required this.idTrabajador,
    required this.codigo,
    required this.estadoLaboral,
    required this.estado,
    required this.persona,
  });

  factory TrabajadorModel.fromJson(Map<String, dynamic> json) {
    return TrabajadorModel(
      idTrabajador: json['idTrabajador'],
      codigo: json['codigo'],
      estadoLaboral: json['estadoLaboral'],
      estado: json['estado'],
      persona: PersonaModel.fromJson(json['persona']),
    );
  }
}

class PersonaModel {
  int idPersona;
  String nombre;
  String apellidos;
  int dni;
  int telefono;

  PersonaModel({
    required this.idPersona,
    required this.nombre,
    required this.apellidos,
    required this.dni,
    required this.telefono,
  });

  factory PersonaModel.fromJson(Map<String, dynamic> json) {
    return PersonaModel(
      idPersona: json['idPersona'],
      nombre: json['nombre'],
      apellidos: json['apellidos'],
      dni: json['dni'],
      telefono: json['telefono'],
    );
  }
}

class ClienteModel {
  int idCliente;
  bool estado;
  PersonaModel persona;

  ClienteModel({
    required this.idCliente,
    required this.estado,
    required this.persona,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      idCliente: json['idCliente'],
      estado: json['estado'],
      persona: PersonaModel.fromJson(json['persona']),
    );
  }
}

List<ClienteModel> clienteModeloFromJson(String str) {
  final jsonData = json.decode(str);
  List<ClienteModel> clientes = [];

  for (var item in jsonData) {
    clientes.add(ClienteModel(
      idCliente: item['idCliente'] as int,
      persona: PersonaModel(
        idPersona: item['persona']['idPersona'] as int,
        nombre: item['persona']['nombre'] as String,
        apellidos: item['persona']['apellidos'] as String,
        dni: item['persona']['dni'] as int,
        telefono: item['persona']['telefono'] as int,
      ),
      estado: item['estado'] as bool,
    ));
  }

  return clientes;
}

