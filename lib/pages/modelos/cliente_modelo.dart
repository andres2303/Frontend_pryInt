import 'dart:convert';

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
      persona: Persona.fromJson(json['persona']),
      estado: json['estado'] as bool, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCliente': idCliente,
      'persona': persona.toJson(),
      'estado': estado,
    };
  }
}

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

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      nombre: json['nombre'] as String,
      apellidos: json['apellidos'] as String,
      dni: json['dni'].toString(),
      telefono: json['telefono'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellidos': apellidos,
      'dni': dni,
      'telefono': telefono,
    };
  }
}

List<ClienteModelo> clienteModeloFromJson(String str) {
  final jsonData = json.decode(str);
  return List<ClienteModelo>.from(jsonData.map((item) => ClienteModelo.fromJson(item)));
}