import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../modelos/cliente_modelo.dart';

class DetalleCliente extends StatelessWidget {
  final ClienteModelo cliente;

  DetalleCliente({required this.cliente});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              "Detalle Cliente",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 31, 30, 30),
              ),
            ),
            SizedBox(height: 25),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'Nombre: ${cliente.persona.nombre}',
                      /*style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),*/
                    ),
                    subtitle: Text(
                      'Apellido: ${cliente.persona.apellidos}',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'DNI: ${cliente.persona.dni}',
                    ),
                    subtitle: Text(
                      'Teléfono: ${cliente.persona.telefono}',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}