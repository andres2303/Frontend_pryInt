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
      'persona': persona.toJson(),
      'estado': estado, // Add this line
    };
  }
}
