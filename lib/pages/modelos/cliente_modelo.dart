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
  final String idCliente;
  final String nombrePersona;
  final String apellidosPersona;
  final String dniPersona;
  final String telefonoPersona;

  ClienteModelo({
    required this.idCliente,
    required this.nombrePersona,
    required this.apellidosPersona,
    required this.dniPersona,
    required this.telefonoPersona,
  });

  factory ClienteModelo.fromJson(Map<String, dynamic> json) {
    return ClienteModelo(
      idCliente: json['idCliente'].toString(),
      nombrePersona: json['persona']['nombre'] as String,
      apellidosPersona: json['persona']['apellidos'] as String,
      dniPersona: json['persona']['dni'].toString(),
      telefonoPersona: json['persona']['telefono'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCliente': idCliente,
      'persona': {
        'nombre': nombrePersona,
        'apellidos': apellidosPersona,
        'dni': dniPersona,
        'telefono': telefonoPersona,
      },
    };
  }
}
