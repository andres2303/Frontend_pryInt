import 'dart:convert';

class Persona {
  final String nombre;
  final String dni;
  final String apellidos;
  final String telefono;

  Persona({
    required this.nombre,
    required this.apellidos,
    required this.dni,
    required this.telefono,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellidos': apellidos,
      'dni': dni,
      'telefono': telefono,
    };
  }
}

class ClienteModelo {
  String idCliente;
  Persona persona; 
  bool estado;

  ClienteModelo({
    required this.idCliente,
    required this.persona, 
    this.estado = true, 
  });

  factory ClienteModelo.fromJson(Map<String, dynamic> json) {
    return ClienteModelo(
      idCliente: json['idCliente'].toString(),
      persona: Persona(
        nombre: json['persona']['nombre'] as String,
        apellidos: json['persona']['apellidos'] as String,
        dni: json['persona']['dni'] .toString(),
        telefono: json['persona']['telefono'].toString(),
      ),
      estado: json['estado'] as bool, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCliente': idCliente,
      'persona': {
        'nombre': persona.nombre,
        'apellidos': persona.apellidos,
        'dni': persona.dni,
        'telefono': persona.telefono,
      },
      'estado': estado,
    };
  }
}

List<ClienteModelo> clienteModeloFromJson(String str) {
  final jsonData = json.decode(str);
  List<ClienteModelo> clientes = [];

  for (var item in jsonData) {
    clientes.add(ClienteModelo(
      idCliente: item['idCliente'].toString(),
      persona: Persona(
        nombre: item['persona']['nombre'] as String,
        apellidos: item['persona']['apellidos'] as String,
        dni: item['persona']['dni'].toString(),
        telefono: item['persona']['telefono'].toString(),
      ),
      estado: item['estado'] as bool,
    ));
  }

  return clientes;
}
